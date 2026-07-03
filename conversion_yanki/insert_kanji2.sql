-- tbl_content_kanji에 한자 추가
-- 부수 및 특수 한자 추가용

-- [KanaExample 미사용 가나 목록] 아래 14개 가나는 예시 단어를 넣지 않음 (자연스럽게 쓰이는 단어가 사실상 없음)
--   히라가나: みゅ, びゅ, ぴゅ (외래어 음역에만 등장, 고유어 없음)
--   가타카나: ヲ (현대에 거의 안 씀), ヂ, ヅ (현대 외래어는 ジ/ズ로 통일 표기),
--            ヒャ, ミャ, ミョ, リョ, ビャ, ビョ, ピャ, ピョ (자연스러운 외래어/단어가 사실상 없음)

INSERT INTO tbl_content_kanji
  (character, meaning_ko, meaning_ko_detail, components, stroke_count,
   on_reading, kun_reading, meaning_ja, jlpt_level)
VALUES
  ('鬯', '향풀 창 · 울창주 창', '향풀 창 · 울창주 창', '凵(입벌릴 감) + 米(쌀 미) + 匕(비수 비)', 10, '', '', '', NULL),
  ('彡', '터럭 삼', '터럭 삼', '', 3, '', '', '', NULL),
  ('冖', '덮을 멱', '덮을 멱', '', 2, '', '', '', NULL),
  ('丿', '삐침 별', '삐침 별', '', 1, '', '', '', NULL),
  ('吾', '나 오', '나 오', '五(다섯 오) + 口(입 구)', 7, '', '', '', NULL),
  ('亖', '넉 사', '넉 사', '', 4, '', '', '', NULL),
  ('丶', '점 주', '점 주', '', 1, '', '', '', NULL),
  ('亅', '갈고리 궐', '갈고리 궐', '', 1, '', '', '', NULL),
  ('宀', '갓 머리', '갓 머리 · 집 면', '', 3, '', '', '', NULL),
  ('亠', '돼지해머리 두', '돼지해머리 두', '', 2, '', '', '', NULL),
  ('丨', '뚫을 곤', '뚫을 곤', '', 1, '', '', '', NULL),
  ('𠂇', '왼손 좌', '왼손 좌', '', 2, '', '', '', NULL),
  ('䒑', '초두머리 초', '초두머리 초', '', 3, '', '', '', NULL),
  ('艹', '초두머리 초', '초두머리 초', '', 3, '', '', '', NULL),
  ('圥', '버섯 록', '버섯 록', '', 5, '', '', '', NULL),
  ('尸', '주검 시', '주검 시', '', 3, '', '', '', NULL),
  ('屮', '왼손 좌 · 싹날 철', '왼손 좌 · 싹날 철', '', 3, '', '', '', NULL),
  ('冂', '멀 경', '멀 경', '', 2, '', '', '', NULL),
  ('巛', '개천 천', '개천 천 · 순할 순', '', 3, '', '', '', NULL),
  ('冫', '얼음 빙', '이수변 · 얼음 빙', '', 2, '', '', '', NULL),
  ('气', '기운 기', '기운 기', '', 4, '', '', '', NULL),
  ('凵', '입벌릴 감', '입벌릴 감', '', 2, '', '', '', NULL),
  ('广', '집 엄', '집 엄', '', 3, '', '', '', NULL),
  ('勹', '쌀 포', '쌀 포', '', 2, '', '', '', NULL),
  ('廴', '길게걸을 인', '길게걸을 인', '', 3, '', '', '', NULL),
  ('匕', '비수 비', '비수 비', '', 2, '', '', '', NULL),
  ('廾', '받들 공', '받들 공', '', 3, '', '', '', NULL),
  ('匚', '상자 방', '상자 방', '', 2, '', '', '', NULL),
  ('弋', '주살 익', '주살 익', '', 3, '', '', '', NULL),
  ('卜', '점 복', '점 복', '', 2, '', '', '', NULL),
  ('彳', '조금걸을 척', '조금걸을 척', '', 3, '', '', '', NULL),
  ('厂', '기슭 엄', '기슭 엄', '', 2, '', '', '', NULL),
  ('釆', '분별할 변', '분별할 변', '丿(삐침 별) + 米(쌀 미)', 7, '', '', '', NULL),
  ('龍', '용 룡', '용 룡', '立(설 립) + 月(달 월) + 三(석 삼) + 彡(터럭 삼)', 16, '', '', '', NULL),
  ('髟', '터럭발 표', '터럭발 표', '長(길 장) + 彡(터럭 삼)', 10, '', '', '', NULL),
  ('韋', '가죽 위', '가죽 위', '口(입 구) + 舛(어그러질 천)', 9, '', '', '', NULL),
  ('鬲', '솥 력', '솥 력', '冂(멀 경) + 儿(어진사람 인) + 丫(가닥 아)', 10, '', '', '', NULL),
  ('禾', '벼 화', '벼 화', '丿(삐침 별) + 木(나무 목)', 5, '', '', '', NULL),
  ('隶', '미칠 이', '미칠 이', '又(또 우) + 八(여덟 팔) 형태', 8, '', '', '', NULL),
  ('殳', '창 수', '창 수', '几(안석 궤) + 又(또 우)', 4, '', '', '', NULL),
  ('儿', '어진사람 인', '어진사람 인', '', 2, '', '', '', NULL),
  ('几', '안석 궤', '안석 궤', '', 2, '', '', '', NULL),
  ('厶', '사사 사', '사사 사', '', 2, '', '', '', NULL),
  ('囗', '큰입 구', '큰입 구', '', 3, '', '', '', NULL),
  ('幺', '작을 요', '작을 요', '', 3, '', '', '', NULL),
  ('彐', '돼지머리 계', '돼지머리 계', '', 3, '', '', '', NULL),
  ('戈', '창 과', '창 과', '', 4, '', '', '', NULL),
  ('戶', '지게 호', '지게 호', '', 4, '', '', '', NULL),
  ('歹', '죽을사변 알', '죽을사변 알', '', 4, '', '', '', NULL),
  ('毋', '말 무', '말 무', '', 4, '', '', '', NULL),
  ('瓜', '오이 과', '오이 과', '', 5, '', '', '', NULL),
  ('疋', '짝 필', '짝 필', '', 5, '', '', '', NULL),
  ('疒', '병들녁 녁', '병들녁 녁', '', 5, '', '', '', NULL),
  ('癶', '필발 발', '필발 발', '', 5, '', '', '', NULL),
  ('耂', '늙을 로', '늙을 로', '', 4, '', '', '', NULL),
  ('而', '말이을 이', '말이을 이', '', 6, '', '', '', NULL),
  ('耒', '쟁기 뢰', '쟁기 뢰', '', 6, '', '', '', NULL),
  ('聿', '붓 율', '붓 율', '', 6, '', '', '', NULL),
  ('舛', '어그러질 천', '어그러질 천', '', 6, '', '', '', NULL),
  ('艮', '괘이름 간', '괘이름 간', '', 6, '', '', '', NULL),
  ('虍', '범 호', '범 호', '', 6, '', '', '', NULL),
  ('豕', '돼지 시', '돼지 시', '', 7, '', '', '', NULL),
  ('豸', '갖은돼지시변 치', '갖은돼지시변 치', '', 7, '', '', '', NULL),
  ('辰', '별 진', '별 진', '', 7, '', '', '', NULL),
  ('酉', '닭 유 · 술 유', '닭 유 · 술 유', '', 7, '', '', '', NULL),
  ('辶', '쉬엄쉬엄 갈 착(부수 형태)', '쉬엄쉬엄 갈 착(부수 형태)', '', 3, '', '', '', NULL),
  ('氵', '삼수변', '삼수변', '', 3, '', '', '', NULL),
  ('辵', '쉬엄쉬엄 갈 착', '쉬엄쉬엄 갈 착', '', 7, '', '', '', NULL),
  ('𠂉', '[미상 한자]', '[미상 한자]', '', 2, '', '', '', NULL)
ON CONFLICT (character) DO NOTHING;

-- 특정 한자 데이터 수정
UPDATE tbl_content_kanji SET components = '大(클 대) + 一(하나 일)' WHERE character = '立';
UPDATE tbl_content_kanji SET components = '⺍(작을 소) + 田(밭 전) + 十(열 십)' WHERE character = '単';
UPDATE tbl_content_kanji SET components = '五(다섯 오)' WHERE character = '五';
UPDATE tbl_content_kanji SET components = '幺(작을 요) + 白(흰 백) + 木(나무 목)' WHERE character = '楽';



