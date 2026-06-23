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
