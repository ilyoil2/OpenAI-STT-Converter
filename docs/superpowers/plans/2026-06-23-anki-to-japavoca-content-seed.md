# Anki → japavoca 콘텐츠 시드 변환 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Anki 덱(`collection_extracted.anki21`)을 source로 한자/단어 콘텐츠를 변환해 새 Django DB `japavoca`의 `tbl_content_kanji` / `tbl_content_word` / `tbl_content_wordmeaning`에 적재한다.

**Architecture:** `kanjify_data.py`를 "Anki 읽기 → 순수 변환 함수 → psycopg2 bulk insert" 구조로 재작성한다. 순수 변환 함수는 모듈 최상위에 두고 `if __name__ == "__main__"` 가드 아래에서 DB 작업을 수행하여, 변환 로직을 단위 테스트로 검증한다. SQL 파일 2개는 새 스키마로 수정하고, 단어 레벨용 스크립트 2개는 삭제한다.

**Tech Stack:** Python 3, `sqlite3`(stdlib), `psycopg2`, `re`/`unicodedata`/`html`(stdlib). 외부 신규 의존성 없음(BeautifulSoup 불필요). 테스트는 `pytest`.

## Global Constraints

- 대상 DB: `japavoca` / host `127.0.0.1` / port `5432` / user `root` / password `1234` (env override 허용).
- 대상 테이블은 Django가 이미 생성함 — **CREATE TABLE 금지**.
- NOT NULL text 컬럼(`meaning_ko`, `components`, `on_reading`, `kun_reading`, `meaning_ja`, `meaning_ko_detail`, `surface`, `word_type`, `reading`, `pos`, `note`)은 빈 값일 때 `''`로 넣는다.
- 컬럼 길이: `character` ≤10, `surface`/`reading`/`on_reading`/`kun_reading` ≤100, `pos` ≤50, `word_type` ≤10, `jlpt_level` ≤2 — 초과 시 절단.
- `created_at`은 INSERT 시 SQL `now()`로 채운다.
- 단어 `jlpt_level`은 **항상 NULL**.
- Anki `flds`는 `\x1f`(chr 31) 구분 위치 기반 필드.
- 노트타입 mid: 단어=`1728981502167`, 한자=`1730037663052` 및 `1730045851294`.

---

### Task 1: 순수 변환 함수 — 획수/JLPT 변환 (TDD)

**Files:**
- Modify: `conversion_data/kanjify_data.py` (전면 재작성 시작; 이 태스크는 상단 import + 두 함수만)
- Test: `conversion_data/test_content_transforms.py`

**Interfaces:**
- Produces:
  - `extract_stroke_count(raw: str | None) -> int | None`
  - `kanji_jlpt_level(raw: str | None) -> str | None`

- [ ] **Step 1: Write the failing test**

`conversion_data/test_content_transforms.py`:
```python
from kanjify_data import extract_stroke_count, kanji_jlpt_level


def test_extract_stroke_count_basic():
    assert extract_stroke_count("1획") == 1
    assert extract_stroke_count("16획") == 16

def test_extract_stroke_count_empty():
    assert extract_stroke_count("") is None
    assert extract_stroke_count(None) is None
    assert extract_stroke_count("획수없음") is None

def test_kanji_jlpt_level_normal():
    assert kanji_jlpt_level("１０級(きゅう)") == "N5"
    assert kanji_jlpt_level("９級(きゅう)") == "N5"
    assert kanji_jlpt_level("８級") == "N4"
    assert kanji_jlpt_level("５級") == "N3"
    assert kanji_jlpt_level("３級") == "N2"
    assert kanji_jlpt_level("２級") == "N1"

def test_kanji_jlpt_level_jun():
    assert kanji_jlpt_level("準(じゅん)２級(きゅう)") == "N2"
    assert kanji_jlpt_level("準１級") == "N1"

def test_kanji_jlpt_level_unmapped():
    assert kanji_jlpt_level("") is None
    assert kanji_jlpt_level(None) is None
    assert kanji_jlpt_level("급외") is None
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: FAIL — `ImportError: cannot import name 'extract_stroke_count'` (또는 ModuleNotFound 시 kanjify_data 내용 부재)

- [ ] **Step 3: Write minimal implementation**

`conversion_data/kanjify_data.py` 상단을 아래로 시작(기존 내용은 이후 태스크에서 교체되므로 파일을 이 내용으로 새로 작성):
```python
import re
import unicodedata