INSERT INTO tbl_content_kana (character, romaji, script, kind) VALUES
  ('あ', 'a', 'hira', 'seion'),
  ('ア', 'a', 'kata', 'seion'),
  ('い', 'i', 'hira', 'seion'),
  ('イ', 'i', 'kata', 'seion'),
  ('う', 'u', 'hira', 'seion'),
  ('ウ', 'u', 'kata', 'seion'),
  ('え', 'e', 'hira', 'seion'),
  ('エ', 'e', 'kata', 'seion'),
  ('お', 'o', 'hira', 'seion'),
  ('オ', 'o', 'kata', 'seion'),
  ('か', 'ka', 'hira', 'seion'),
  ('カ', 'ka', 'kata', 'seion'),
  ('き', 'ki', 'hira', 'seion'),
  ('キ', 'ki', 'kata', 'seion'),
  ('く', 'ku', 'hira', 'seion'),
  ('ク', 'ku', 'kata', 'seion'),
  ('け', 'ke', 'hira', 'seion'),
  ('ケ', 'ke', 'kata', 'seion'),
  ('こ', 'ko', 'hira', 'seion'),
  ('コ', 'ko', 'kata', 'seion'),
  ('さ', 'sa', 'hira', 'seion'),
  ('サ', 'sa', 'kata', 'seion'),
  ('し', 'shi', 'hira', 'seion'),
  ('シ', 'shi', 'kata', 'seion'),
  ('す', 'su', 'hira', 'seion'),
  ('ス', 'su', 'kata', 'seion'),
  ('せ', 'se', 'hira', 'seion'),
  ('セ', 'se', 'kata', 'seion'),
  ('そ', 'so', 'hira', 'seion'),
  ('ソ', 'so', 'kata', 'seion'),
  ('た', 'ta', 'hira', 'seion'),
  ('タ', 'ta', 'kata', 'seion'),
  ('ち', 'chi', 'hira', 'seion'),
  ('チ', 'chi', 'kata', 'seion'),
  ('つ', 'tsu', 'hira', 'seion'),
  ('ツ', 'tsu', 'kata', 'seion'),
  ('て', 'te', 'hira', 'seion'),
  ('テ', 'te', 'kata', 'seion'),
  ('と', 'to', 'hira', 'seion'),
  ('ト', 'to', 'kata', 'seion'),
  ('な', 'na', 'hira', 'seion'),
  ('ナ', 'na', 'kata', 'seion'),
  ('に', 'ni', 'hira', 'seion'),
  ('ニ', 'ni', 'kata', 'seion'),
  ('ぬ', 'nu', 'hira', 'seion'),
  ('ヌ', 'nu', 'kata', 'seion'),
  ('ね', 'ne', 'hira', 'seion'),
  ('ネ', 'ne', 'kata', 'seion'),
  ('の', 'no', 'hira', 'seion'),
  ('ノ', 'no', 'kata', 'seion'),
  ('は', 'ha', 'hira', 'seion'),
  ('ハ', 'ha', 'kata', 'seion'),
  ('ひ', 'hi', 'hira', 'seion'),
  ('ヒ', 'hi', 'kata', 'seion'),
  ('ふ', 'fu', 'hira', 'seion'),
  ('フ', 'fu', 'kata', 'seion'),
  ('へ', 'he', 'hira', 'seion'),
  ('ヘ', 'he', 'kata', 'seion'),
  ('ほ', 'ho', 'hira', 'seion'),
  ('ホ', 'ho', 'kata', 'seion'),
  ('ま', 'ma', 'hira', 'seion'),
  ('マ', 'ma', 'kata', 'seion'),
  ('み', 'mi', 'hira', 'seion'),
  ('ミ', 'mi', 'kata', 'seion'),
  ('む', 'mu', 'hira', 'seion'),
  ('ム', 'mu', 'kata', 'seion'),
  ('め', 'me', 'hira', 'seion'),
  ('メ', 'me', 'kata', 'seion'),
  ('も', 'mo', 'hira', 'seion'),
  ('モ', 'mo', 'kata', 'seion'),
  ('や', 'ya', 'hira', 'seion'),
  ('ヤ', 'ya', 'kata', 'seion'),
  ('ゆ', 'yu', 'hira', 'seion'),
  ('ユ', 'yu', 'kata', 'seion'),
  ('よ', 'yo', 'hira', 'seion'),
  ('ヨ', 'yo', 'kata', 'seion'),
  ('ら', 'ra', 'hira', 'seion'),
  ('ラ', 'ra', 'kata', 'seion'),
  ('り', 'ri', 'hira', 'seion'),
  ('リ', 'ri', 'kata', 'seion'),
  ('る', 'ru', 'hira', 'seion'),
  ('ル', 'ru', 'kata', 'seion'),
  ('れ', 're', 'hira', 'seion'),
  ('レ', 're', 'kata', 'seion'),
  ('ろ', 'ro', 'hira', 'seion'),
  ('ロ', 'ro', 'kata', 'seion'),
  ('わ', 'wa', 'hira', 'seion'),
  ('ワ', 'wa', 'kata', 'seion'),
  ('を', 'wo', 'hira', 'seion'),
  ('ヲ', 'wo', 'kata', 'seion'),
  ('ん', 'n', 'hira', 'seion'),
  ('ン', 'n', 'kata', 'seion'),
  ('が', 'ga', 'hira', 'dakuten'),
  ('ガ', 'ga', 'kata', 'dakuten'),
  ('ぎ', 'gi', 'hira', 'dakuten'),
  ('ギ', 'gi', 'kata', 'dakuten'),
  ('ぐ', 'gu', 'hira', 'dakuten'),
  ('グ', 'gu', 'kata', 'dakuten'),
  ('げ', 'ge', 'hira', 'dakuten'),
  ('ゲ', 'ge', 'kata', 'dakuten'),
  ('ご', 'go', 'hira', 'dakuten'),
  ('ゴ', 'go', 'kata', 'dakuten'),
  ('ざ', 'za', 'hira', 'dakuten'),
  ('ザ', 'za', 'kata', 'dakuten'),
  ('じ', 'ji', 'hira', 'dakuten'),
  ('ジ', 'ji', 'kata', 'dakuten'),
  ('ず', 'zu', 'hira', 'dakuten'),
  ('ズ', 'zu', 'kata', 'dakuten'),
  ('ぜ', 'ze', 'hira', 'dakuten'),
  ('ゼ', 'ze', 'kata', 'dakuten'),
  ('ぞ', 'zo', 'hira', 'dakuten'),
  ('ゾ', 'zo', 'kata', 'dakuten'),
  ('だ', 'da', 'hira', 'dakuten'),
  ('ダ', 'da', 'kata', 'dakuten'),
  ('ぢ', 'ji', 'hira', 'dakuten'),
  ('ヂ', 'ji', 'kata', 'dakuten'),
  ('づ', 'zu', 'hira', 'dakuten'),
  ('ヅ', 'zu', 'kata', 'dakuten'),
  ('で', 'de', 'hira', 'dakuten'),
  ('デ', 'de', 'kata', 'dakuten'),
  ('ど', 'do', 'hira', 'dakuten'),
  ('ド', 'do', 'kata', 'dakuten'),
  ('ば', 'ba', 'hira', 'dakuten'),
  ('バ', 'ba', 'kata', 'dakuten'),
  ('び', 'bi', 'hira', 'dakuten'),
  ('ビ', 'bi', 'kata', 'dakuten'),
  ('ぶ', 'bu', 'hira', 'dakuten'),
  ('ブ', 'bu', 'kata', 'dakuten'),
  ('べ', 'be', 'hira', 'dakuten'),
  ('ベ', 'be', 'kata', 'dakuten'),
  ('ぼ', 'bo', 'hira', 'dakuten'),
  ('ボ', 'bo', 'kata', 'dakuten'),
  ('ぱ', 'pa', 'hira', 'dakuten'),
  ('パ', 'pa', 'kata', 'dakuten'),
  ('ぴ', 'pi', 'hira', 'dakuten'),
  ('ピ', 'pi', 'kata', 'dakuten'),
  ('ぷ', 'pu', 'hira', 'dakuten'),
  ('プ', 'pu', 'kata', 'dakuten'),
  ('ぺ', 'pe', 'hira', 'dakuten'),
  ('ペ', 'pe', 'kata', 'dakuten'),
  ('ぽ', 'po', 'hira', 'dakuten'),
  ('ポ', 'po', 'kata', 'dakuten'),
  ('きゃ', 'kya', 'hira', 'youon'),
  ('キャ', 'kya', 'kata', 'youon'),
  ('きゅ', 'kyu', 'hira', 'youon'),
  ('キュ', 'kyu', 'kata', 'youon'),
  ('きょ', 'kyo', 'hira', 'youon'),
  ('キョ', 'kyo', 'kata', 'youon'),
  ('しゃ', 'sha', 'hira', 'youon'),
  ('シャ', 'sha', 'kata', 'youon'),
  ('しゅ', 'shu', 'hira', 'youon'),
  ('シュ', 'shu', 'kata', 'youon'),
  ('しょ', 'sho', 'hira', 'youon'),
  ('ショ', 'sho', 'kata', 'youon'),
  ('ちゃ', 'cha', 'hira', 'youon'),
  ('チャ', 'cha', 'kata', 'youon'),
  ('ちゅ', 'chu', 'hira', 'youon'),
  ('チュ', 'chu', 'kata', 'youon'),
  ('ちょ', 'cho', 'hira', 'youon'),
  ('チョ', 'cho', 'kata', 'youon'),
  ('にゃ', 'nya', 'hira', 'youon'),
  ('ニャ', 'nya', 'kata', 'youon'),
  ('にゅ', 'nyu', 'hira', 'youon'),
  ('ニュ', 'nyu', 'kata', 'youon'),
  ('にょ', 'nyo', 'hira', 'youon'),
  ('ニョ', 'nyo', 'kata', 'youon'),
  ('ひゃ', 'hya', 'hira', 'youon'),
  ('ヒャ', 'hya', 'kata', 'youon'),
  ('ひゅ', 'hyu', 'hira', 'youon'),
  ('ヒュ', 'hyu', 'kata', 'youon'),
  ('ひょ', 'hyo', 'hira', 'youon'),
  ('ヒョ', 'hyo', 'kata', 'youon'),
  ('みゃ', 'mya', 'hira', 'youon'),
  ('ミャ', 'mya', 'kata', 'youon'),
  ('みゅ', 'myu', 'hira', 'youon'),
  ('ミュ', 'myu', 'kata', 'youon'),
  ('みょ', 'myo', 'hira', 'youon'),
  ('ミョ', 'myo', 'kata', 'youon'),
  ('りゃ', 'rya', 'hira', 'youon'),
  ('リャ', 'rya', 'kata', 'youon'),
  ('りゅ', 'ryu', 'hira', 'youon'),
  ('リュ', 'ryu', 'kata', 'youon'),
  ('りょ', 'ryo', 'hira', 'youon'),
  ('リョ', 'ryo', 'kata', 'youon'),
  ('ぎゃ', 'gya', 'hira', 'youon'),
  ('ギャ', 'gya', 'kata', 'youon'),
  ('ぎゅ', 'gyu', 'hira', 'youon'),
  ('ギュ', 'gyu', 'kata', 'youon'),
  ('ぎょ', 'gyo', 'hira', 'youon'),
  ('ギョ', 'gyo', 'kata', 'youon'),
  ('じゃ', 'ja', 'hira', 'youon'),
  ('ジャ', 'ja', 'kata', 'youon'),
  ('じゅ', 'ju', 'hira', 'youon'),
  ('ジュ', 'ju', 'kata', 'youon'),
  ('じょ', 'jo', 'hira', 'youon'),
  ('ジョ', 'jo', 'kata', 'youon'),
  ('びゃ', 'bya', 'hira', 'youon'),
  ('ビャ', 'bya', 'kata', 'youon'),
  ('びゅ', 'byu', 'hira', 'youon'),
  ('ビュ', 'byu', 'kata', 'youon'),
  ('びょ', 'byo', 'hira', 'youon'),
  ('ビョ', 'byo', 'kata', 'youon'),
  ('ぴゃ', 'pya', 'hira', 'youon'),
  ('ピャ', 'pya', 'kata', 'youon'),
  ('ぴゅ', 'pyu', 'hira', 'youon'),
  ('ピュ', 'pyu', 'kata', 'youon'),
  ('ぴょ', 'pyo', 'hira', 'youon'),
  ('ピョ', 'pyo', 'kata', 'youon')
ON CONFLICT (character, script) DO NOTHING;


-- 가나 예시 단어 추가 (KanaExample) - あいうえお 트라이얼
INSERT INTO tbl_content_kanaexample (surface, kanji, meaning_ko, kana_id) VALUES
  ('あか', '赤', '빨강', (SELECT id FROM tbl_content_kana WHERE character = 'あ' AND script = 'hira')),
  ('あさ', '朝', '아침', (SELECT id FROM tbl_content_kana WHERE character = 'あ' AND script = 'hira')),
  ('あめ', '雨', '비', (SELECT id FROM tbl_content_kana WHERE character = 'あ' AND script = 'hira')),

  ('いえ', '家', '집', (SELECT id FROM tbl_content_kana WHERE character = 'い' AND script = 'hira')),
  ('いぬ', '犬', '개', (SELECT id FROM tbl_content_kana WHERE character = 'い' AND script = 'hira')),
  ('いろ', '色', '색', (SELECT id FROM tbl_content_kana WHERE character = 'い' AND script = 'hira')),

  ('うみ', '海', '바다', (SELECT id FROM tbl_content_kana WHERE character = 'う' AND script = 'hira')),
  ('うた', '歌', '노래', (SELECT id FROM tbl_content_kana WHERE character = 'う' AND script = 'hira')),
  ('うで', '腕', '팔', (SELECT id FROM tbl_content_kana WHERE character = 'う' AND script = 'hira')),

  ('えき', '駅', '역', (SELECT id FROM tbl_content_kana WHERE character = 'え' AND script = 'hira')),
  ('えいが', '映画', '영화', (SELECT id FROM tbl_content_kana WHERE character = 'え' AND script = 'hira')),
  ('えんぴつ', '鉛筆', '연필', (SELECT id FROM tbl_content_kana WHERE character = 'え' AND script = 'hira')),

  ('おと', '音', '소리', (SELECT id FROM tbl_content_kana WHERE character = 'お' AND script = 'hira')),
  ('おんがく', '音楽', '음악', (SELECT id FROM tbl_content_kana WHERE character = 'お' AND script = 'hira')),
  ('おおい', '多い', '많다', (SELECT id FROM tbl_content_kana WHERE character = 'お' AND script = 'hira'))
ON CONFLICT (kana_id, surface) DO NOTHING;


