-- tbl_content_kanji 중복 제거 (character UNIQUE라 사실상 없음; 안전망)
DELETE FROM tbl_content_kanji
WHERE id NOT IN (
    SELECT MIN(id) FROM tbl_content_kanji
    GROUP BY character, meaning_ko, components, stroke_count,
             on_reading, kun_reading, meaning_ja, jlpt_level, meaning_ko_detail
);

-- tbl_content_word 중복 제거 (연결된 자식 wordmeaning/wordexample 먼저 정리)
DELETE FROM tbl_content_wordmeaning
WHERE word_id IN (
    SELECT id FROM tbl_content_word
    WHERE id NOT IN (
        SELECT MIN(id) FROM tbl_content_word
        GROUP BY surface, word_type, reading, pos, jlpt_level
    )
);

-- wordexample도 word를 FK로 참조하므로 word 삭제 전에 먼저 정리
DELETE FROM tbl_content_wordexample
WHERE word_id IN (
    SELECT id FROM tbl_content_word
    WHERE id NOT IN (
        SELECT MIN(id) FROM tbl_content_word
        GROUP BY surface, word_type, reading, pos, jlpt_level
    )
);

-- 자식 정리 후 word 본체도 같은 기준으로 중복 제거
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

-- 숫자+조수사 합성어 단어 일괄 삭제 (tbl_content_word 대상, 중복 제거 후 137개)
-- 이 단어들은 tbl_content_kanji가 아니라 tbl_content_word에 있다.
-- 목록은 임시 테이블에 한 번만 넣고, FK로 물린 자식(wordmeaning/wordexample)을
-- 먼저 지운 뒤 본체를 삭제한다. 전체를 한 트랜잭션으로 묶어 임시 테이블이
-- 같은 세션에서 유지되도록 한다(pgbouncer 트랜잭션 풀러 대응).
BEGIN;
CREATE TEMP TABLE _del_word_surface(s text) ON COMMIT DROP;
INSERT INTO _del_word_surface(s) VALUES
    ('七人'), ('七個'), ('七倍'), ('七円'), ('七分'), ('七匹'), ('七回'), ('七年'), ('七時'), ('七月'),
    ('七本'), ('七杯'), ('七枚'), ('七番'), ('七階'), ('三人'), ('三個'), ('三倍'), ('三円'), ('三分'),
    ('三匹'), ('三回'), ('三年'), ('三時'), ('三月'), ('三本'), ('三杯'), ('三枚'), ('三番'), ('三階'),
    ('九人'), ('九個'), ('九倍'), ('九円'), ('九分'), ('九匹'), ('九回'), ('九年'), ('九時'), ('九月'),
    ('九本'), ('九杯'), ('九枚'), ('九番'), ('九階'), ('二の次'), ('二個'), ('二倍'), ('二円'), ('二分'),
    ('二匹'), ('二回'), ('二年'), ('二時'), ('二月'), ('二本'), ('二杯'), ('二枚'), ('二番'), ('二階'),
    ('五人'), ('五個'), ('五倍'), ('五円'), ('五分'), ('五匹'), ('五回'), ('五年'), ('五時'), ('五月'),
    ('五本'), ('五杯'), ('五番'), ('五階'), ('八人'), ('八個'), ('八倍'), ('八円'), ('八分'), ('八匹'),
    ('八回'), ('八年'), ('八時'), ('八月'), ('八本'), ('八杯'), ('八枚'), ('八番'), ('八階'), ('六人'),
    ('六個'), ('六倍'), ('六円'), ('六分'), ('六匹'), ('六回'), ('六年'), ('六時'), ('六月'), ('六本'),
    ('六杯'), ('六枚'), ('六番'), ('六階'), ('十一時'), ('十一月'), ('十二時'), ('十二月'), ('十人'), ('十個'),
    ('十倍'), ('十円'), ('十匹'), ('十回'), ('十年'), ('十時'), ('十月'), ('十本'), ('十杯'), ('十枚'),
    ('十番'), ('十階'), ('四人'), ('四個'), ('四倍'), ('四円'), ('四分'), ('四匹'), ('四回'), ('四年'),
    ('四時'), ('四月'), ('四本'), ('四杯'), ('四枚'), ('四番'), ('四階');
DELETE FROM tbl_content_wordmeaning
WHERE word_id IN (SELECT id FROM tbl_content_word WHERE surface IN (SELECT s FROM _del_word_surface));
DELETE FROM tbl_content_wordexample
WHERE word_id IN (SELECT id FROM tbl_content_word WHERE surface IN (SELECT s FROM _del_word_surface));
DELETE FROM tbl_content_word WHERE surface IN (SELECT s FROM _del_word_surface);
COMMIT;