_JLPT_NORMAL = {10: "N5", 9: "N5", 8: "N4", 7: "N4",
                6: "N3", 5: "N3", 4: "N2", 3: "N2", 2: "N1", 1: "N1"}
_JLPT_JUN = {2: "N2", 1: "N1"}


def extract_stroke_count(raw):
    if not raw:
        return None
    m = re.search(r"(\d+)", unicodedata.normalize("NFKC", raw))
    return int(m.group(1)) if m else None


def kanji_jlpt_level(raw):
    if not raw:
        return None
    s = unicodedata.normalize("NFKC", raw)
    has_jun = "準" in s
    m = re.search(r"(\d+)\s*級", s)
    if not m:
        return None
    n = int(m.group(1))
    return _JLPT_JUN.get(n) if has_jun else _JLPT_NORMAL.get(n)
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: PASS (5 passed)

- [ ] **Step 5: Commit**

```bash
git add conversion_data/kanjify_data.py conversion_data/test_content_transforms.py
git commit -m "feat(conversion): add stroke_count and kanji jlpt transforms"
```

---

### Task 2: 순수 변환 함수 — HTML 정리/품사 매핑 (TDD)

**Files:**
- Modify: `conversion_data/kanjify_data.py`
- Test: `conversion_data/test_content_transforms.py`

**Interfaces:**
- Produces:
  - `strip_html(raw: str | None) -> str` — `<br>`는 개행으로, 그 외 태그 제거, 엔티티 unescape
  - `map_pos(raw: str | None) -> str` — POS_MAP 정확매칭 시 영문, 없으면 원문(≤50)
  - `nz(x: str | None, maxlen: int | None = None) -> str` — None/공백 정리 + 절단

- [ ] **Step 1: Write the failing test**

`test_content_transforms.py`에 추가:
```python
from kanjify_data import strip_html, map_pos, nz


def test_strip_html_br():
    assert strip_html("가<br>나<br/>다") == "가\n나\n다"

def test_strip_html_tags_and_entity():
    assert strip_html("<em>명사</em>&amp;") == "명사&"

def test_strip_html_empty():
    assert strip_html("") == ""
    assert strip_html(None) == ""

def test_map_pos_known():
    assert map_pos("명사") == "noun"
    assert map_pos("동사") == "verb"

def test_map_pos_compound_passthrough():
    assert map_pos("명사 동사") == "명사 동사"

def test_map_pos_empty():
    assert map_pos("") == ""
    assert map_pos(None) == ""

def test_nz():
    assert nz(None) == ""
    assert nz("  x  ") == "x"
    assert nz("abcdef", 3) == "abc"
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: FAIL — `cannot import name 'strip_html'`

- [ ] **Step 3: Write minimal implementation**

`kanjify_data.py`에 추가:
```python
import html as _html

POS_MAP = {
    "명사": "noun", "동사": "verb", "형용사": "adjective",
    "な형용사": "na_adjective", "い형용사": "i_adjective",
    "부사": "adverb", "조사": "particle", "접속사": "conjunction",
    "감동사": "interjection", "접두사": "prefix", "접미사": "suffix",
}


def strip_html(raw):
    if not raw:
        return ""
    s = re.sub(r"<br\s*/?>", "\n", raw, flags=re.IGNORECASE)
    s = re.sub(r"<[^>]+>", "", s)
    return _html.unescape(s)


def nz(x, maxlen=None):
    s = (x or "").strip()
    return s[:maxlen] if maxlen else s


def map_pos(raw):
    t = (raw or "").strip()
    if not t:
        return ""
    return POS_MAP.get(t, t)[:50]
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: PASS (12 passed)

- [ ] **Step 5: Commit**

```bash
git add conversion_data/kanjify_data.py conversion_data/test_content_transforms.py
git commit -m "feat(conversion): add strip_html, map_pos, nz helpers"
```

---

### Task 3: 순수 변환 함수 — 의미 분리/단어 타입·읽기 (TDD)

**Files:**
- Modify: `conversion_data/kanjify_data.py`
- Test: `conversion_data/test_content_transforms.py`