-- 가나 예시 단어 추가 (KanaExample) - 히라가나 청음 나머지 (か~ん)
INSERT INTO tbl_content_kanaexample (surface, kanji, meaning_ko, kana_id) VALUES
  ('かお', '顔', '얼굴', (SELECT id FROM tbl_content_kana WHERE character = 'か' AND script = 'hira')),
  ('かさ', '傘', '우산', (SELECT id FROM tbl_content_kana WHERE character = 'か' AND script = 'hira')),
  ('かわ', '川', '강', (SELECT id FROM tbl_content_kana WHERE character = 'か' AND script = 'hira')),

  ('きせつ', '季節', '계절', (SELECT id FROM tbl_content_kana WHERE character = 'き' AND script = 'hira')),
  ('きいろ', '黄色', '노랑', (SELECT id FROM tbl_content_kana WHERE character = 'き' AND script = 'hira')),
  ('きた', '北', '북쪽', (SELECT id FROM tbl_content_kana WHERE character = 'き' AND script = 'hira')),

  ('くつ', '靴', '신발', (SELECT id FROM tbl_content_kana WHERE character = 'く' AND script = 'hira')),
  ('くも', '雲', '구름', (SELECT id FROM tbl_content_kana WHERE character = 'く' AND script = 'hira')),
  ('くるま', '車', '자동차', (SELECT id FROM tbl_content_kana WHERE character = 'く' AND script = 'hira')),

  ('けさ', '今朝', '오늘 아침', (SELECT id FROM tbl_content_kana WHERE character = 'け' AND script = 'hira')),
  ('けしき', '景色', '경치', (SELECT id FROM tbl_content_kana WHERE character = 'け' AND script = 'hira')),
  ('けいかく', '計画', '계획', (SELECT id FROM tbl_content_kana WHERE character = 'け' AND script = 'hira')),

  ('こども', '子供', '아이', (SELECT id FROM tbl_content_kana WHERE character = 'こ' AND script = 'hira')),
  ('こえ', '声', '목소리', (SELECT id FROM tbl_content_kana WHERE character = 'こ' AND script = 'hira')),
  ('こおり', '氷', '얼음', (SELECT id FROM tbl_content_kana WHERE character = 'こ' AND script = 'hira')),

  ('さかな', '魚', '물고기', (SELECT id FROM tbl_content_kana WHERE character = 'さ' AND script = 'hira')),
  ('さくら', '桜', '벚꽃', (SELECT id FROM tbl_content_kana WHERE character = 'さ' AND script = 'hira')),
  ('さむい', '寒い', '춥다', (SELECT id FROM tbl_content_kana WHERE character = 'さ' AND script = 'hira')),

  ('しごと', '仕事', '일', (SELECT id FROM tbl_content_kana WHERE character = 'し' AND script = 'hira')),
  ('しお', '塩', '소금', (SELECT id FROM tbl_content_kana WHERE character = 'し' AND script = 'hira')),
  ('しろ', '白', '하양', (SELECT id FROM tbl_content_kana WHERE character = 'し' AND script = 'hira')),

  ('すし', '寿司', '초밥', (SELECT id FROM tbl_content_kana WHERE character = 'す' AND script = 'hira')),
  ('すな', '砂', '모래', (SELECT id FROM tbl_content_kana WHERE character = 'す' AND script = 'hira')),
  ('すいえい', '水泳', '수영', (SELECT id FROM tbl_content_kana WHERE character = 'す' AND script = 'hira')),

  ('せかい', '世界', '세계', (SELECT id FROM tbl_content_kana WHERE character = 'せ' AND script = 'hira')),
  ('せんせい', '先生', '선생님', (SELECT id FROM tbl_content_kana WHERE character = 'せ' AND script = 'hira')),
  ('せなか', '背中', '등', (SELECT id FROM tbl_content_kana WHERE character = 'せ' AND script = 'hira')),

  ('そら', '空', '하늘', (SELECT id FROM tbl_content_kana WHERE character = 'そ' AND script = 'hira')),
  ('そと', '外', '밖', (SELECT id FROM tbl_content_kana WHERE character = 'そ' AND script = 'hira')),
  ('そつぎょう', '卒業', '졸업', (SELECT id FROM tbl_content_kana WHERE character = 'そ' AND script = 'hira')),

  ('たべもの', '食べ物', '음식', (SELECT id FROM tbl_content_kana WHERE character = 'た' AND script = 'hira')),
  ('たいよう', '太陽', '태양', (SELECT id FROM tbl_content_kana WHERE character = 'た' AND script = 'hira')),
  ('たまご', '卵', '계란', (SELECT id FROM tbl_content_kana WHERE character = 'た' AND script = 'hira')),

  ('ちいさい', '小さい', '작다', (SELECT id FROM tbl_content_kana WHERE character = 'ち' AND script = 'hira')),
  ('ちず', '地図', '지도', (SELECT id FROM tbl_content_kana WHERE character = 'ち' AND script = 'hira')),
  ('ちから', '力', '힘', (SELECT id FROM tbl_content_kana WHERE character = 'ち' AND script = 'hira')),

  ('つき', '月', '달', (SELECT id FROM tbl_content_kana WHERE character = 'つ' AND script = 'hira')),
  ('つくえ', '机', '책상', (SELECT id FROM tbl_content_kana WHERE character = 'つ' AND script = 'hira')),
  ('つよい', '強い', '강하다', (SELECT id FROM tbl_content_kana WHERE character = 'つ' AND script = 'hira')),

  ('てがみ', '手紙', '편지', (SELECT id FROM tbl_content_kana WHERE character = 'て' AND script = 'hira')),
  ('てんき', '天気', '날씨', (SELECT id FROM tbl_content_kana WHERE character = 'て' AND script = 'hira')),
  ('てつだう', '手伝う', '돕다', (SELECT id FROM tbl_content_kana WHERE character = 'て' AND script = 'hira')),

  ('とけい', '時計', '시계', (SELECT id FROM tbl_content_kana WHERE character = 'と' AND script = 'hira')),
  ('とり', '鳥', '새', (SELECT id FROM tbl_content_kana WHERE character = 'と' AND script = 'hira')),
  ('ともだち', '友達', '친구', (SELECT id FROM tbl_content_kana WHERE character = 'と' AND script = 'hira')),

  ('なつ', '夏', '여름', (SELECT id FROM tbl_content_kana WHERE character = 'な' AND script = 'hira')),
  ('なまえ', '名前', '이름', (SELECT id FROM tbl_content_kana WHERE character = 'な' AND script = 'hira')),
  ('ながい', '長い', '길다', (SELECT id FROM tbl_content_kana WHERE character = 'な' AND script = 'hira')),

  ('にほん', '日本', '일본', (SELECT id FROM tbl_content_kana WHERE character = 'に' AND script = 'hira')),
  ('にく', '肉', '고기', (SELECT id FROM tbl_content_kana WHERE character = 'に' AND script = 'hira')),
  ('にわ', '庭', '정원', (SELECT id FROM tbl_content_kana WHERE character = 'に' AND script = 'hira')),

  ('いぬ', '犬', '개', (SELECT id FROM tbl_content_kana WHERE character = 'ぬ' AND script = 'hira')),
  ('ぬの', '布', '천', (SELECT id FROM tbl_content_kana WHERE character = 'ぬ' AND script = 'hira')),
  ('ぬるい', '温い', '미지근하다', (SELECT id FROM tbl_content_kana WHERE character = 'ぬ' AND script = 'hira')),

  ('ねこ', '猫', '고양이', (SELECT id FROM tbl_content_kana WHERE character = 'ね' AND script = 'hira')),
  ('ねつ', '熱', '열', (SELECT id FROM tbl_content_kana WHERE character = 'ね' AND script = 'hira')),
  ('ねだん', '値段', '가격', (SELECT id FROM tbl_content_kana WHERE character = 'ね' AND script = 'hira')),

  ('のみもの', '飲み物', '음료', (SELECT id FROM tbl_content_kana WHERE character = 'の' AND script = 'hira')),
  ('のはら', '野原', '들판', (SELECT id FROM tbl_content_kana WHERE character = 'の' AND script = 'hira')),
  ('のる', '乗る', '타다', (SELECT id FROM tbl_content_kana WHERE character = 'の' AND script = 'hira')),

  ('はな', '花', '꽃', (SELECT id FROM tbl_content_kana WHERE character = 'は' AND script = 'hira')),
  ('はし', '橋', '다리', (SELECT id FROM tbl_content_kana WHERE character = 'は' AND script = 'hira')),
  ('はる', '春', '봄', (SELECT id FROM tbl_content_kana WHERE character = 'は' AND script = 'hira')),

  ('ひと', '人', '사람', (SELECT id FROM tbl_content_kana WHERE character = 'ひ' AND script = 'hira')),
  ('ひかり', '光', '빛', (SELECT id FROM tbl_content_kana WHERE character = 'ひ' AND script = 'hira')),
  ('ひこうき', '飛行機', '비행기', (SELECT id FROM tbl_content_kana WHERE character = 'ひ' AND script = 'hira')),

  ('ふゆ', '冬', '겨울', (SELECT id FROM tbl_content_kana WHERE character = 'ふ' AND script = 'hira')),
  ('ふね', '船', '배', (SELECT id FROM tbl_content_kana WHERE character = 'ふ' AND script = 'hira')),
  ('ふうふ', '夫婦', '부부', (SELECT id FROM tbl_content_kana WHERE character = 'ふ' AND script = 'hira')),

  ('へや', '部屋', '방', (SELECT id FROM tbl_content_kana WHERE character = 'へ' AND script = 'hira')),
  ('へいわ', '平和', '평화', (SELECT id FROM tbl_content_kana WHERE character = 'へ' AND script = 'hira')),
  ('へた', '下手', '서투름', (SELECT id FROM tbl_content_kana WHERE character = 'へ' AND script = 'hira')),

  ('ほん', '本', '책', (SELECT id FROM tbl_content_kana WHERE character = 'ほ' AND script = 'hira')),
  ('ほし', '星', '별', (SELECT id FROM tbl_content_kana WHERE character = 'ほ' AND script = 'hira')),
  ('ほうこう', '方向', '방향', (SELECT id FROM tbl_content_kana WHERE character = 'ほ' AND script = 'hira')),

  ('まど', '窓', '창문', (SELECT id FROM tbl_content_kana WHERE character = 'ま' AND script = 'hira')),
  ('まち', '町', '마을', (SELECT id FROM tbl_content_kana WHERE character = 'ま' AND script = 'hira')),
  ('まいにち', '毎日', '매일', (SELECT id FROM tbl_content_kana WHERE character = 'ま' AND script = 'hira')),

  ('みず', '水', '물', (SELECT id FROM tbl_content_kana WHERE character = 'み' AND script = 'hira')),
  ('みち', '道', '길', (SELECT id FROM tbl_content_kana WHERE character = 'み' AND script = 'hira')),
  ('みどり', '緑', '초록', (SELECT id FROM tbl_content_kana WHERE character = 'み' AND script = 'hira')),

  ('むし', '虫', '벌레', (SELECT id FROM tbl_content_kana WHERE character = 'む' AND script = 'hira')),
  ('むかし', '昔', '옛날', (SELECT id FROM tbl_content_kana WHERE character = 'む' AND script = 'hira')),
  ('むすめ', '娘', '딸', (SELECT id FROM tbl_content_kana WHERE character = 'む' AND script = 'hira')),

  ('めがね', '眼鏡', '안경', (SELECT id FROM tbl_content_kana WHERE character = 'め' AND script = 'hira')),
  ('あめ', '雨', '비', (SELECT id FROM tbl_content_kana WHERE character = 'め' AND script = 'hira')),
  ('つめたい', '冷たい', '차갑다', (SELECT id FROM tbl_content_kana WHERE character = 'め' AND script = 'hira')),

  ('もも', '桃', '복숭아', (SELECT id FROM tbl_content_kana WHERE character = 'も' AND script = 'hira')),
  ('もり', '森', '숲', (SELECT id FROM tbl_content_kana WHERE character = 'も' AND script = 'hira')),
  ('くも', '雲', '구름', (SELECT id FROM tbl_content_kana WHERE character = 'も' AND script = 'hira')),

  ('やま', '山', '산', (SELECT id FROM tbl_content_kana WHERE character = 'や' AND script = 'hira')),
  ('やさい', '野菜', '채소', (SELECT id FROM tbl_content_kana WHERE character = 'や' AND script = 'hira')),
  ('やすい', '安い', '싸다', (SELECT id FROM tbl_content_kana WHERE character = 'や' AND script = 'hira')),

  ('ゆき', '雪', '눈', (SELECT id FROM tbl_content_kana WHERE character = 'ゆ' AND script = 'hira')),
  ('ゆめ', '夢', '꿈', (SELECT id FROM tbl_content_kana WHERE character = 'ゆ' AND script = 'hira')),
  ('ゆうがた', '夕方', '저녁', (SELECT id FROM tbl_content_kana WHERE character = 'ゆ' AND script = 'hira')),

  ('よる', '夜', '밤', (SELECT id FROM tbl_content_kana WHERE character = 'よ' AND script = 'hira')),
  ('よてい', '予定', '예정', (SELECT id FROM tbl_content_kana WHERE character = 'よ' AND script = 'hira')),
  ('よわい', '弱い', '약하다', (SELECT id FROM tbl_content_kana WHERE character = 'よ' AND script = 'hira')),

  ('さくら', '桜', '벚꽃', (SELECT id FROM tbl_content_kana WHERE character = 'ら' AND script = 'hira')),
  ('らいねん', '来年', '내년', (SELECT id FROM tbl_content_kana WHERE character = 'ら' AND script = 'hira')),
  ('そら', '空', '하늘', (SELECT id FROM tbl_content_kana WHERE character = 'ら' AND script = 'hira')),

  ('りんご', '林檎', '사과', (SELECT id FROM tbl_content_kana WHERE character = 'り' AND script = 'hira')),
  ('りゆう', '理由', '이유', (SELECT id FROM tbl_content_kana WHERE character = 'り' AND script = 'hira')),
  ('とり', '鳥', '새', (SELECT id FROM tbl_content_kana WHERE character = 'り' AND script = 'hira')),

  ('つくる', '作る', '만들다', (SELECT id FROM tbl_content_kana WHERE character = 'る' AND script = 'hira')),
  ('くるま', '車', '자동차', (SELECT id FROM tbl_content_kana WHERE character = 'る' AND script = 'hira')),
  ('はる', '春', '봄', (SELECT id FROM tbl_content_kana WHERE character = 'る' AND script = 'hira')),

  ('これ', '', '이것', (SELECT id FROM tbl_content_kana WHERE character = 'れ' AND script = 'hira')),
  ('だれ', '誰', '누구', (SELECT id FROM tbl_content_kana WHERE character = 'れ' AND script = 'hira')),
  ('れきし', '歴史', '역사', (SELECT id FROM tbl_content_kana WHERE character = 'れ' AND script = 'hira')),

  ('いろ', '色', '색', (SELECT id FROM tbl_content_kana WHERE character = 'ろ' AND script = 'hira')),
  ('ところ', '所', '장소', (SELECT id FROM tbl_content_kana WHERE character = 'ろ' AND script = 'hira')),
  ('しろい', '白い', '하얗다', (SELECT id FROM tbl_content_kana WHERE character = 'ろ' AND script = 'hira')),

  ('わたし', '私', '나', (SELECT id FROM tbl_content_kana WHERE character = 'わ' AND script = 'hira')),
  ('かわ', '川', '강', (SELECT id FROM tbl_content_kana WHERE character = 'わ' AND script = 'hira')),
  ('わかい', '若い', '젊다', (SELECT id FROM tbl_content_kana WHERE character = 'わ' AND script = 'hira')),

  ('を', '', '~을/를 (조사)', (SELECT id FROM tbl_content_kana WHERE character = 'を' AND script = 'hira')),

  ('ほん', '本', '책', (SELECT id FROM tbl_content_kana WHERE character = 'ん' AND script = 'hira')),
  ('せんせい', '先生', '선생님', (SELECT id FROM tbl_content_kana WHERE character = 'ん' AND script = 'hira')),
  ('にほん', '日本', '일본', (SELECT id FROM tbl_content_kana WHERE character = 'ん' AND script = 'hira'))
