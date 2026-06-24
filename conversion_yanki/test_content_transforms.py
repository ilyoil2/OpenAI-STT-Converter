from kanjify_data import extract_stroke_count, kanji_jlpt_level


def test_extract_stroke_count_basic():
    assert extract_stroke_count("1획") == 1
    assert extract_stroke_count("16획") == 16

def test_extract_stroke_count_empty():
    assert extract_stroke_count("") is None
    assert extract_stroke_count(None) is None
    assert extract_stroke_count("획수없음") is None

def test_kanji_jlpt_level_normal():
    assert kanji_jlpt_level("１０級(きゅう)") == "N5"
    assert kanji_jlpt_level("９級(きゅう)") == "N5"
    assert kanji_jlpt_level("８級") == "N4"
    assert kanji_jlpt_level("５級") == "N3"
    assert kanji_jlpt_level("３級") == "N2"
    assert kanji_jlpt_level("２級") == "N1"

def test_kanji_jlpt_level_jun():
    assert kanji_jlpt_level("準(じゅん)２級(きゅう)") == "N2"
    assert kanji_jlpt_level("準１級") == "N1"

def test_kanji_jlpt_level_unmapped():
    assert kanji_jlpt_level("") is None
    assert kanji_jlpt_level(None) is None
    assert kanji_jlpt_level("급외") is None


from kanjify_data import strip_html, extract_part_speech, nz


def test_strip_html_br():
    assert strip_html("가<br>나<br/>다") == "가\n나\n다"

def test_strip_html_tags_and_entity():
    assert strip_html("<em>명사</em>&amp;") == "명사&"

def test_strip_html_empty():
    assert strip_html("") == ""
    assert strip_html(None) == ""

def test_extract_part_speech_basic():
    html = "<div class='part_area'><em class='part_speech'>5단활용 자동사</em></div>"
    assert extract_part_speech(html) == "5단활용 자동사"

def test_extract_part_speech_korean_verbatim():
    html = "<em class='part_speech'>명사, ス타동사</em>"
    assert extract_part_speech(html) == "명사, ス타동사"

def test_extract_part_speech_first_when_multiple():
    html = ("<em class='part_speech'>5단활용 자동사</em>"
            "<em class='part_speech'>4단활용 자동사</em>")
    assert extract_part_speech(html) == "5단활용 자동사"

def test_extract_part_speech_empty():
    assert extract_part_speech("") == ""
    assert extract_part_speech(None) == ""
    assert extract_part_speech("<div class='mean_tray'>뜻</div>") == ""

def test_nz():
    assert nz(None) == ""
    assert nz("  x  ") == "x"
    assert nz("abcdef", 3) == "abc"


from kanjify_data import split_meanings, word_type_and_reading


def test_split_meanings_numbered():
    assert split_meanings("1. 머리 2. 두부 3. 두발") == ["머리", "두부", "두발"]

def test_split_meanings_single():
    assert split_meanings("정기휴일") == ["정기휴일"]

def test_split_meanings_empty():
    assert split_meanings("") == []
    assert split_meanings(None) == []

def test_word_type_kanji():
    assert word_type_and_reading("あう", "") == ("kanji", "あう")

def test_word_type_kana():
    assert word_type_and_reading("", "私") == ("kana", "私")
    assert word_type_and_reading("", "") == ("kana", "")


from kanjify_data import parse_fields, build_kanji_row, build_word

KANJI_FLDS = "\x1f".join([
    "一", "한 일", "하나 일", "一부", "一(한 일)", "1획",
    "일본부수", "1画", "イチ・イツ", "ひと", "뜻1<br>뜻2", "１０級(きゅう)",
])
WORD_FLDS = "\x1f".join([
    "会う", "あう", "", "동사", "1. 만나다 2. 대면하다",
    "<div class='part_area'><em class='part_speech'>5단활용 자동사</em></div>", "1",
])


def test_parse_fields():
    assert parse_fields("a\x1fb\x1fc") == ["a", "b", "c"]

def test_build_kanji_row():
    row = build_kanji_row(parse_fields(KANJI_FLDS))
    assert row == ("一", "하나 일", "一(한 일)", 1,
                   "イチ・イツ", "ひと", "뜻1\n뜻2", "N5", "한 일")

def test_build_word():
    head, meanings = build_word(parse_fields(WORD_FLDS))
    assert head == ("会う", "kanji", "あう", "5단활용 자동사", None)
    assert meanings == ["만나다", "대면하다"]

def test_build_word_rejects_html_surface():
    assert build_word(parse_fields("덱 삭제<br><div>x</div>\x1f\x1f\x1f\x1f\x1f\x1f")) is None
