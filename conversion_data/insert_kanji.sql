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
    ('丨', '뚫을 곤', '뚫을 곤', NULL, '1획', NULL, NULL, NULL, NULL, NULL),
    ('𠂇', '왼손 좌', '왼손 좌', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('䒑', '초두머리 초', '초두머리 초', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
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
    ('厂', '기슭 엄', '기슭 엄', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('釆', '분별할 변', '분별할 변', '丿(삐침 별) + 米(쌀 미)', '7획', NULL, NULL, NULL, NULL, NULL),
    ('龍', '용 룡', '용 룡', '立(설 립) + 月(달 월) + 三(석 삼) + 彡(터럭 삼)', '16획', NULL, NULL, NULL, NULL, NULL),
    ('髟', '터럭발 표', '터럭발 표', '長(길 장) + 彡(터럭 삼)', '10획', NULL, NULL, NULL, NULL, NULL),
    ('韋', '가죽 위', '가죽 위', '口(입 구) + 舛(어그러질 천)', '9획', NULL, NULL, NULL, NULL, NULL),
    ('鬲', '솥 력', '솥 력', '冂(멀 경) + 儿(어진사람 인) + 丫(가닥 아)', '10획', NULL, NULL, NULL, NULL, NULL),
    ('禾', '벼 화', '벼 화', '丿(삐침 별) + 木(나무 목)', '5획', NULL, NULL, NULL, NULL, NULL),
    ('隶', '미칠 이', '미칠 이', '又(또 우) + 八(여덟 팔) 형태', '8획', NULL, NULL, NULL, NULL, NULL),
    ('殳', '창 수', '창 수', '几(안석 궤) + 又(또 우)', '4획', NULL, NULL, NULL, NULL, NULL),
    ('儿', '어진사람 인', '어진사람 인', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('几', '안석 궤', '안석 궤', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('厶', '사사 사', '사사 사', NULL, '2획', NULL, NULL, NULL, NULL, NULL),
    ('囗', '큰입 구', '큰입 구', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('幺', '작을 요', '작을 요', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('彐', '돼지머리 계', '돼지머리 계', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('戈', '창 과', '창 과', NULL, '4획', NULL, NULL, NULL, NULL, NULL),
    ('戶', '지게 호', '지게 호', NULL, '4획', NULL, NULL, NULL, NULL, NULL),
    ('歹', '죽을사변 알', '죽을사변 알', NULL, '4획', NULL, NULL, NULL, NULL, NULL),
    ('毋', '말 무', '말 무', NULL, '4획', NULL, NULL, NULL, NULL, NULL),
    ('瓜', '오이 과', '오이 과', NULL, '5획', NULL, NULL, NULL, NULL, NULL),
    ('疋', '짝 필', '짝 필', NULL, '5획', NULL, NULL, NULL, NULL, NULL),
    ('疒', '병들녁 녁', '병들녁 녁', NULL, '5획', NULL, NULL, NULL, NULL, NULL),
    ('癶', '필발 발', '필발 발', NULL, '5획', NULL, NULL, NULL, NULL, NULL),
    ('耂', '늙을 로', '늙을 로', NULL, '4획', NULL, NULL, NULL, NULL, NULL),
    ('而', '말이을 이', '말이을 이', NULL, '6획', NULL, NULL, NULL, NULL, NULL),
    ('耒', '쟁기 뢰', '쟁기 뢰', NULL, '6획', NULL, NULL, NULL, NULL, NULL),
    ('聿', '붓 율', '붓 율', NULL, '6획', NULL, NULL, NULL, NULL, NULL),
    ('舛', '어그러질 천', '어그러질 천', NULL, '6획', NULL, NULL, NULL, NULL, NULL),
    ('艮', '괘이름 간', '괘이름 간', NULL, '6획', NULL, NULL, NULL, NULL, NULL),
    ('虍', '범 호', '범 호', NULL, '6획', NULL, NULL, NULL, NULL, NULL),
    ('豕', '돼지 시', '돼지 시', NULL, '7획', NULL, NULL, NULL, NULL, NULL),
    ('豸', '갖은돼지시변 치', '갖은돼지시변 치', NULL, '7획', NULL, NULL, NULL, NULL, NULL),
    ('辰', '별 진', '별 진', NULL, '7획', NULL, NULL, NULL, NULL, NULL),
    ('酉', '닭 유, 술 유', '닭 유, 술 유', NULL, '7획', NULL, NULL, NULL, NULL, NULL),
    ('辶', '쉬엄쉬엄 갈 착(부수 형태)', '쉬엄쉬엄 갈 착(부수 형태)', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('氵', '삼수변', '삼수변', NULL, '3획', NULL, NULL, NULL, NULL, NULL),
    ('辵', '쉬엄쉬엄 갈 착', '쉬엄쉬엄 갈 착', NULL, '7획', NULL, NULL, NULL, NULL, NULL),
    ('𠂉', '[미상 한자]', '[미상 한자]', NULL, '2획', NULL, NULL, NULL, NULL, NULL);



-- 특정 한자 데이터 수정
UPDATE tbl_kanji SET etymology = '大(클 대) + 一(하나 일)' WHERE kanji = '立';
UPDATE tbl_kanji SET etymology = '⺍(작을 소) + 田(밭 전) + 十(열 십)' WHERE kanji = '単';