ON CONFLICT (kana_id, surface) DO NOTHING;


-- 가나 예시 단어 추가 (KanaExample) - 히라가나 탁음/반탁음 (が~ぽ)
INSERT INTO tbl_content_kanaexample (surface, kanji, meaning_ko, kana_id) VALUES
  ('がっこう', '学校', '학교', (SELECT id FROM tbl_content_kana WHERE character = 'が' AND script = 'hira')),
  ('かがみ', '鏡', '거울', (SELECT id FROM tbl_content_kana WHERE character = 'が' AND script = 'hira')),
  ('えいが', '映画', '영화', (SELECT id FROM tbl_content_kana WHERE character = 'が' AND script = 'hira')),

  ('ぎんこう', '銀行', '은행', (SELECT id FROM tbl_content_kana WHERE character = 'ぎ' AND script = 'hira')),
  ('かぎ', '鍵', '열쇠', (SELECT id FROM tbl_content_kana WHERE character = 'ぎ' AND script = 'hira')),
  ('たまねぎ', '玉ねぎ', '양파', (SELECT id FROM tbl_content_kana WHERE character = 'ぎ' AND script = 'hira')),

  ('かぐ', '家具', '가구', (SELECT id FROM tbl_content_kana WHERE character = 'ぐ' AND script = 'hira')),
  ('すぐ', '直ぐ', '바로', (SELECT id FROM tbl_content_kana WHERE character = 'ぐ' AND script = 'hira')),
  ('ぐあい', '具合', '상태', (SELECT id FROM tbl_content_kana WHERE character = 'ぐ' AND script = 'hira')),

  ('げんき', '元気', '기운', (SELECT id FROM tbl_content_kana WHERE character = 'げ' AND script = 'hira')),
  ('ひげ', '髭', '수염', (SELECT id FROM tbl_content_kana WHERE character = 'げ' AND script = 'hira')),
  ('かげ', '影', '그림자', (SELECT id FROM tbl_content_kana WHERE character = 'げ' AND script = 'hira')),

  ('ごはん', 'ご飯', '밥', (SELECT id FROM tbl_content_kana WHERE character = 'ご' AND script = 'hira')),
  ('えいご', '英語', '영어', (SELECT id FROM tbl_content_kana WHERE character = 'ご' AND script = 'hira')),
  ('ごご', '午後', '오후', (SELECT id FROM tbl_content_kana WHERE character = 'ご' AND script = 'hira')),

  ('ざっし', '雑誌', '잡지', (SELECT id FROM tbl_content_kana WHERE character = 'ざ' AND script = 'hira')),
  ('ひざ', '膝', '무릎', (SELECT id FROM tbl_content_kana WHERE character = 'ざ' AND script = 'hira')),
  ('かざん', '火山', '화산', (SELECT id FROM tbl_content_kana WHERE character = 'ざ' AND script = 'hira')),

  ('じかん', '時間', '시간', (SELECT id FROM tbl_content_kana WHERE character = 'じ' AND script = 'hira')),
  ('じてんしゃ', '自転車', '자전거', (SELECT id FROM tbl_content_kana WHERE character = 'じ' AND script = 'hira')),
  ('かじ', '家事', '집안일', (SELECT id FROM tbl_content_kana WHERE character = 'じ' AND script = 'hira')),

  ('ずつう', '頭痛', '두통', (SELECT id FROM tbl_content_kana WHERE character = 'ず' AND script = 'hira')),
  ('かず', '数', '개수', (SELECT id FROM tbl_content_kana WHERE character = 'ず' AND script = 'hira')),
  ('みず', '水', '물', (SELECT id FROM tbl_content_kana WHERE character = 'ず' AND script = 'hira')),

  ('ぜんぶ', '全部', '전부', (SELECT id FROM tbl_content_kana WHERE character = 'ぜ' AND script = 'hira')),
  ('かぜ', '風', '바람', (SELECT id FROM tbl_content_kana WHERE character = 'ぜ' AND script = 'hira')),
  ('ぜいきん', '税金', '세금', (SELECT id FROM tbl_content_kana WHERE character = 'ぜ' AND script = 'hira')),

  ('ぞう', '象', '코끼리', (SELECT id FROM tbl_content_kana WHERE character = 'ぞ' AND script = 'hira')),
  ('かぞく', '家族', '가족', (SELECT id FROM tbl_content_kana WHERE character = 'ぞ' AND script = 'hira')),
  ('なぞ', '謎', '수수께끼', (SELECT id FROM tbl_content_kana WHERE character = 'ぞ' AND script = 'hira')),

  ('だいがく', '大学', '대학교', (SELECT id FROM tbl_content_kana WHERE character = 'だ' AND script = 'hira')),
  ('からだ', '体', '몸', (SELECT id FROM tbl_content_kana WHERE character = 'だ' AND script = 'hira')),
  ('だれ', '誰', '누구', (SELECT id FROM tbl_content_kana WHERE character = 'だ' AND script = 'hira')),

  ('はなぢ', '鼻血', '코피', (SELECT id FROM tbl_content_kana WHERE character = 'ぢ' AND script = 'hira')),
  ('ちぢむ', '縮む', '줄어들다', (SELECT id FROM tbl_content_kana WHERE character = 'ぢ' AND script = 'hira')),

  ('つづく', '続く', '계속되다', (SELECT id FROM tbl_content_kana WHERE character = 'づ' AND script = 'hira')),
  ('きづく', '気づく', '알아차리다', (SELECT id FROM tbl_content_kana WHERE character = 'づ' AND script = 'hira')),

  ('でんわ', '電話', '전화', (SELECT id FROM tbl_content_kana WHERE character = 'で' AND script = 'hira')),
  ('でんしゃ', '電車', '전철', (SELECT id FROM tbl_content_kana WHERE character = 'で' AND script = 'hira')),
  ('でぐち', '出口', '출구', (SELECT id FROM tbl_content_kana WHERE character = 'で' AND script = 'hira')),

  ('どようび', '土曜日', '토요일', (SELECT id FROM tbl_content_kana WHERE character = 'ど' AND script = 'hira')),
  ('どうぶつ', '動物', '동물', (SELECT id FROM tbl_content_kana WHERE character = 'ど' AND script = 'hira')),
  ('まど', '窓', '창문', (SELECT id FROM tbl_content_kana WHERE character = 'ど' AND script = 'hira')),

  ('ばしょ', '場所', '장소', (SELECT id FROM tbl_content_kana WHERE character = 'ば' AND script = 'hira')),
  ('かばん', '鞄', '가방', (SELECT id FROM tbl_content_kana WHERE character = 'ば' AND script = 'hira')),
  ('たばこ', '煙草', '담배', (SELECT id FROM tbl_content_kana WHERE character = 'ば' AND script = 'hira')),

  ('びょういん', '病院', '병원', (SELECT id FROM tbl_content_kana WHERE character = 'び' AND script = 'hira')),
  ('えび', '海老', '새우', (SELECT id FROM tbl_content_kana WHERE character = 'び' AND script = 'hira')),
  ('ゆび', '指', '손가락', (SELECT id FROM tbl_content_kana WHERE character = 'び' AND script = 'hira')),

  ('ぶた', '豚', '돼지', (SELECT id FROM tbl_content_kana WHERE character = 'ぶ' AND script = 'hira')),
  ('ぶどう', '葡萄', '포도', (SELECT id FROM tbl_content_kana WHERE character = 'ぶ' AND script = 'hira')),
  ('かぶ', '株', '주식', (SELECT id FROM tbl_content_kana WHERE character = 'ぶ' AND script = 'hira')),

  ('べんきょう', '勉強', '공부', (SELECT id FROM tbl_content_kana WHERE character = 'べ' AND script = 'hira')),
  ('たべる', '食べる', '먹다', (SELECT id FROM tbl_content_kana WHERE character = 'べ' AND script = 'hira')),
  ('なべ', '鍋', '냄비', (SELECT id FROM tbl_content_kana WHERE character = 'べ' AND script = 'hira')),

  ('ぼうし', '帽子', '모자', (SELECT id FROM tbl_content_kana WHERE character = 'ぼ' AND script = 'hira')),
  ('ぼく', '僕', '나', (SELECT id FROM tbl_content_kana WHERE character = 'ぼ' AND script = 'hira')),
  ('そぼ', '祖母', '할머니', (SELECT id FROM tbl_content_kana WHERE character = 'ぼ' AND script = 'hira')),

  ('かんぱい', '乾杯', '건배', (SELECT id FROM tbl_content_kana WHERE character = 'ぱ' AND script = 'hira')),
  ('せんぱい', '先輩', '선배', (SELECT id FROM tbl_content_kana WHERE character = 'ぱ' AND script = 'hira')),
  ('いっぱい', '一杯', '가득', (SELECT id FROM tbl_content_kana WHERE character = 'ぱ' AND script = 'hira')),

  ('えんぴつ', '鉛筆', '연필', (SELECT id FROM tbl_content_kana WHERE character = 'ぴ' AND script = 'hira')),
  ('はっぴょう', '発表', '발표', (SELECT id FROM tbl_content_kana WHERE character = 'ぴ' AND script = 'hira')),
  ('ぴかぴか', '', '반짝반짝', (SELECT id FROM tbl_content_kana WHERE character = 'ぴ' AND script = 'hira')),

  ('てんぷら', '天ぷら', '튀김', (SELECT id FROM tbl_content_kana WHERE character = 'ぷ' AND script = 'hira')),
  ('きっぷ', '切符', '표', (SELECT id FROM tbl_content_kana WHERE character = 'ぷ' AND script = 'hira')),
  ('ぷりぷり', '', '탱글탱글', (SELECT id FROM tbl_content_kana WHERE character = 'ぷ' AND script = 'hira')),

  ('かんぺき', '完璧', '완벽', (SELECT id FROM tbl_content_kana WHERE character = 'ぺ' AND script = 'hira')),
  ('ぺらぺら', '', '술술(유창하게)', (SELECT id FROM tbl_content_kana WHERE character = 'ぺ' AND script = 'hira')),
  ('たんぺん', '短編', '단편', (SELECT id FROM tbl_content_kana WHERE character = 'ぺ' AND script = 'hira')),

  ('さんぽ', '散歩', '산책', (SELECT id FROM tbl_content_kana WHERE character = 'ぽ' AND script = 'hira')),
  ('たんぽぽ', '蒲公英', '민들레', (SELECT id FROM tbl_content_kana WHERE character = 'ぽ' AND script = 'hira')),
  ('ぽかぽか', '', '따뜻하고 포근한', (SELECT id FROM tbl_content_kana WHERE character = 'ぽ' AND script = 'hira'))