**Interfaces:**
- Consumes: `strip_html` (Task 2)
- Produces:
  - `split_meanings(raw: str | None) -> list[str]`
  - `word_type_and_reading(ruby: str | None, kanji_field: str | None) -> tuple[str, str]`

- [ ] **Step 1: Write the failing test**

`test_content_transforms.py`에 추가:
```python
from kanjify_data import split_meanings, word_type_and_reading


def test_split_meanings_numbered():
    assert split_meanings("1. 머리 2. 두부 3. 두발") == ["머리", "두부", "두발"]

def test_split_meanings_single():
    assert split_meanings("정기휴일") == ["정기휴일"]

def test_split_meanings_empty():
    assert split_meanings("") == []
    assert split_meanings(None) == []

def test_word_type_kanji():
    assert word_type_and_reading("あう", "") == ("kanji", "あう")

def test_word_type_kana():
    assert word_type_and_reading("", "私") == ("kana", "私")
    assert word_type_and_reading("", "") == ("kana", "")
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: FAIL — `cannot import name 'split_meanings'`

- [ ] **Step 3: Write minimal implementation**

`kanjify_data.py`에 추가:
```python
def split_meanings(raw):
    text = strip_html(raw).strip()
    if not text:
        return []
    parts = re.split(r"\s*\d+\.\s*", text)
    return [p.strip() for p in parts if p.strip()]


def word_type_and_reading(ruby, kanji_field):
    ruby = (ruby or "").strip()
    if ruby:
        return "kanji", ruby[:100]
    return "kana", (kanji_field or "").strip()[:100]
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: PASS (17 passed)

- [ ] **Step 5: Commit**

```bash
git add conversion_data/kanjify_data.py conversion_data/test_content_transforms.py
git commit -m "feat(conversion): add split_meanings and word_type_and_reading"
```

---

### Task 4: Anki 읽기 + 행 빌더 (TDD)

**Files:**
- Modify: `conversion_data/kanjify_data.py`
- Test: `conversion_data/test_content_transforms.py`

**Interfaces:**
- Consumes: 모든 Task 1–3 함수
- Produces:
  - `build_kanji_row(fields: list[str]) -> tuple` — 컬럼 순서: `(character, meaning_ko, components, stroke_count, on_reading, kun_reading, meaning_ja, jlpt_level, meaning_ko_detail)`
  - `build_word(fields: list[str]) -> tuple[tuple, list[str]]` — `((surface, word_type, reading, pos, jlpt_level), [meaning_ko, ...])`
  - `parse_fields(flds: str) -> list[str]` — `\x1f` 분리

- [ ] **Step 1: Write the failing test**

`test_content_transforms.py`에 추가:
```python
from kanjify_data import parse_fields, build_kanji_row, build_word

KANJI_FLDS = "\x1f".join([
    "一", "한 일", "하나 일", "一부", "一(한 일)", "1획",
    "일본부수", "1画", "イチ・イツ", "ひと", "뜻1<br>뜻2", "１０級(きゅう)",
])
WORD_FLDS = "\x1f".join(["会う", "あう", "", "동사", "1. 만나다 2. 대면하다", "예문HTML", "1"])


def test_parse_fields():
    assert parse_fields("a\x1fb\x1fc") == ["a", "b", "c"]

def test_build_kanji_row():
    row = build_kanji_row(parse_fields(KANJI_FLDS))
    assert row == ("一", "하나 일", "一(한 일)", 1,
                   "イチ・イツ", "ひと", "뜻1\n뜻2", "N5", "한 일")

def test_build_word():
    head, meanings = build_word(parse_fields(WORD_FLDS))
    assert head == ("会う", "kanji", "あう", "verb", None)
    assert meanings == ["만나다", "대면하다"]
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: FAIL — `cannot import name 'parse_fields'`

- [ ] **Step 3: Write minimal implementation**

`kanjify_data.py`에 추가:
```python
def parse_fields(flds):
    return flds.split("\x1f")


def _f(fields, i):
    return fields[i] if i < len(fields) else ""


