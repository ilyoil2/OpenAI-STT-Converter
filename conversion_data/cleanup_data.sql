-- tbl_kanji 중복 제거 (id 제외 모든 컬럼이 같은 경우)
DELETE FROM tbl_kanji
WHERE id NOT IN (
    SELECT MIN(id)
    FROM tbl_kanji
    GROUP BY kanji, korean_reading_detail, korean_reading, radical_desc_ko,
             etymology, stroke_count_ko, radical_ja, stroke_count_ja,
             onyomi, kunyomi, meaning_ja, level
);

-- tbl_vocabulary 중복 제거 (id 제외 모든 컬럼이 같은 경우)
DELETE FROM tbl_vocabulary
WHERE id NOT IN (
    SELECT MIN(id)
    FROM tbl_vocabulary
    GROUP BY word, korean_reading_detail, korean_reading, radical_desc_ko,
             etymology, stroke_count_ko, radical_ja, stroke_count_ja,
             onyomi, kunyomi, meaning_ja, level
);

-- tbl_vocabulary에서 stroke_count_ko가 '<div class="mean_tray">'로 시작하지 않는 레코드 삭제
DELETE FROM tbl_vocabulary
WHERE stroke_count_ko NOT LIKE '<div class="mean_tray">%';