ON CONFLICT (kana_id, surface) DO NOTHING;


-- 가나 예시 단어 추가 (KanaExample) - 히라가나 요음 (きゃ~ぽ)
-- 주의: みゅ, びゅ, ぴゅ 는 실제로 자연스럽게 쓰이는 고유어/일반 단어가 없어(주로 외래어 음역에만 등장) 제외함
INSERT INTO tbl_content_kanaexample (surface, kanji, meaning_ko, kana_id) VALUES
  ('きゃく', '客', '손님', (SELECT id FROM tbl_content_kana WHERE character = 'きゃ' AND script = 'hira')),
  ('きゃくしつ', '客室', '객실', (SELECT id FROM tbl_content_kana WHERE character = 'きゃ' AND script = 'hira')),
  ('きゃくせき', '客席', '객석', (SELECT id FROM tbl_content_kana WHERE character = 'きゃ' AND script = 'hira')),

  ('きゅうり', '胡瓜', '오이', (SELECT id FROM tbl_content_kana WHERE character = 'きゅ' AND script = 'hira')),
  ('きゅうけい', '休憩', '휴식', (SELECT id FROM tbl_content_kana WHERE character = 'きゅ' AND script = 'hira')),
  ('やきゅう', '野球', '야구', (SELECT id FROM tbl_content_kana WHERE character = 'きゅ' AND script = 'hira')),

  ('きょう', '今日', '오늘', (SELECT id FROM tbl_content_kana WHERE character = 'きょ' AND script = 'hira')),
  ('きょうしつ', '教室', '교실', (SELECT id FROM tbl_content_kana WHERE character = 'きょ' AND script = 'hira')),
  ('とうきょう', '東京', '도쿄', (SELECT id FROM tbl_content_kana WHERE character = 'きょ' AND script = 'hira')),

  ('しゃしん', '写真', '사진', (SELECT id FROM tbl_content_kana WHERE character = 'しゃ' AND script = 'hira')),
  ('かいしゃ', '会社', '회사', (SELECT id FROM tbl_content_kana WHERE character = 'しゃ' AND script = 'hira')),
  ('でんしゃ', '電車', '전철', (SELECT id FROM tbl_content_kana WHERE character = 'しゃ' AND script = 'hira')),

  ('しゅみ', '趣味', '취미', (SELECT id FROM tbl_content_kana WHERE character = 'しゅ' AND script = 'hira')),
  ('しゅくだい', '宿題', '숙제', (SELECT id FROM tbl_content_kana WHERE character = 'しゅ' AND script = 'hira')),
  ('かしゅ', '歌手', '가수', (SELECT id FROM tbl_content_kana WHERE character = 'しゅ' AND script = 'hira')),

  ('しょくじ', '食事', '식사', (SELECT id FROM tbl_content_kana WHERE character = 'しょ' AND script = 'hira')),
  ('としょかん', '図書館', '도서관', (SELECT id FROM tbl_content_kana WHERE character = 'しょ' AND script = 'hira')),
  ('しょうがっこう', '小学校', '초등학교', (SELECT id FROM tbl_content_kana WHERE character = 'しょ' AND script = 'hira')),

  ('おちゃ', 'お茶', '차', (SELECT id FROM tbl_content_kana WHERE character = 'ちゃ' AND script = 'hira')),
  ('ちゃいろ', '茶色', '갈색', (SELECT id FROM tbl_content_kana WHERE character = 'ちゃ' AND script = 'hira')),
  ('ちゃわん', '茶碗', '찻잔', (SELECT id FROM tbl_content_kana WHERE character = 'ちゃ' AND script = 'hira')),

  ('ちゅうい', '注意', '주의', (SELECT id FROM tbl_content_kana WHERE character = 'ちゅ' AND script = 'hira')),
  ('ちゅうがっこう', '中学校', '중학교', (SELECT id FROM tbl_content_kana WHERE character = 'ちゅ' AND script = 'hira')),
  ('ちゅうごく', '中国', '중국', (SELECT id FROM tbl_content_kana WHERE character = 'ちゅ' AND script = 'hira')),

  ('ちょきん', '貯金', '저금', (SELECT id FROM tbl_content_kana WHERE character = 'ちょ' AND script = 'hira')),
  ('ちょうしょく', '朝食', '아침식사', (SELECT id FROM tbl_content_kana WHERE character = 'ちょ' AND script = 'hira')),
  ('ちょっと', '', '잠깐', (SELECT id FROM tbl_content_kana WHERE character = 'ちょ' AND script = 'hira')),

  ('にゃんこ', '', '고양이', (SELECT id FROM tbl_content_kana WHERE character = 'にゃ' AND script = 'hira')),
  ('こんにゃく', '蒟蒻', '곤약', (SELECT id FROM tbl_content_kana WHERE character = 'にゃ' AND script = 'hira')),

  ('にゅうがく', '入学', '입학', (SELECT id FROM tbl_content_kana WHERE character = 'にゅ' AND script = 'hira')),
  ('ぎゅうにゅう', '牛乳', '우유', (SELECT id FROM tbl_content_kana WHERE character = 'にゅ' AND script = 'hira')),
  ('にゅういん', '入院', '입원', (SELECT id FROM tbl_content_kana WHERE character = 'にゅ' AND script = 'hira')),

  ('にょろにょろ', '', '꿈틀꿈틀', (SELECT id FROM tbl_content_kana WHERE character = 'にょ' AND script = 'hira')),

  ('ひゃく', '百', '백', (SELECT id FROM tbl_content_kana WHERE character = 'ひゃ' AND script = 'hira')),
  ('ひゃくえん', '百円', '백엔', (SELECT id FROM tbl_content_kana WHERE character = 'ひゃ' AND script = 'hira')),

  ('ひゅー', '', '휭(바람 소리)', (SELECT id FROM tbl_content_kana WHERE character = 'ひゅ' AND script = 'hira')),

  ('ひょう', '表', '표', (SELECT id FROM tbl_content_kana WHERE character = 'ひょ' AND script = 'hira')),
  ('ひょうげん', '表現', '표현', (SELECT id FROM tbl_content_kana WHERE character = 'ひょ' AND script = 'hira')),
  ('ひょうし', '表紙', '표지', (SELECT id FROM tbl_content_kana WHERE character = 'ひょ' AND script = 'hira')),

  ('みゃく', '脈', '맥박', (SELECT id FROM tbl_content_kana WHERE character = 'みゃ' AND script = 'hira')),
  ('さんみゃく', '山脈', '산맥', (SELECT id FROM tbl_content_kana WHERE character = 'みゃ' AND script = 'hira')),

  ('みょうじ', '名字', '성(姓)', (SELECT id FROM tbl_content_kana WHERE character = 'みょ' AND script = 'hira')),
  ('みょうにち', '明日', '내일(공식 표현)', (SELECT id FROM tbl_content_kana WHERE character = 'みょ' AND script = 'hira')),

  ('りゃくご', '略語', '줄임말', (SELECT id FROM tbl_content_kana WHERE character = 'りゃ' AND script = 'hira')),
  ('しょうりゃく', '省略', '생략', (SELECT id FROM tbl_content_kana WHERE character = 'りゃ' AND script = 'hira')),

  ('りゅう', '竜', '용', (SELECT id FROM tbl_content_kana WHERE character = 'りゅ' AND script = 'hira')),
  ('りゅうがく', '留学', '유학', (SELECT id FROM tbl_content_kana WHERE character = 'りゅ' AND script = 'hira')),
  ('こうりゅう', '交流', '교류', (SELECT id FROM tbl_content_kana WHERE character = 'りゅ' AND script = 'hira')),

  ('りょこう', '旅行', '여행', (SELECT id FROM tbl_content_kana WHERE character = 'りょ' AND script = 'hira')),
  ('りょうり', '料理', '요리', (SELECT id FROM tbl_content_kana WHERE character = 'りょ' AND script = 'hira')),
  ('りょうしん', '両親', '부모님', (SELECT id FROM tbl_content_kana WHERE character = 'りょ' AND script = 'hira')),

  ('ぎゃく', '逆', '반대', (SELECT id FROM tbl_content_kana WHERE character = 'ぎゃ' AND script = 'hira')),
  ('ぎゃくてん', '逆転', '역전', (SELECT id FROM tbl_content_kana WHERE character = 'ぎゃ' AND script = 'hira')),

  ('ぎゅうにゅう', '牛乳', '우유', (SELECT id FROM tbl_content_kana WHERE character = 'ぎゅ' AND script = 'hira')),
  ('ぎゅうにく', '牛肉', '소고기', (SELECT id FROM tbl_content_kana WHERE character = 'ぎゅ' AND script = 'hira')),
  ('ぎゅっと', '', '꽉', (SELECT id FROM tbl_content_kana WHERE character = 'ぎゅ' AND script = 'hira')),

  ('ぎょうざ', '餃子', '교자', (SELECT id FROM tbl_content_kana WHERE character = 'ぎょ' AND script = 'hira')),
  ('きんぎょ', '金魚', '금붕어', (SELECT id FROM tbl_content_kana WHERE character = 'ぎょ' AND script = 'hira')),
  ('ぎょせん', '漁船', '어선', (SELECT id FROM tbl_content_kana WHERE character = 'ぎょ' AND script = 'hira')),

  ('じゃがいも', 'じゃが芋', '감자', (SELECT id FROM tbl_content_kana WHERE character = 'じゃ' AND script = 'hira')),
  ('じゃま', '邪魔', '방해', (SELECT id FROM tbl_content_kana WHERE character = 'じゃ' AND script = 'hira')),
  ('じゃんけん', '', '가위바위보', (SELECT id FROM tbl_content_kana WHERE character = 'じゃ' AND script = 'hira')),

  ('じゅぎょう', '授業', '수업', (SELECT id FROM tbl_content_kana WHERE character = 'じゅ' AND script = 'hira')),
  ('じゅんび', '準備', '준비', (SELECT id FROM tbl_content_kana WHERE character = 'じゅ' AND script = 'hira')),
  ('じゅう', '十', '열', (SELECT id FROM tbl_content_kana WHERE character = 'じゅ' AND script = 'hira')),

  ('じょうず', '上手', '잘함', (SELECT id FROM tbl_content_kana WHERE character = 'じょ' AND script = 'hira')),
  ('じょうほう', '情報', '정보', (SELECT id FROM tbl_content_kana WHERE character = 'じょ' AND script = 'hira')),
  ('かのじょ', '彼女', '그녀', (SELECT id FROM tbl_content_kana WHERE character = 'じょ' AND script = 'hira')),

  ('さんびゃく', '三百', '삼백', (SELECT id FROM tbl_content_kana WHERE character = 'びゃ' AND script = 'hira')),
  ('さんびゃくえん', '三百円', '삼백 엔', (SELECT id FROM tbl_content_kana WHERE character = 'びゃ' AND script = 'hira')),
  ('さんびゃくにん', '三百人', '삼백 명', (SELECT id FROM tbl_content_kana WHERE character = 'びゃ' AND script = 'hira')),

  ('びょういん', '病院', '병원', (SELECT id FROM tbl_content_kana WHERE character = 'びょ' AND script = 'hira')),
  ('びょうき', '病気', '병', (SELECT id FROM tbl_content_kana WHERE character = 'びょ' AND script = 'hira')),
  ('びょう', '秒', '초', (SELECT id FROM tbl_content_kana WHERE character = 'びょ' AND script = 'hira')),

  ('ろっぴゃく', '六百', '육백', (SELECT id FROM tbl_content_kana WHERE character = 'ぴゃ' AND script = 'hira')),
  ('はっぴゃく', '八百', '팔백', (SELECT id FROM tbl_content_kana WHERE character = 'ぴゃ' AND script = 'hira')),

  ('でんぴょう', '伝票', '전표', (SELECT id FROM tbl_content_kana WHERE character = 'ぴょ' AND script = 'hira'))
  ('はっぴょう', '発表', '발표', (SELECT id FROM tbl_content_kana WHERE character = 'ぴょ' AND script = 'hira'))
