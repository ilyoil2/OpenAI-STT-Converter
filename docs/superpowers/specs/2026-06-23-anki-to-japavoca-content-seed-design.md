# Anki → japavoca 콘텐츠 시드 변환 설계서

작성일: 2026-06-23

## 1. 목표

기존 학습 콘텐츠(한자/단어) Anki 덱을 source로 삼아, 새 Django DB `japavoca`의
콘텐츠 테이블(`tbl_content_kanji`, `tbl_content_word`, `tbl_content_wordmeaning`)에
정제·변환하여 적재한다.

기존 `conversion_data/` 스크립트들은 옛 raw PostgreSQL 스키마(`tbl_kanji`,
`tbl_vocabulary`)를 대상으로 했으나, 새 DB는 컬럼 구조·타입·NOT NULL 제약이
다르므로 단순 컬럼명 치환으로는 동작하지 않는다. 따라서 변환 로직을 포함해 재작성한다.

## 2. Source / Target

### Source: Anki SQLite
- 파일: `conversion_data/collection_extracted.anki21`
- 노트타입(mid)별로 읽는다. grammar 노트(`2. JLPT 문법`)는 읽지 않으므로 자동 제외된다.

| 노트타입 | mid | 건수 | 대상 |
|---|---|---|---|
| 1. JLPT 어휘 | 1728981502167 | 9181 | 단어 |
| 3. 상용한자 읽기 | 1730037663052 | 2136 | 한자 |
| 4. 상용한자 쓰기 | 1730045851294 | 2136 | 한자(중복) |

> 한자 노트타입 2개는 같은 한자(읽기/쓰기 덱)이므로 `character` UNIQUE 제약 +
> `ON CONFLICT DO NOTHING`으로 중복을 흡수한다.

`flds`는 `\x1f`(char 31)로 구분된 위치 기반 필드다.

### Target: PostgreSQL `japavoca` (Django 관리)
연결 정보:
```
DB_ENGINE=postgresql  DB_NAME=japavoca
DB_USER=root  DB_PASSWORD=1234  DB_HOST=127.0.0.1  DB_PORT=5432
```
테이블은 Django 마이그레이션이 이미 생성함. **CREATE TABLE 하지 않는다.**

```
tbl_content_kanji(
  id, character varchar(10) NOT NULL UNIQUE, meaning_ko text NOT NULL,
  components text NOT NULL, stroke_count int (CHECK >=0, NULL 허용),
  on_reading varchar(100) NOT NULL, kun_reading varchar(100) NOT NULL,
  meaning_ja text NOT NULL, jlpt_level varchar(2) NULL,
  created_at timestamptz NOT NULL, meaning_ko_detail text NOT NULL)

tbl_content_word(
  id, surface varchar(100) NOT NULL, word_type varchar(10) NOT NULL,
  reading varchar(100) NOT NULL, pos varchar(50) NOT NULL,
  jlpt_level varchar(2) NULL, created_at timestamptz NOT NULL)

tbl_content_wordmeaning(
  id, sense_no int NOT NULL (CHECK >=0), meaning_ko text NOT NULL,
  note text NOT NULL, created_at timestamptz NOT NULL,
  word_id bigint NOT NULL FK->tbl_content_word(id),
  UNIQUE(word_id, sense_no))
```

> NOT NULL text 컬럼은 빈 값일 때 `''`(빈 문자열)로 넣는다. `created_at`은
> `now()` 또는 파이썬 `timezone.now()` 상응 값으로 채운다.

## 3. 필드 매핑

### 3.1 한자 (mid 1730037663052 / 1730045851294 → tbl_content_kanji)

| Anki 필드(ord) | 새 컬럼 | 처리 |
|---|---|---|
| 0 한자 | character | 복사 (varchar(10) 절단) |
| 1 훈음 | meaning_ko_detail | 복사, NULL→'' |
| 2 훈음(일상무따) | meaning_ko | 복사, NULL→'' |
| 4 모양자 | components | 복사, NULL→'' |
| 5 획수 | stroke_count | 정수 추출 ("1획"→1, 없으면 NULL) |
| 8 음독 | on_reading | 복사, NULL→'' (varchar(100) 절단) |
| 9 훈독 | kun_reading | 복사, NULL→'' (varchar(100) 절단) |
| 10 의미 | meaning_ja | `<br>` 제거 후 저장 |
| 11 한자검정 | jlpt_level | 급→N 변환표 적용 |
| 3 부수, 6 일본부수, 7 일본획수 | — | 버림 |

### 3.2 단어 (mid 1728981502167 → tbl_content_word + tbl_content_wordmeaning)

| Anki 필드(ord) | 새 컬럼 | 처리 |
|---|---|---|
| 0 단어 | surface | 복사 (varchar(100) 절단) |
| 1 루비 | word_type / reading | 아래 규칙 |
| 2 한자 | word_type / reading | 아래 규칙 |
| 3 품사 | pos | POS_MAP 정확매칭→영문, 없으면 원문(varchar(50) 절단) |
| 4 의미 | wordmeaning 행들 | sense_no별 분리 |
| 5 예문, 6 넘버 | — | 버림 |
| (level) | jlpt_level | **항상 NULL** (Anki에 없음, 채우지 않기로 결정) |

**word_type / reading 규칙**
- 루비(1)가 비어있지 않음 → `word_type='kanji'`, `reading=루비`
- 루비(1)가 빔 → `word_type='kana'`, `reading=한자(2)`
- `reading`은 NOT NULL varchar(100): 최종값이 비면 `''`, 길면 절단

## 4. 변환 로직 상세

### 4.1 stroke_count (한자 획수)
```python
m = re.search(r'(\d+)', field)
stroke_count = int(m.group(1)) if m else None
```

