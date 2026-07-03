# 가나 단어 예문 데이터 구조

가나 단어에 예문을 붙이기 위한 `tbl_content_wordexample` 테이블 정의.
예문은 단어당 여러 개(1:N)라 `tbl_content_wordmeaning`과 동일하게 별도 테이블로 저장한다.

## 1. 테이블

```sql
CREATE TABLE tbl_content_wordexample (
    id serial PRIMARY KEY,
    word_id integer NOT NULL
        REFERENCES tbl_content_word(id) ON DELETE CASCADE,
    sort_no integer NOT NULL,   -- 단어 내 예문 순서 (1부터)
    origin text NOT NULL,       -- 한자표기 일본어 문장
    reading text,               -- 가나읽기
    translation text,           -- 한국어 번역
    UNIQUE (word_id, sort_no)
);
```

| 컬럼 | 타입 | 설명 |
|------|------|------|
| `id` | serial PK | |
| `word_id` | int FK → `tbl_content_word(id)` | 어느 단어의 예문인지 |
| `sort_no` | int | 단어 내 예문 순서 (1, 2, 3) |
| `origin` | text | **한자 표기** 일본어 문장 |
| `reading` | text | 같은 문장을 **전부 가나로 풀어쓴 읽기** |
| `translation` | text | 한국어 번역 |

- `word_id + sort_no` 유니크. 단어당 **최대 3개** 저장.
- 가나 단어에만 예문 row가 생긴다. **한자 단어는 예문 row 없음**(테이블에 아예 안 들어감).

## 2. 저장 예시

`あそこ`(word_id=16)의 예문 row들:

| word_id | sort_no | origin | reading | translation |
|---------|---------|--------|---------|-------------|
| 16 | 1 | `ここからあそこまで` | `ここからあそこまで` | 여기서 저기까지 |
| 16 | 2 | `あそこに見える建物` | `あそこにみえるたてもの` | 저기 보이는 건물 |
| 16 | 3 | `あそこに家を建てよう` | `あそこにいえをたてよう` | 저곳에 집을 짓자 |

### origin / reading 관계

`origin`과 `reading`은 **같은 문장의 두 표기**다. 원본 데이터에는 한자+후리가나가 붙은 문장 하나만 있어서, 후리가나에서 `reading`(가나읽기)을, 한자 부분을 남겨 `origin`(한자표기)을 만들어 둘 다 저장한다. 프론트에서 한자 표시/읽기 표시를 상황에 맞게 고르면 된다.

> 문장에 후리가나 없이 쓰인 한자가 있으면 `reading`에도 그 한자가 그대로 남을 수 있음 — 극소수(약 0.03%).

## 3. 조회 예시

```sql
-- 특정 단어의 예문 (순서대로)
SELECT sort_no, origin, reading, translation
FROM tbl_content_wordexample
WHERE word_id = 16
ORDER BY sort_no;

-- 단어 + 예문 join
SELECT w.surface, e.sort_no, e.origin, e.reading, e.translation
FROM tbl_content_word w
JOIN tbl_content_wordexample e ON e.word_id = w.id
WHERE w.surface = 'あそこ'
ORDER BY e.sort_no;
```

프론트에서는 해당 단어의 `tbl_content_wordexample` row가 있으면 예문 영역을 렌더링하면 된다.