def build_kanji_row(fields):
    return (
        nz(_f(fields, 0), 10),                  # character
        nz(_f(fields, 2)),                      # meaning_ko (훈음 일상무따)
        nz(_f(fields, 4)),                      # components (모양자)
        extract_stroke_count(_f(fields, 5)),    # stroke_count
        nz(_f(fields, 8), 100),                 # on_reading (음독)
        nz(_f(fields, 9), 100),                 # kun_reading (훈독)
        strip_html(_f(fields, 10)).strip(),     # meaning_ja (의미, <br> 정리)
        kanji_jlpt_level(_f(fields, 11)),       # jlpt_level (한자검정)
        nz(_f(fields, 1)),                      # meaning_ko_detail (훈음)
    )


def build_word(fields):
    word_type, reading = word_type_and_reading(_f(fields, 1), _f(fields, 2))
    head = (
        nz(_f(fields, 0), 100),                 # surface (단어)
        word_type,                              # word_type
        reading,                                # reading
        map_pos(_f(fields, 3)),                 # pos (품사)
        None,                                   # jlpt_level (항상 NULL)
    )
    meanings = split_meanings(_f(fields, 4))    # 의미
    return head, meanings
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: PASS (20 passed)

- [ ] **Step 5: Commit**

```bash
git add conversion_data/kanjify_data.py conversion_data/test_content_transforms.py
git commit -m "feat(conversion): add Anki field parser and row builders"
```

---

### Task 5: DB 적재 오케스트레이션 + --dry-run (수동 검증)

**Files:**
- Modify: `conversion_data/kanjify_data.py` (`main()` + `__main__` 가드 추가)

**Interfaces:**
- Consumes: Task 4 빌더들
- Produces: CLI `python kanjify_data.py [--dry-run]`

- [ ] **Step 1: `main()` 및 가드 구현**

`kanjify_data.py` 하단에 추가:
```python
import os
import sqlite3
import argparse
import psycopg2
from psycopg2.extras import execute_values

ANKI_DB_PATH = os.getenv("ANKI_DB_PATH", "./collection_extracted.anki21")
KANJI_MIDS = (1730037663052, 1730045851294)
WORD_MID = 1728981502167


def pg_connect():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "127.0.0.1"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME", "japavoca"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", "1234"),
    )


def read_anki():
    conn = sqlite3.connect(ANKI_DB_PATH)
    cur = conn.cursor()
    kanji_rows, word_units = [], []
    cur.execute("SELECT mid, flds FROM notes")
    for mid, flds in cur.fetchall():
        fields = parse_fields(flds)
        try:
            if mid in KANJI_MIDS:
                row = build_kanji_row(fields)
                if row[0]:  # character 필수
                    kanji_rows.append(row)
            elif mid == WORD_MID:
                head, meanings = build_word(fields)
                if head[0]:  # surface 필수
                    word_units.append((head, meanings))
        except Exception as e:  # 단건 실패는 스킵
            print(f"⚠️ 파싱 스킵 (mid={mid}): {e}")
    conn.close()
    return kanji_rows, word_units


def insert_kanji(cur, kanji_rows):
    execute_values(
        cur,
        """
        INSERT INTO tbl_content_kanji
          (character, meaning_ko, components, stroke_count, on_reading,
           kun_reading, meaning_ja, jlpt_level, meaning_ko_detail, created_at)
        VALUES %s
        ON CONFLICT (character) DO NOTHING
        """,
        kanji_rows,
        template="(%s,%s,%s,%s,%s,%s,%s,%s,%s, now())",
    )


def insert_words(cur, word_units):
    heads = [u[0] for u in word_units]
    rows = execute_values(
        cur,
        """
        INSERT INTO tbl_content_word
          (surface, word_type, reading, pos, jlpt_level, created_at)
        VALUES %s
        RETURNING id
        """,
        heads,
        template="(%s,%s,%s,%s,%s, now())",
        fetch=True,
    )
    word_ids = [r[0] for r in rows]
    meaning_rows = []
    for word_id, (_, meanings) in zip(word_ids, word_units):
        for i, mk in enumerate(meanings, start=1):
            meaning_rows.append((word_id, i, mk, ""))
    if meaning_rows:
        execute_values(
            cur,
            """
            INSERT INTO tbl_content_wordmeaning
              (word_id, sense_no, meaning_ko, note, created_at)
            VALUES %s
            ON CONFLICT (word_id, sense_no) DO NOTHING
            """,
            meaning_rows,
            template="(%s,%s,%s,%s, now())",
        )
    return len(meaning_rows)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    print("🔄 Anki 읽는 중...")
    kanji_rows, word_units = read_anki()
    print(f"   한자 {len(kanji_rows)}건 / 단어 {len(word_units)}건")

    if args.dry_run:
        print("\n[DRY-RUN] 한자 샘플 3건:")
        for r in kanji_rows[:3]:
            print("  ", r)
        print("[DRY-RUN] 단어 샘플 3건:")
        for u in word_units[:3]:
            print("  ", u)
        return

    conn = pg_connect()
    cur = conn.cursor()
    try:
        insert_kanji(cur, kanji_rows)
        n_meanings = insert_words(cur, word_units)
        conn.commit()
        print(f"✅ 한자 {len(kanji_rows)} / 단어 {len(word_units)} / 뜻 {n_meanings} 적재 완료")
    except Exception:
        conn.rollback()
        raise
    finally:
        cur.close()
        conn.close()


if __name__ == "__main__":
    main()
```

