-- =====================================================================
-- tonghanja.com <-> tbl_content_kanji 구성요소 비교 셋업 (PostgreSQL)
--
-- 사용 순서:
--   1) python crawl_tonghanja.py crawl --out tonghanja.csv
--   2) psql -d <DB> -f setup_compare.sql            -- 함수/테이블/뷰 생성
--   3) psql -d <DB> -c "\copy tbl_tonghanja FROM 'tonghanja.csv' WITH (FORMAT csv, HEADER true)"
--   4) SELECT * FROM v_hanja_diff;                  -- 한눈에 불일치
--
-- 다시 크롤한 경우: TRUNCATE tbl_tonghanja; 후 3) 재실행.
-- v_hanja_diff 는 VIEW 라 tbl_content_kanji 가 바뀌면 자동 반영된다.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. 구성요소 정규화 함수
--    '氵(물 수) + 弗(아닐 불)'  ->  '弗水'
--    - 괄호 안 훈음 제거
--    - 부수 이형(異形)을 대표형으로 통일 (crawl_tonghanja.py 의 RADICAL_NORMALIZE 와 동일)
--    - 한자만 남기고 정렬 (집합 비교를 문자열 비교로 환원)
-- ---------------------------------------------------------------------
CREATE OR REPLACE FUNCTION comp_norm(s text) RETURNS text AS $$
  SELECT COALESCE(string_agg(ch, '' ORDER BY ch), '')
  FROM regexp_split_to_table(
         translate(
           regexp_replace(COALESCE(s, ''), '\([^)]*\)', '', 'g'),  -- (훈음) 제거
           '氵扌刂忄艹辶犭礻衤亻灬罒糹',                              -- 변형 부수
           '水手刀心艸辵犬示衣人火网糸'                               -- 대표형
         ),
         ''
       ) AS ch
  WHERE ch ~ '[㐀-鿿豈-﫿]';                                         -- 한자만
$$ LANGUAGE sql IMMUTABLE;

-- ---------------------------------------------------------------------
-- 2. 사이트 데이터 스테이징 테이블 (CSV 컬럼 순서와 일치)
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS v_hanja_diff;
DROP VIEW IF EXISTS v_hanja_compare;
DROP TABLE IF EXISTS tbl_tonghanja;
CREATE TABLE tbl_tonghanja (
  character         text PRIMARY KEY,
  hun_eum           text,
  components_norm   text,         -- 정렬·정규화된 비교용 한자열 (예: "十又壴")
  components_detail text,         -- 사람이 읽는 형태 (예: "壴(북 주) 十(모양) 又(또 우)")
  comp_status       text,         -- ok / image / none
  title             text,
  link              text,
  content           text
);

-- ---------------------------------------------------------------------
-- 3. 비교 VIEW
--    교집합 한자만, 양쪽 구성요소를 같은 규칙으로 정규화해 비교.
--    site_only / db_only 는 한쪽에만 있는 부수를 한눈에 보여준다.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW v_hanja_compare AS
SELECT
  k.character,
  k.meaning_ko,
  t.hun_eum                       AS site_hun_eum,
  k.components                     AS db_detail,    -- 내 DB 원본(훈음 포함)
  t.components_detail              AS site_detail,  -- 사이트 원본(훈음 포함)
  comp_norm(k.components)         AS db_comp,
  t.components_norm               AS site_comp,
  t.comp_status,
  (comp_norm(k.components) = t.components_norm) AS is_match,
  -- DB 에만 있는 부수
  (SELECT string_agg(c, '' ORDER BY c)
     FROM regexp_split_to_table(comp_norm(k.components), '') c
    WHERE c <> '' AND position(c IN t.components_norm) = 0) AS db_only,
  -- 사이트에만 있는 부수
  (SELECT string_agg(c, '' ORDER BY c)
     FROM regexp_split_to_table(t.components_norm, '') c
    WHERE c <> '' AND position(c IN comp_norm(k.components)) = 0) AS site_only,
  t.link
FROM tbl_content_kanji k
JOIN tbl_tonghanja t USING (character);

-- 불일치만 추린 뷰 ('한눈에' 용). 사이트가 이미지라 못 읽은 글(comp_status='image')은 제외.
CREATE OR REPLACE VIEW v_hanja_diff AS
SELECT character, db_detail, site_detail
FROM v_hanja_compare
WHERE NOT is_match
  AND comp_status = 'ok';

-- =====================================================================
-- 참고 쿼리 모음
-- =====================================================================
-- 전체 한눈에:        SELECT * FROM v_hanja_diff ORDER BY character;
-- 요약 집계:
--   SELECT comp_status,
--          count(*)                              AS 공통,
--          count(*) FILTER (WHERE is_match)       AS 일치,
--          count(*) FILTER (WHERE NOT is_match)   AS 불일치
--   FROM v_hanja_compare GROUP BY comp_status;
-- 사이트에만 있는 한자(내 DB 추가 후보):
--   SELECT t.character, t.hun_eum, t.link
--   FROM tbl_tonghanja t
--   LEFT JOIN tbl_content_kanji k USING (character)
--   WHERE k.character IS NULL AND t.comp_status <> 'none'
--   ORDER BY t.character;
