# tonghanja.com ↔ tbl_content_kanji 구성요소 비교

tonghanja.com(통용한자, WordPress)의 한자 데이터를 크롤링해서,
내 DB `tbl_content_kanji`와 **공통 한자의 구성요소(components)** 를 비교한다.
비교는 DB에 스테이징 테이블을 넣고 **VIEW 쿼리**로 한눈에 본다. (PostgreSQL)

## 구성 파일
- `crawl_tonghanja.py` — REST API 크롤러 (HTML 스크래핑 X, JSON 사용)
- `setup_compare.sql` — `comp_norm()` 함수 + `tbl_tonghanja` 테이블 + 비교 VIEW

## 절차

```bash
# 1) 크롤 -> CSV (character, hun_eum, components_norm, comp_status, title, link, content)
python3 crawl_tonghanja.py crawl --out tonghanja.csv

# 2) DB에 함수/스테이징 테이블/뷰 생성
psql -d <DB> -f setup_compare.sql

# 3) 크롤 CSV를 스테이징 테이블에 적재
psql -d <DB> -c "\copy tbl_tonghanja FROM 'tonghanja.csv' WITH (FORMAT csv, HEADER true)"

# 4) 한눈에 비교
psql -d <DB> -c "SELECT * FROM v_hanja_diff ORDER BY character;"
```

다시 크롤했으면: `TRUNCATE tbl_tonghanja;` 후 3) 재실행.
`tbl_content_kanji`가 바뀌면 VIEW가 자동 반영(재생성 불필요).

## 비교가 맞는 이유 (정규화)
양쪽 구성요소를 **같은 규칙**으로 `_norm` 한자열로 환원해서 문자열 비교한다.
- 괄호 훈음 제거: `氵(물 수) + 弗(아닐 불)` → `氵弗`
- 부수 이형 통일: `氵→水`, `艹→艸`, `刂→刀` … (`刂` 등)
- 정렬: 순서 차이 제거 → `弗水`

규칙은 **두 곳에 동일하게** 들어있다. 새 이형이 보이면 둘 다 고칠 것:
- Python: `crawl_tonghanja.py`의 `RADICAL_NORMALIZE`
- SQL: `setup_compare.sql`의 `comp_norm()` 안 `translate(...)` 두 문자열

## 뷰
- `v_hanja_compare` — 공통 한자 전체. `db_comp / site_comp / is_match / db_only / site_only / comp_status`
- `v_hanja_diff` — 불일치만 (사이트가 이미지라 못 읽은 글 `comp_status='image'`은 제외)

## comp_status 의미
- `ok` — 구성요소 한자를 텍스트로 정상 추출
- `image` — 사이트가 구성요소를 이미지로 넣어 못 읽음 (가짜 불일치 방지 위해 diff에서 제외)
- `none` — 구성요소 메타 없음 (기본 부수 등)

## 참고: DB 없이 빠르게 보기
스테이징 없이 CSV끼리만 비교도 가능:
```bash
psql -d <DB> -F',' --no-align -t -c "SELECT character, components FROM tbl_content_kanji" > mine.csv
python3 crawl_tonghanja.py compare-components --crawl tonghanja.csv --mine mine.csv
```