- [ ] **Step 2: 변환 단위 테스트 회귀 확인**

Run: `cd conversion_data && python -m pytest test_content_transforms.py -v`
Expected: PASS (20 passed) — `__main__` 가드 덕분에 import 시 DB 접속 없음.

- [ ] **Step 3: dry-run 실행으로 파싱 검증**

Run: `cd conversion_data && python kanjify_data.py --dry-run`
Expected: 한자 약 2136건 / 단어 약 9181건 출력, 한자 샘플의 `stroke_count`는 정수, `jlpt_level`은 N1~N5, 단어 샘플 head 5번째(jlpt_level)는 `None`, 의미 리스트가 분리되어 출력. 에러 없음.

- [ ] **Step 4: Commit**

```bash
git add conversion_data/kanjify_data.py
git commit -m "feat(conversion): load Anki content into japavoca tables"
```

---

### Task 6: `insert_kanji.sql` 새 스키마로 변환

**Files:**
- Modify: `conversion_data/insert_kanji.sql`

- [ ] **Step 1: 파일 재작성**

기존 인덱스 생성/옛 INSERT를 제거하고, 부수·특수 한자 64건을 새 스키마로 INSERT. 각 행은
`(character, meaning_ko, meaning_ko_detail, components, stroke_count, on_reading, kun_reading, meaning_ja, jlpt_level, created_at)` 형태.
- 옛 `korean_reading`→`meaning_ko`, `korean_reading_detail`→`meaning_ko_detail`, `etymology`→`components`.
- `'10획'`류는 정수 `10`으로, `'3획'`→`3` 등 직접 변환.
- 옛 `stroke_count_ja/onyomi/kunyomi/meaning_ja`가 NULL이던 자리는 `on_reading=''`, `kun_reading=''`, `meaning_ja=''` (NOT NULL), `jlpt_level=NULL`.
- `components`가 NULL이던 행은 `''`.

예시(첫 두 행):
```sql
INSERT INTO tbl_content_kanji
  (character, meaning_ko, meaning_ko_detail, components, stroke_count,
   on_reading, kun_reading, meaning_ja, jlpt_level, created_at)
VALUES
  ('鬯', '향풀 창, 울창주 창', '향풀 창, 울창주 창',
   '凵(입벌릴 감) + 米(쌀 미) + 匕(비수 비)', 10, '', '', '', NULL, now()),
  ('彡', '터럭 삼', '터럭 삼', '', 3, '', '', '', NULL, now())
  -- ... 나머지 62행 동일 패턴으로 변환 ...
ON CONFLICT (character) DO NOTHING;
```

끝의 두 UPDATE를 새 컬럼명으로:
```sql
UPDATE tbl_content_kanji SET components = '大(클 대) + 一(하나 일)' WHERE character = '立';
UPDATE tbl_content_kanji SET components = '⺍(작을 소) + 田(밭 전) + 十(열 십)' WHERE character = '単';
```

> 변환 작업 시 원본 `insert_kanji.sql`의 64개 VALUES 행을 1:1로 옮기되, 컬럼 순서 `(kanji, korean_reading_detail, korean_reading, etymology, stroke_count_ko, stroke_count_ja, onyomi, kunyomi, meaning_ja, level)` →
> 새 순서 `(character=kanji, meaning_ko=korean_reading, meaning_ko_detail=korean_reading_detail, components=etymology(NULL→''), stroke_count=정수(stroke_count_ko), on_reading=''(NULL→''), kun_reading='', meaning_ja='', jlpt_level=NULL)`로 매핑한다.