ON CONFLICT (kana_id, surface) DO NOTHING;


-- 가나 예시 단어 추가 (KanaExample) - 가타카나 청음 (ア~ン)
-- 주의: ヲ 는 현대 가타카나 외래어/고유명사에서 거의 쓰이지 않아 제외함
INSERT INTO tbl_content_kanaexample (surface, kanji, meaning_ko, kana_id) VALUES
  ('アイス', '', '아이스크림', (SELECT id FROM tbl_content_kana WHERE character = 'ア' AND script = 'kata')),
  ('アメリカ', '', '미국', (SELECT id FROM tbl_content_kana WHERE character = 'ア' AND script = 'kata')),
  ('アパート', '', '아파트', (SELECT id FROM tbl_content_kana WHERE character = 'ア' AND script = 'kata')),

  ('アイス', '', '아이스크림', (SELECT id FROM tbl_content_kana WHERE character = 'イ' AND script = 'kata')),
  ('イタリア', '', '이탈리아', (SELECT id FROM tbl_content_kana WHERE character = 'イ' AND script = 'kata')),
  ('タイ', '', '태국', (SELECT id FROM tbl_content_kana WHERE character = 'イ' AND script = 'kata')),

  ('ウイスキー', '', '위스키', (SELECT id FROM tbl_content_kana WHERE character = 'ウ' AND script = 'kata')),
  ('ウインナー', '', '소시지', (SELECT id FROM tbl_content_kana WHERE character = 'ウ' AND script = 'kata')),
  ('ウール', '', '울(모직)', (SELECT id FROM tbl_content_kana WHERE character = 'ウ' AND script = 'kata')),

  ('エレベーター', '', '엘리베이터', (SELECT id FROM tbl_content_kana WHERE character = 'エ' AND script = 'kata')),
  ('エアコン', '', '에어컨', (SELECT id FROM tbl_content_kana WHERE character = 'エ' AND script = 'kata')),
  ('エネルギー', '', '에너지', (SELECT id FROM tbl_content_kana WHERE character = 'エ' AND script = 'kata')),

  ('オレンジ', '', '오렌지', (SELECT id FROM tbl_content_kana WHERE character = 'オ' AND script = 'kata')),
  ('オムレツ', '', '오믈렛', (SELECT id FROM tbl_content_kana WHERE character = 'オ' AND script = 'kata')),
  ('ラジオ', '', '라디오', (SELECT id FROM tbl_content_kana WHERE character = 'オ' AND script = 'kata')),

  ('カメラ', '', '카메라', (SELECT id FROM tbl_content_kana WHERE character = 'カ' AND script = 'kata')),
  ('スカート', '', '치마', (SELECT id FROM tbl_content_kana WHERE character = 'カ' AND script = 'kata')),
  ('カード', '', '카드', (SELECT id FROM tbl_content_kana WHERE character = 'カ' AND script = 'kata')),

  ('スキー', '', '스키', (SELECT id FROM tbl_content_kana WHERE character = 'キ' AND script = 'kata')),
  ('キロ', '', '킬로', (SELECT id FROM tbl_content_kana WHERE character = 'キ' AND script = 'kata')),
  ('キッチン', '', '주방', (SELECT id FROM tbl_content_kana WHERE character = 'キ' AND script = 'kata')),

  ('クラス', '', '클래스', (SELECT id FROM tbl_content_kana WHERE character = 'ク' AND script = 'kata')),
  ('クッキー', '', '쿠키', (SELECT id FROM tbl_content_kana WHERE character = 'ク' AND script = 'kata')),
  ('クリスマス', '', '크리스마스', (SELECT id FROM tbl_content_kana WHERE character = 'ク' AND script = 'kata')),

  ('ケーキ', '', '케이크', (SELECT id FROM tbl_content_kana WHERE character = 'ケ' AND script = 'kata')),
  ('バスケット', '', '농구', (SELECT id FROM tbl_content_kana WHERE character = 'ケ' AND script = 'kata')),
  ('バケツ', '', '양동이', (SELECT id FROM tbl_content_kana WHERE character = 'ケ' AND script = 'kata')),
  ('ケチャップ', '', '케첩', (SELECT id FROM tbl_content_kana WHERE character = 'ケ' AND script = 'kata')),

  ('コーヒー', '', '커피', (SELECT id FROM tbl_content_kana WHERE character = 'コ' AND script = 'kata')),
  ('コンピューター', '', '컴퓨터', (SELECT id FROM tbl_content_kana WHERE character = 'コ' AND script = 'kata')),
  ('コアラ', '', '코알라', (SELECT id FROM tbl_content_kana WHERE character = 'コ' AND script = 'kata')),

  ('サラダ', '', '샐러드', (SELECT id FROM tbl_content_kana WHERE character = 'サ' AND script = 'kata')),
  ('サッカー', '', '축구', (SELECT id FROM tbl_content_kana WHERE character = 'サ' AND script = 'kata')),
  ('サンドイッチ', '', '샌드위치', (SELECT id FROM tbl_content_kana WHERE character = 'サ' AND script = 'kata')),

  ('シャワー', '', '샤워', (SELECT id FROM tbl_content_kana WHERE character = 'シ' AND script = 'kata')),
  ('タクシー', '', '택시', (SELECT id FROM tbl_content_kana WHERE character = 'シ' AND script = 'kata')),
  ('シチュー', '', '스튜', (SELECT id FROM tbl_content_kana WHERE character = 'シ' AND script = 'kata')),

  ('スープ', '', '수프', (SELECT id FROM tbl_content_kana WHERE character = 'ス' AND script = 'kata')),
  ('バス', '', '버스', (SELECT id FROM tbl_content_kana WHERE character = 'ス' AND script = 'kata')),
  ('ストレス', '', '스트레스', (SELECT id FROM tbl_content_kana WHERE character = 'ス' AND script = 'kata')),

  ('セーター', '', '스웨터', (SELECT id FROM tbl_content_kana WHERE character = 'セ' AND script = 'kata')),
  ('センター', '', '센터', (SELECT id FROM tbl_content_kana WHERE character = 'セ' AND script = 'kata')),
  ('セロテープ', '', '셀로판테이프', (SELECT id FROM tbl_content_kana WHERE character = 'セ' AND script = 'kata')),

  ('ソース', '', '소스', (SELECT id FROM tbl_content_kana WHERE character = 'ソ' AND script = 'kata')),
  ('ソファ', '', '소파', (SELECT id FROM tbl_content_kana WHERE character = 'ソ' AND script = 'kata')),
  ('ソックス', '', '양말', (SELECT id FROM tbl_content_kana WHERE character = 'ソ' AND script = 'kata')),

  ('タクシー', '', '택시', (SELECT id FROM tbl_content_kana WHERE character = 'タ' AND script = 'kata')),
  ('タオル', '', '수건', (SELECT id FROM tbl_content_kana WHERE character = 'タ' AND script = 'kata')),
  ('データ', '', '데이터', (SELECT id FROM tbl_content_kana WHERE character = 'タ' AND script = 'kata')),

  ('チーズ', '', '치즈', (SELECT id FROM tbl_content_kana WHERE character = 'チ' AND script = 'kata')),
  ('チョコレート', '', '초콜릿', (SELECT id FROM tbl_content_kana WHERE character = 'チ' AND script = 'kata')),
  ('キッチン', '', '주방', (SELECT id FROM tbl_content_kana WHERE character = 'チ' AND script = 'kata')),

  ('ツアー', '', '투어', (SELECT id FROM tbl_content_kana WHERE character = 'ツ' AND script = 'kata')),
  ('ツイン', '', '트윈룸', (SELECT id FROM tbl_content_kana WHERE character = 'ツ' AND script = 'kata')),
  ('スーツ', '', '정장', (SELECT id FROM tbl_content_kana WHERE character = 'ツ' AND script = 'kata')),

  ('テレビ', '', '텔레비전', (SELECT id FROM tbl_content_kana WHERE character = 'テ' AND script = 'kata')),
  ('テーブル', '', '테이블', (SELECT id FROM tbl_content_kana WHERE character = 'テ' AND script = 'kata')),
  ('ホテル', '', '호텔', (SELECT id FROM tbl_content_kana WHERE character = 'テ' AND script = 'kata')),

  ('トマト', '', '토마토', (SELECT id FROM tbl_content_kana WHERE character = 'ト' AND script = 'kata')),
  ('トイレ', '', '화장실', (SELECT id FROM tbl_content_kana WHERE character = 'ト' AND script = 'kata')),
  ('トースト', '', '토스트', (SELECT id FROM tbl_content_kana WHERE character = 'ト' AND script = 'kata')),

  ('バナナ', '', '바나나', (SELECT id FROM tbl_content_kana WHERE character = 'ナ' AND script = 'kata')),
  ('ナイフ', '', '칼', (SELECT id FROM tbl_content_kana WHERE character = 'ナ' AND script = 'kata')),
  ('カナダ', '', '캐나다', (SELECT id FROM tbl_content_kana WHERE character = 'ナ' AND script = 'kata')),

  ('テニス', '', '테니스', (SELECT id FROM tbl_content_kana WHERE character = 'ニ' AND script = 'kata')),
  ('ニュース', '', '뉴스', (SELECT id FROM tbl_content_kana WHERE character = 'ニ' AND script = 'kata')),
  ('コンビニ', '', '편의점', (SELECT id FROM tbl_content_kana WHERE character = 'ニ' AND script = 'kata')),

  ('カヌー', '', '카누', (SELECT id FROM tbl_content_kana WHERE character = 'ヌ' AND script = 'kata')),
  ('ヌードル', '', '누들(면)', (SELECT id FROM tbl_content_kana WHERE character = 'ヌ' AND script = 'kata')),

  ('インターネット', '', '인터넷', (SELECT id FROM tbl_content_kana WHERE character = 'ネ' AND script = 'kata')),
  ('ネクタイ', '', '넥타이', (SELECT id FROM tbl_content_kana WHERE character = 'ネ' AND script = 'kata')),
  ('ネックレス', '', '목걸이', (SELECT id FROM tbl_content_kana WHERE character = 'ネ' AND script = 'kata')),

  ('ノート', '', '노트', (SELECT id FROM tbl_content_kana WHERE character = 'ノ' AND script = 'kata')),
  ('ピアノ', '', '피아노', (SELECT id FROM tbl_content_kana WHERE character = 'ノ' AND script = 'kata')),
  ('カジノ', '', '카지노', (SELECT id FROM tbl_content_kana WHERE character = 'ノ' AND script = 'kata')),

  ('ハンバーガー', '', '햄버거', (SELECT id FROM tbl_content_kana WHERE character = 'ハ' AND script = 'kata')),
  ('ハンカチ', '', '손수건', (SELECT id FROM tbl_content_kana WHERE character = 'ハ' AND script = 'kata')),
  ('ハワイ', '', '하와이', (SELECT id FROM tbl_content_kana WHERE character = 'ハ' AND script = 'kata')),

  ('ヒーター', '', '히터', (SELECT id FROM tbl_content_kana WHERE character = 'ヒ' AND script = 'kata')),
  ('コーヒー', '', '커피', (SELECT id FROM tbl_content_kana WHERE character = 'ヒ' AND script = 'kata')),
  ('ヒーロー', '', '히어로', (SELECT id FROM tbl_content_kana WHERE character = 'ヒ' AND script = 'kata')),

  ('フォーク', '', '포크', (SELECT id FROM tbl_content_kana WHERE character = 'フ' AND script = 'kata')),
  ('ソファ', '', '소파', (SELECT id FROM tbl_content_kana WHERE character = 'フ' AND script = 'kata')),
  ('フランス', '', '프랑스', (SELECT id FROM tbl_content_kana WHERE character = 'フ' AND script = 'kata')),

  ('ヘリコプター', '', '헬리콥터', (SELECT id FROM tbl_content_kana WHERE character = 'ヘ' AND script = 'kata')),
  ('ヘアスタイル', '', '헤어스타일', (SELECT id FROM tbl_content_kana WHERE character = 'ヘ' AND script = 'kata')),
  ('ヘルメット', '', '헬멧', (SELECT id FROM tbl_content_kana WHERE character = 'ヘ' AND script = 'kata')),

  ('ホテル', '', '호텔', (SELECT id FROM tbl_content_kana WHERE character = 'ホ' AND script = 'kata')),
  ('ホットドッグ', '', '핫도그', (SELECT id FROM tbl_content_kana WHERE character = 'ホ' AND script = 'kata')),
  ('ホラー', '', '호러(공포)', (SELECT id FROM tbl_content_kana WHERE character = 'ホ' AND script = 'kata')),

  ('マラソン', '', '마라톤', (SELECT id FROM tbl_content_kana WHERE character = 'マ' AND script = 'kata')),
  ('マスク', '', '마스크', (SELECT id FROM tbl_content_kana WHERE character = 'マ' AND script = 'kata')),
  ('トマト', '', '토마토', (SELECT id FROM tbl_content_kana WHERE character = 'マ' AND script = 'kata')),

  ('ミルク', '', '우유', (SELECT id FROM tbl_content_kana WHERE character = 'ミ' AND script = 'kata')),
  ('アルミ', '', '알루미늄', (SELECT id FROM tbl_content_kana WHERE character = 'ミ' AND script = 'kata')),
  ('ミラー', '', '거울', (SELECT id FROM tbl_content_kana WHERE character = 'ミ' AND script = 'kata')),

  ('ホーム', '', '플랫폼', (SELECT id FROM tbl_content_kana WHERE character = 'ム' AND script = 'kata')),
  ('チーム', '', '팀', (SELECT id FROM tbl_content_kana WHERE character = 'ム' AND script = 'kata')),
  ('アルバム', '', '앨범', (SELECT id FROM tbl_content_kana WHERE character = 'ム' AND script = 'kata')),

  ('メニュー', '', '메뉴', (SELECT id FROM tbl_content_kana WHERE character = 'メ' AND script = 'kata')),
  ('アメリカ', '', '미국', (SELECT id FROM tbl_content_kana WHERE character = 'メ' AND script = 'kata')),
  ('メロン', '', '멜론', (SELECT id FROM tbl_content_kana WHERE character = 'メ' AND script = 'kata')),

  ('モデル', '', '모델', (SELECT id FROM tbl_content_kana WHERE character = 'モ' AND script = 'kata')),
  ('レモン', '', '레몬', (SELECT id FROM tbl_content_kana WHERE character = 'モ' AND script = 'kata')),
  ('メモ', '', '메모', (SELECT id FROM tbl_content_kana WHERE character = 'モ' AND script = 'kata')),

  ('タイヤ', '', '타이어', (SELECT id FROM tbl_content_kana WHERE character = 'ヤ' AND script = 'kata')),
  ('ヤギ', '', '염소', (SELECT id FROM tbl_content_kana WHERE character = 'ヤ' AND script = 'kata')),
  ('ヒマラヤ', '', '히말라야', (SELECT id FROM tbl_content_kana WHERE character = 'ヤ' AND script = 'kata')),

  ('ユニフォーム', '', '유니폼', (SELECT id FROM tbl_content_kana WHERE character = 'ユ' AND script = 'kata')),
  ('ユーザー', '', '사용자', (SELECT id FROM tbl_content_kana WHERE character = 'ユ' AND script = 'kata')),
  ('ユーモア', '', '유머', (SELECT id FROM tbl_content_kana WHERE character = 'ユ' AND script = 'kata')),

  ('ヨーグルト', '', '요구르트', (SELECT id FROM tbl_content_kana WHERE character = 'ヨ' AND script = 'kata')),
  ('ヨット', '', '요트', (SELECT id FROM tbl_content_kana WHERE character = 'ヨ' AND script = 'kata')),
  ('ヨーロッパ', '', '유럽', (SELECT id FROM tbl_content_kana WHERE character = 'ヨ' AND script = 'kata')),

  ('サラダ', '', '샐러드', (SELECT id FROM tbl_content_kana WHERE character = 'ラ' AND script = 'kata')),
  ('ラジオ', '', '라디오', (SELECT id FROM tbl_content_kana WHERE character = 'ラ' AND script = 'kata')),
  ('レストラン', '', '레스토랑', (SELECT id FROM tbl_content_kana WHERE character = 'ラ' AND script = 'kata')),

  ('アメリカ', '', '미국', (SELECT id FROM tbl_content_kana WHERE character = 'リ' AND script = 'kata')),
  ('リボン', '', '리본', (SELECT id FROM tbl_content_kana WHERE character = 'リ' AND script = 'kata')),
  ('リズム', '', '리듬', (SELECT id FROM tbl_content_kana WHERE character = 'リ' AND script = 'kata')),

  ('テーブル', '', '테이블', (SELECT id FROM tbl_content_kana WHERE character = 'ル' AND script = 'kata')),
  ('ルール', '', '규칙', (SELECT id FROM tbl_content_kana WHERE character = 'ル' AND script = 'kata')),
  ('ビル', '', '빌딩', (SELECT id FROM tbl_content_kana WHERE character = 'ル' AND script = 'kata')),

  ('テレビ', '', '텔레비전', (SELECT id FROM tbl_content_kana WHERE character = 'レ' AND script = 'kata')),
  ('レストラン', '', '레스토랑', (SELECT id FROM tbl_content_kana WHERE character = 'レ' AND script = 'kata')),
  ('レシピ', '', '레시피', (SELECT id FROM tbl_content_kana WHERE character = 'レ' AND script = 'kata')),

  ('ロボット', '', '로봇', (SELECT id FROM tbl_content_kana WHERE character = 'ロ' AND script = 'kata')),
  ('ヒーロー', '', '히어로', (SELECT id FROM tbl_content_kana WHERE character = 'ロ' AND script = 'kata')),
  ('カタログ', '', '카탈로그', (SELECT id FROM tbl_content_kana WHERE character = 'ロ' AND script = 'kata')),

  ('ワイン', '', '와인', (SELECT id FROM tbl_content_kana WHERE character = 'ワ' AND script = 'kata')),
  ('ハワイ', '', '하와이', (SELECT id FROM tbl_content_kana WHERE character = 'ワ' AND script = 'kata')),
  ('ワッフル', '', '와플', (SELECT id FROM tbl_content_kana WHERE character = 'ワ' AND script = 'kata')),

  ('パン', '', '빵', (SELECT id FROM tbl_content_kana WHERE character = 'ン' AND script = 'kata')),
  ('レストラン', '', '레스토랑', (SELECT id FROM tbl_content_kana WHERE character = 'ン' AND script = 'kata')),
  ('ペン', '', '펜', (SELECT id FROM tbl_content_kana WHERE character = 'ン' AND script = 'kata'))
