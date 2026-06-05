-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_kanji_kanji ON tbl_kanji(kanji);
CREATE INDEX IF NOT EXISTS idx_kanji_korean_reading ON tbl_kanji(korean_reading);
CREATE INDEX IF NOT EXISTS idx_vocabulary_word ON tbl_vocabulary(word);
CREATE INDEX IF NOT EXISTS idx_search_history_word_text ON tbl_search_history(word_text);

-- tbl_kanji에 한자 추가
-- 부수 및 특수 한자 추가용

INSERT INTO tbl_kanji (
    kanji, korean_reading_detail, korean_reading,
    etymology, stroke_count_ko, stroke_count_ja,
    onyomi, kunyomi, meaning_ja, level
) VALUES
    ('鬯', '향풀 창, 울창주 창', '향풀 창, 울창주 창', '凵(입벌릴 감) + 米(쌀 미) + 匕(비수 비)', '10획', NULL, NULL, NULL, NULL, NULL),
    ('彡', '터럭 삼', '터럭 삼', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('冖', '덮을 멱', '덮을 멱', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('丿', '삐침 별', '삐침 별', NULL, '1획', NULL, NULL, NULL, NULL, NULL),
    ('吾', '나 오', '나 오', '五(다섯 오) + 口(입 구)', '7획', NULL, NULL, NULL, NULL, NULL),
    ('亖', '넉 사', '넉 사', NULL, '4획', NULL, NULL, NULL, NULL, NULL),
    ('丶', '점 주', '점 주', NULL, '1획', NULL, NULL, NULL, NULL, NULL),
    ('亅', '갈고리 궐', '갈고리 궐', NULL, '1획', NULL, NULL, NULL, NULL, NULL),
    ('宀', '갓 머리, 집 면', '갓 머리', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('亠', '돼지해머리 두', '돼지해머리 두', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('尸', '주검 시', '주검 시', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('屮', '왼손 좌, 싹날 철', '왼손 좌, 싹날 철', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('冂', '멀 경', '멀 경', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('巛', '개천 천, 순할 순', '개천 천', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('冫', '이수변, 얼음 빙', '얼음 빙', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('气', '기운 기', '기운 기', NULL, '4획', NULL, NULL, NULL, NULL, NULL),
    ('凵', '입벌릴 감', '입벌릴 감', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('广', '집 엄', '집 엄', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('勹', '쌀 포', '쌀 포', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('廴', '길게걸을 인', '길게걸을 인', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('匕', '비수 비', '비수 비', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('廾', '받들 공', '받들 공', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('匚', '상자 방', '상자 방', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('弋', '주살 익', '주살 익', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('卜', '점 복', '점 복', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('彳', '조금걸을 척', '조금걸을 척', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('厂', '기슭 엄', '기슭 엄', NULL, '2획', NULL, NULL, NULL, NULL, NULL);