- [ ] **Step 2: 문법 검증 (적재 후 실행)**

Run: `PGPASSWORD=1234 psql -h 127.0.0.1 -p 5432 -U root -d japavoca -f conversion_data/insert_kanji.sql`
Expected: `INSERT 0 N` 및 `UPDATE` 출력, 에러 없음. (Task 5 이후 실행 가정)

- [ ] **Step 3: Commit**

```bash
git add conversion_data/insert_kanji.sql
git commit -m "refactor(conversion): port insert_kanji.sql to new content schema"
```

---

### Task 7: `cleanup_data.sql` 새 스키마로 수정

**Files:**
- Modify: `conversion_data/cleanup_data.sql`

- [ ] **Step 1: 파일 재작성**

옛 raw 테이블 대상 구문을 새 스키마 dedup으로 교체:
```sql
-- tbl_content_kanji 중복 제거 (character UNIQUE라 사실상 없음; 안전망)
DELETE FROM tbl_content_kanji
WHERE id NOT IN (
    SELECT MIN(id) FROM tbl_content_kanji
    GROUP BY character, meaning_ko, components, stroke_count,
             on_reading, kun_reading, meaning_ja, jlpt_level, meaning_ko_detail
);

-- tbl_content_word 중복 제거 (연결된 wordmeaning 먼저 정리)
DELETE FROM tbl_content_wordmeaning
WHERE word_id IN (
    SELECT id FROM tbl_content_word
    WHERE id NOT IN (
        SELECT MIN(id) FROM tbl_content_word
        GROUP BY surface, word_type, reading, pos, jlpt_level
    )
);

DELETE FROM tbl_content_word
WHERE id NOT IN (
    SELECT MIN(id) FROM tbl_content_word
    GROUP BY surface, word_type, reading, pos, jlpt_level
);
```

- [ ] **Step 2: 실행 검증 (적재 후)**

Run: `PGPASSWORD=1234 psql -h 127.0.0.1 -p 5432 -U root -d japavoca -f conversion_data/cleanup_data.sql`
Expected: `DELETE N` 출력, 에러 없음.

- [ ] **Step 3: Commit**

```bash
git add conversion_data/cleanup_data.sql
git commit -m "refactor(conversion): port cleanup_data.sql to new content schema"
```

---

### Task 8: 단어 레벨용 스크립트 삭제

**Files:**
- Delete: `conversion_data/assign_jlpt_levels.py`
- Delete: `conversion_data/update_jlpt_level.py`

- [ ] **Step 1: 삭제 + 커밋**

```bash
git rm conversion_data/assign_jlpt_levels.py conversion_data/update_jlpt_level.py
git commit -m "chore(conversion): remove word jlpt leveling scripts (level left null)"
```

---

## Self-Review

**Spec coverage:**
- 한자/단어 필드 매핑 → Task 4 `build_kanji_row`/`build_word`. ✅
- stroke_count/jlpt/`<br>`/pos/의미분리/word_type → Task 1–3. ✅
- NOT NULL→''·길이 절단·created_at now() → `nz`(Task 2) + Task 5 template. ✅
- 한자 중복 ON CONFLICT → Task 5 `insert_kanji`. ✅
- 단어 jlpt NULL → Task 4 head 5번째 `None`. ✅
- insert_kanji.sql/cleanup_data.sql 변환 → Task 6/7. ✅
- 두 스크립트 삭제 → Task 8. ✅
- CREATE TABLE 금지 → Task 5 어디에도 CREATE 없음. ✅

**Placeholder scan:** 모든 코드 스텝에 실제 코드 포함. Task 6의 "나머지 62행"은 원본 파일을 1:1 변환하는 기계적 작업이므로 매핑 규칙을 명시함(원본이 source of truth). 

**Type consistency:** `build_kanji_row` 9-튜플 ↔ Task 5 INSERT 9컬럼+now() 일치. `build_word` head 5-튜플 ↔ INSERT 5컬럼+now() 일치. `split_meanings`→list ↔ `insert_words` meaning_rows 생성 일치. 함수명 Task 간 동일.