ON CONFLICT (kana_id, surface) DO NOTHING;


-- 가나 예시 단어 추가 (KanaExample) - 가타카나 탁음/반탁음 (ガ~ポ)
-- 주의: ヂ, ヅ 는 현대 외래어 표기에서 거의 안 쓰고 대부분 ジ/ズ로 통일 표기되어 제외함
INSERT INTO tbl_content_kanaexample (surface, kanji, meaning_ko, kana_id) VALUES
  ('ガム', '', '껌', (SELECT id FROM tbl_content_kana WHERE character = 'ガ' AND script = 'kata')),
  ('ガラス', '', '유리', (SELECT id FROM tbl_content_kana WHERE character = 'ガ' AND script = 'kata')),
  ('ハンバーガー', '', '햄버거', (SELECT id FROM tbl_content_kana WHERE character = 'ガ' AND script = 'kata')),

  ('ギター', '', '기타', (SELECT id FROM tbl_content_kana WHERE character = 'ギ' AND script = 'kata')),
  ('ギフト', '', '선물', (SELECT id FROM tbl_content_kana WHERE character = 'ギ' AND script = 'kata')),
  ('ギリシャ', '', '그리스', (SELECT id FROM tbl_content_kana WHERE character = 'ギ' AND script = 'kata')),

  ('グラス', '', '유리컵', (SELECT id FROM tbl_content_kana WHERE character = 'グ' AND script = 'kata')),
  ('グループ', '', '그룹', (SELECT id FROM tbl_content_kana WHERE character = 'グ' AND script = 'kata')),
  ('プログラム', '', '프로그램', (SELECT id FROM tbl_content_kana WHERE character = 'グ' AND script = 'kata')),

  ('ゲーム', '', '게임', (SELECT id FROM tbl_content_kana WHERE character = 'ゲ' AND script = 'kata')),
  ('ゲート', '', '게이트', (SELECT id FROM tbl_content_kana WHERE character = 'ゲ' AND script = 'kata')),
  ('ゲスト', '', '게스트', (SELECT id FROM tbl_content_kana WHERE character = 'ゲ' AND script = 'kata')),

  ('ゴルフ', '', '골프', (SELECT id FROM tbl_content_kana WHERE character = 'ゴ' AND script = 'kata')),
  ('タンゴ', '', '탱고', (SELECT id FROM tbl_content_kana WHERE character = 'ゴ' AND script = 'kata')),
  ('マンゴー', '', '망고', (SELECT id FROM tbl_content_kana WHERE character = 'ゴ' AND script = 'kata')),

  ('ピザ', '', '피자', (SELECT id FROM tbl_content_kana WHERE character = 'ザ' AND script = 'kata')),
  ('デザート', '', '디저트', (SELECT id FROM tbl_content_kana WHERE character = 'ザ' AND script = 'kata')),
  ('ザリガニ', '', '가재', (SELECT id FROM tbl_content_kana WHERE character = 'ザ' AND script = 'kata')),

  ('メッセージ', '', '메시지', (SELECT id FROM tbl_content_kana WHERE character = 'ジ' AND script = 'kata')),
  ('レジ', '', '계산대', (SELECT id FROM tbl_content_kana WHERE character = 'ジ' AND script = 'kata')),
  ('ジュース', '', '주스', (SELECT id FROM tbl_content_kana WHERE character = 'ジ' AND script = 'kata')),

  ('チーズ', '', '치즈', (SELECT id FROM tbl_content_kana WHERE character = 'ズ' AND script = 'kata')),
  ('サイズ', '', '사이즈', (SELECT id FROM tbl_content_kana WHERE character = 'ズ' AND script = 'kata')),
  ('ジーンズ', '', '청바지', (SELECT id FROM tbl_content_kana WHERE character = 'ズ' AND script = 'kata')),

  ('ゼロ', '', '제로', (SELECT id FROM tbl_content_kana WHERE character = 'ゼ' AND script = 'kata')),
  ('ゼリー', '', '젤리', (SELECT id FROM tbl_content_kana WHERE character = 'ゼ' AND script = 'kata')),

  ('リゾート', '', '리조트', (SELECT id FROM tbl_content_kana WHERE character = 'ゾ' AND script = 'kata')),
  ('ゾンビ', '', '좀비', (SELECT id FROM tbl_content_kana WHERE character = 'ゾ' AND script = 'kata')),

  ('サラダ', '', '샐러드', (SELECT id FROM tbl_content_kana WHERE character = 'ダ' AND script = 'kata')),
  ('ダンス', '', '댄스', (SELECT id FROM tbl_content_kana WHERE character = 'ダ' AND script = 'kata')),
  ('カナダ', '', '캐나다', (SELECT id FROM tbl_content_kana WHERE character = 'ダ' AND script = 'kata')),

  ('デザート', '', '디저트', (SELECT id FROM tbl_content_kana WHERE character = 'デ' AND script = 'kata')),
  ('デザイン', '', '디자인', (SELECT id FROM tbl_content_kana WHERE character = 'デ' AND script = 'kata')),
  ('データ', '', '데이터', (SELECT id FROM tbl_content_kana WHERE character = 'デ' AND script = 'kata')),

  ('ドア', '', '문', (SELECT id FROM tbl_content_kana WHERE character = 'ド' AND script = 'kata')),
  ('ホットドッグ', '', '핫도그', (SELECT id FROM tbl_content_kana WHERE character = 'ド' AND script = 'kata')),
  ('サンドイッチ', '', '샌드위치', (SELECT id FROM tbl_content_kana WHERE character = 'ド' AND script = 'kata')),

  ('バス', '', '버스', (SELECT id FROM tbl_content_kana WHERE character = 'バ' AND script = 'kata')),
  ('ハンバーガー', '', '햄버거', (SELECT id FROM tbl_content_kana WHERE character = 'バ' AND script = 'kata')),
  ('バナナ', '', '바나나', (SELECT id FROM tbl_content_kana WHERE character = 'バ' AND script = 'kata')),

  ('ビール', '', '맥주', (SELECT id FROM tbl_content_kana WHERE character = 'ビ' AND script = 'kata')),
  ('テレビ', '', '텔레비전', (SELECT id FROM tbl_content_kana WHERE character = 'ビ' AND script = 'kata')),
  ('コンビニ', '', '편의점', (SELECT id FROM tbl_content_kana WHERE character = 'ビ' AND script = 'kata')),

  ('クラブ', '', '클럽', (SELECT id FROM tbl_content_kana WHERE character = 'ブ' AND script = 'kata')),
  ('テーブル', '', '테이블', (SELECT id FROM tbl_content_kana WHERE character = 'ブ' AND script = 'kata')),
  ('ブランド', '', '브랜드', (SELECT id FROM tbl_content_kana WHERE character = 'ブ' AND script = 'kata')),

  ('ベッド', '', '침대', (SELECT id FROM tbl_content_kana WHERE character = 'ベ' AND script = 'kata')),
  ('ベルト', '', '벨트', (SELECT id FROM tbl_content_kana WHERE character = 'ベ' AND script = 'kata')),
  ('ベンチ', '', '벤치', (SELECT id FROM tbl_content_kana WHERE character = 'ベ' AND script = 'kata')),

  ('ボール', '', '공', (SELECT id FROM tbl_content_kana WHERE character = 'ボ' AND script = 'kata')),
  ('ロボット', '', '로봇', (SELECT id FROM tbl_content_kana WHERE character = 'ボ' AND script = 'kata')),
  ('ボタン', '', '단추', (SELECT id FROM tbl_content_kana WHERE character = 'ボ' AND script = 'kata')),

  ('パン', '', '빵', (SELECT id FROM tbl_content_kana WHERE character = 'パ' AND script = 'kata')),
  ('パジャマ', '', '잠옷', (SELECT id FROM tbl_content_kana WHERE character = 'パ' AND script = 'kata')),
  ('パーティー', '', '파티', (SELECT id FROM tbl_content_kana WHERE character = 'パ' AND script = 'kata')),

  ('ピザ', '', '피자', (SELECT id FROM tbl_content_kana WHERE character = 'ピ' AND script = 'kata')),
  ('ピアノ', '', '피아노', (SELECT id FROM tbl_content_kana WHERE character = 'ピ' AND script = 'kata')),
  ('ピクニック', '', '소풍', (SELECT id FROM tbl_content_kana WHERE character = 'ピ' AND script = 'kata')),

  ('プール', '', '수영장', (SELECT id FROM tbl_content_kana WHERE character = 'プ' AND script = 'kata')),
  ('グループ', '', '그룹', (SELECT id FROM tbl_content_kana WHERE character = 'プ' AND script = 'kata')),
  ('プレゼント', '', '선물', (SELECT id FROM tbl_content_kana WHERE character = 'プ' AND script = 'kata')),

  ('ペン', '', '펜', (SELECT id FROM tbl_content_kana WHERE character = 'ペ' AND script = 'kata')),
  ('ペット', '', '반려동물', (SELECT id FROM tbl_content_kana WHERE character = 'ペ' AND script = 'kata')),
  ('スペイン', '', '스페인', (SELECT id FROM tbl_content_kana WHERE character = 'ペ' AND script = 'kata')),

  ('ポテト', '', '감자튀김', (SELECT id FROM tbl_content_kana WHERE character = 'ポ' AND script = 'kata')),
  ('スポーツ', '', '스포츠', (SELECT id FROM tbl_content_kana WHERE character = 'ポ' AND script = 'kata')),
  ('ポスト', '', '우체통', (SELECT id FROM tbl_content_kana WHERE character = 'ポ' AND script = 'kata'))