### 4.2 jlpt_level (한자검정 급→N)
NFKC 정규화 후 `급` 숫자 추출, `準` 여부 판단.
```
일반: 10,9→N5 | 8,7→N4 | 6,5→N3 | 4,3→N2 | 2,1→N1
準:   準2→N2  | 準1→N1
매칭 안 됨 / 빈 값 → None
```
예: `"１０級(きゅう)"`→N5, `"準(じゅん)２級(きゅう)"`→N2.

### 4.3 meaning_ja `<br>` 제거 (한자)
`BeautifulSoup(raw, 'html.parser').get_text(separator='\n').strip()`
(부가 furigana 괄호는 유지.)

### 4.4 pos (단어 품사)
```python
POS_MAP = {
  '명사':'noun','동사':'verb','형용사':'adjective','な형용사':'na_adjective',
  'い형용사':'i_adjective','부사':'adverb','조사':'particle','접속사':'conjunction',
  '감동사':'interjection','접두사':'prefix','접미사':'suffix',
}
pos = POS_MAP.get(text, text)  # 복합값('명사 동사' 등)은 원문 그대로, 50자 절단
```
빈 값 → `''`.

### 4.5 wordmeaning 분리 (단어 의미)
```python
text = BeautifulSoup(raw, 'html.parser').get_text(' ').strip()  # HTML이면 텍스트화
parts = re.split(r'\s*\d+\.\s*', text)        # "1. 머리 2. 두부" → ['','머리','두부']
parts = [p.strip() for p in parts if p.strip()]
# 번호 없으면 parts == [전체텍스트]
```
각 part → `WordMeaning(sense_no=i+1, meaning_ko=part, note='')`.
빈 결과면 wordmeaning 행 생성 안 함. (`note`의 부가설명 추출은 이번 범위 밖, 항상 `''`.)

## 5. 파일별 변경 계획

### 5.1 `kanjify_data.py` (대폭 재작성 — 메인 로더)
- 연결 대상을 `japavoca`로 변경 (`.env` 또는 상수).
- `CREATE TABLE` 블록 전부 제거.
- 의존성: `psycopg2`, `beautifulsoup4`(신규), 표준 `sqlite3`/`re`/`unicodedata`.
- 처리 순서:
  1. Anki 열기.
  2. 한자 노트(mid 2개) 읽기 → 변환 → `tbl_content_kanji`에
     `execute_values` + `ON CONFLICT (character) DO NOTHING` bulk insert.
  3. 단어 노트(mid 1개) 읽기 → `tbl_content_word` bulk insert 후 각 word의 id를 받아
     `tbl_content_wordmeaning` bulk insert. (surface 기준 매핑 또는 RETURNING id 사용.)
  4. 진행 로그 + 최종 요약(한자 N건/단어 N건/뜻 N건).
- 에러 처리: 단건 파싱 실패는 로그+스킵, DB 연결 실패는 즉시 중단.

### 5.2 `insert_kanji.sql` (새 스키마로 변환)
- 부수/특수 한자 64건을 `tbl_content_kanji(character, meaning_ko, meaning_ko_detail,
  components, stroke_count, on_reading, kun_reading, meaning_ja, jlpt_level)`로 INSERT.
  - 기존 `korean_reading`→`meaning_ko`, `korean_reading_detail`→`meaning_ko_detail`,
    `etymology`→`components`, `'10획'`→`10`(int), NULL text→`''`,
    `jlpt_level`은 데이터에 없으니 NULL.
  - `ON CONFLICT (character) DO NOTHING`.
- 인덱스 생성 구문은 Django가 이미 만든 인덱스와 중복이므로 제거.
- 끝의 `UPDATE`(立/単) → `SET components = ... WHERE character = ...`로 변경.

### 5.3 `cleanup_data.sql` (새 스키마로 수정 — dedup 유지)
- 대상 테이블을 `tbl_content_kanji`/`tbl_content_word`로 교체.
- 한자: `character` UNIQUE라 사실상 중복 없음 → 안전망으로 동일내용 dedup만 유지.
- 단어: `surface, word_type, reading, pos, jlpt_level` 동일 그룹에서 MIN(id)만 남기고
  삭제. 삭제 전 연결된 `tbl_content_wordmeaning`를 함께 정리(또는 FK CASCADE 고려).
- 옛 `stroke_count_ko NOT LIKE '<div ...>'` 필터는 노트타입 분리로 불필요 → 제거.

### 5.4 삭제할 파일
- `assign_jlpt_levels.py` — 단어 레벨용. 삭제.
- `update_jlpt_level.py` — 단어 레벨용. 삭제.

## 6. 범위 밖 (Out of scope)
- 단어 JLPT 레벨 채우기 (사용자 결정: 비워둠/NULL).
- `wordmeaning.note` 부가설명 추출.
- Django 마이그레이션/모델 변경 (이미 존재).

## 7. 완료 기준
1. `kanjify_data.py` 실행 → 에러 없이 `tbl_content_kanji`/`tbl_content_word`/
   `tbl_content_wordmeaning`에 데이터 적재, 건수 요약 출력.
2. `tbl_content_kanji.character` 중복 없음, `stroke_count`는 정수/NULL,
   한자 `jlpt_level`은 N1~N5/NULL.
3. `tbl_content_word.jlpt_level`은 전부 NULL, `pos` 채워짐, 단어별 `wordmeaning`
   sense_no가 1부터 연속.
4. `insert_kanji.sql` 실행 → 부수/특수 한자 추가, 충돌 시 무시.
5. `cleanup_data.sql` 실행 → 중복 단어 정리, 에러 없음.
6. `assign_jlpt_levels.py`, `update_jlpt_level.py` 삭제됨.
