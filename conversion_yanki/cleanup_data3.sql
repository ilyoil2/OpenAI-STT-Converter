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

-- wordmeaning 정리 후 word 본체도 같은 기준으로 중복 제거
DELETE FROM tbl_content_word
WHERE id NOT IN (
    SELECT MIN(id) FROM tbl_content_word
    GROUP BY surface, word_type, reading, pos, jlpt_level
);

-- on_reading의 * 제거
UPDATE tbl_content_kanji SET on_reading = REPLACE(on_reading, '*', '') WHERE on_reading LIKE '%*%';

-- meaning_ko 수정
UPDATE tbl_content_kanji SET meaning_ko = '반대 반 · 배반 반 · 젖힐 반 · 돌이킬 반 · 반복할 반' WHERE character = '反';
UPDATE tbl_content_kanji SET meaning_ko = '무리 도 · 제자 도 · 걸을 도 · 맨손 도 · 헛될 도' WHERE character = '徒';
UPDATE tbl_content_kanji SET meaning_ko = '변별할 변 · 말할 변 · 대신할 변 · 갖출 판' WHERE character = '弁';