ON CONFLICT (kana_id, surface) DO NOTHING;


-- 가나 예시 단어 추가 (KanaExample) - 가타카나 요음 (キャ~ピョ)
-- 주의: ヒャ, ミャ, ミョ, リャ, リョ, ビャ, ビョ, ピャ, ピョ 는 자연스럽게 쓰이는 외래어/단어가 사실상 없어 제외함
INSERT INTO tbl_content_kanaexample (surface, kanji, meaning_ko, kana_id) VALUES
  ('キャンプ', '', '캠핑', (SELECT id FROM tbl_content_kana WHERE character = 'キャ' AND script = 'kata')),
  ('キャベツ', '', '양배추', (SELECT id FROM tbl_content_kana WHERE character = 'キャ' AND script = 'kata')),
  ('キャラクター', '', '캐릭터', (SELECT id FROM tbl_content_kana WHERE character = 'キャ' AND script = 'kata')),

  ('バーベキュー', '', '바비큐', (SELECT id FROM tbl_content_kana WHERE character = 'キュ' AND script = 'kata')),
  ('キュート', '', '귀여운', (SELECT id FROM tbl_content_kana WHERE character = 'キュ' AND script = 'kata')),

  ('キョロキョロ', '', '두리번두리번', (SELECT id FROM tbl_content_kana WHERE character = 'キョ' AND script = 'kata')),
  ('キョウリュウ', '', '공룡', (SELECT id FROM tbl_content_kana WHERE character = 'キョ' AND script = 'kata')),

  ('シャツ', '', '셔츠', (SELECT id FROM tbl_content_kana WHERE character = 'シャ' AND script = 'kata')),
  ('シャワー', '', '샤워', (SELECT id FROM tbl_content_kana WHERE character = 'シャ' AND script = 'kata')),
  ('シャンプー', '', '샴푸', (SELECT id FROM tbl_content_kana WHERE character = 'シャ' AND script = 'kata')),

  ('シュークリーム', '', '슈크림', (SELECT id FROM tbl_content_kana WHERE character = 'シュ' AND script = 'kata')),
  ('シュート', '', '슛', (SELECT id FROM tbl_content_kana WHERE character = 'シュ' AND script = 'kata')),

  ('ショッピング', '', '쇼핑', (SELECT id FROM tbl_content_kana WHERE character = 'ショ' AND script = 'kata')),
  ('ショー', '', '쇼', (SELECT id FROM tbl_content_kana WHERE character = 'ショ' AND script = 'kata')),
  ('ショック', '', '충격', (SELECT id FROM tbl_content_kana WHERE character = 'ショ' AND script = 'kata')),

  ('チャンス', '', '기회', (SELECT id FROM tbl_content_kana WHERE character = 'チャ' AND script = 'kata')),
  ('チャンピオン', '', '챔피언', (SELECT id FROM tbl_content_kana WHERE character = 'チャ' AND script = 'kata')),
  ('チャレンジ', '', '도전', (SELECT id FROM tbl_content_kana WHERE character = 'チャ' AND script = 'kata')),

  ('チューリップ', '', '튤립', (SELECT id FROM tbl_content_kana WHERE character = 'チュ' AND script = 'kata')),
  ('チューインガム', '', '껌', (SELECT id FROM tbl_content_kana WHERE character = 'チュ' AND script = 'kata')),

  ('チョコレート', '', '초콜릿', (SELECT id FROM tbl_content_kana WHERE character = 'チョ' AND script = 'kata')),
  ('チョーク', '', '분필', (SELECT id FROM tbl_content_kana WHERE character = 'チョ' AND script = 'kata')),
  ('チョッキ', '', '조끼', (SELECT id FROM tbl_content_kana WHERE character = 'チョ' AND script = 'kata')),

  ('コンニャク', '', '곤약', (SELECT id FROM tbl_content_kana WHERE character = 'ニャ' AND script = 'kata')),
  ('ニャー', '', '야옹', (SELECT id FROM tbl_content_kana WHERE character = 'ニャ' AND script = 'kata')),

  ('ニュース', '', '뉴스', (SELECT id FROM tbl_content_kana WHERE character = 'ニュ' AND script = 'kata')),
  ('メニュー', '', '메뉴', (SELECT id FROM tbl_content_kana WHERE character = 'ニュ' AND script = 'kata')),
  ('マニュアル', '', '매뉴얼', (SELECT id FROM tbl_content_kana WHERE character = 'ニュ' AND script = 'kata')),

  ('ニョッキ', '', '뇨끼', (SELECT id FROM tbl_content_kana WHERE character = 'ニョ' AND script = 'kata')),
  ('ニョロニョロ', '', '꿈틀꿈틀', (SELECT id FROM tbl_content_kana WHERE character = 'ニョ' AND script = 'kata')),

  ('ヒューマン', '', '휴먼', (SELECT id FROM tbl_content_kana WHERE character = 'ヒュ' AND script = 'kata')),
  ('ヒューズ', '', '퓨즈', (SELECT id FROM tbl_content_kana WHERE character = 'ヒュ' AND script = 'kata')),

  ('ヒョウ', '', '표범', (SELECT id FROM tbl_content_kana WHERE character = 'ヒョ' AND script = 'kata')),
  ('ヒョロヒョロ', '', '비실비실', (SELECT id FROM tbl_content_kana WHERE character = 'ヒョ' AND script = 'kata')),

  ('ミュージアム', '', '박물관', (SELECT id FROM tbl_content_kana WHERE character = 'ミュ' AND script = 'kata')),
  ('ミュージック', '', '음악', (SELECT id FROM tbl_content_kana WHERE character = 'ミュ' AND script = 'kata')),
  ('コミュニケーション', '', '커뮤니케이션', (SELECT id FROM tbl_content_kana WHERE character = 'ミュ' AND script = 'kata')),

  ('リュック', '', '배낭', (SELECT id FROM tbl_content_kana WHERE character = 'リュ' AND script = 'kata')),
  ('リュックサック', '', '배낭', (SELECT id FROM tbl_content_kana WHERE character = 'リュ' AND script = 'kata')),

  ('ギャグ', '', '개그', (SELECT id FROM tbl_content_kana WHERE character = 'ギャ' AND script = 'kata')),
  ('ギャラリー', '', '갤러리', (SELECT id FROM tbl_content_kana WHERE character = 'ギャ' AND script = 'kata')),
  ('ギャップ', '', '차이', (SELECT id FROM tbl_content_kana WHERE character = 'ギャ' AND script = 'kata')),

  ('レギュラー', '', '레귤러', (SELECT id FROM tbl_content_kana WHERE character = 'ギュ' AND script = 'kata')),
  ('ギュッと', '', '꽉', (SELECT id FROM tbl_content_kana WHERE character = 'ギュ' AND script = 'kata')),

  ('ギョーザ', '', '교자', (SELECT id FROM tbl_content_kana WHERE character = 'ギョ' AND script = 'kata')),
  ('キンギョ', '', '금붕어', (SELECT id FROM tbl_content_kana WHERE character = 'ギョ' AND script = 'kata')),

  ('ジャム', '', '잼', (SELECT id FROM tbl_content_kana WHERE character = 'ジャ' AND script = 'kata')),
  ('ジャケット', '', '재킷', (SELECT id FROM tbl_content_kana WHERE character = 'ジャ' AND script = 'kata')),
  ('ジャングル', '', '정글', (SELECT id FROM tbl_content_kana WHERE character = 'ジャ' AND script = 'kata')),

  ('ジュース', '', '주스', (SELECT id FROM tbl_content_kana WHERE character = 'ジュ' AND script = 'kata')),
  ('ジュエリー', '', '주얼리', (SELECT id FROM tbl_content_kana WHERE character = 'ジュ' AND script = 'kata')),

  ('ジョギング', '', '조깅', (SELECT id FROM tbl_content_kana WHERE character = 'ジョ' AND script = 'kata')),
  ('ジョーク', '', '농담', (SELECT id FROM tbl_content_kana WHERE character = 'ジョ' AND script = 'kata')),

  ('インタビュー', '', '인터뷰', (SELECT id FROM tbl_content_kana WHERE character = 'ビュ' AND script = 'kata')),
  ('デビュー', '', '데뷔', (SELECT id FROM tbl_content_kana WHERE character = 'ビュ' AND script = 'kata')),

  ('コンピューター', '', '컴퓨터', (SELECT id FROM tbl_content_kana WHERE character = 'ピュ' AND script = 'kata')),
  ('ピュア', '', '순수한', (SELECT id FROM tbl_content_kana WHERE character = 'ピュ' AND script = 'kata'))
ON CONFLICT (kana_id, surface) DO NOTHING;
