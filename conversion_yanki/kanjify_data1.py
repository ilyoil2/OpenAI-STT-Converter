import re
import unicodedata
import html as _html

_JLPT_NORMAL = {10: "N5", 9: "N5", 8: "N4", 7: "N4",
                6: "N3", 5: "N3", 4: "N2", 3: "N2", 2: "N1", 1: "N1"}
_JLPT_JUN = {2: "N2", 1: "N1"}


def extract_stroke_count(raw):
    if not raw:
        return None
    m = re.search(r"(\d+)", unicodedata.normalize("NFKC", raw))
    return int(m.group(1)) if m else None


def kanji_jlpt_level(raw):
    if not raw:
        return None
    s = unicodedata.normalize("NFKC", raw)
    has_jun = "準" in s
    m = re.search(r"(\d+)\s*級", s)
    if not m:
        return None
    n = int(m.group(1))
    return _JLPT_JUN.get(n) if has_jun else _JLPT_NORMAL.get(n)


def strip_html(raw):
    if not raw:
        return ""
    s = re.sub(r"<br\s*/?>", "\n", raw, flags=re.IGNORECASE)
    s = re.sub(r"<[^>]+>", "", s)
    return _html.unescape(s)


def nz(x, maxlen=None):
    s = (x or "").strip()
    return s[:maxlen] if maxlen else s


def extract_part_speech(html):
    # field 5(예문 HTML)의 <em class='part_speech'>...</em> 안 텍스트를
    # 그대로(한국어 그대로) 추출. 여러 개면 첫 번째. 없으면 ''.
    if not html:
        return ""
    m = re.search(r"<em[^>]*class=['\"]part_speech['\"][^>]*>(.*?)</em>",
                  html, re.S)
    if not m:
        return ""
    return strip_html(m.group(1)).strip()[:50]


def split_meanings(raw):
    text = strip_html(raw).strip()
    if not text:
        return []
    parts = re.split(r"\s*\d+\.\s*", text)
    return [p.strip() for p in parts if p.strip()]


def word_type_and_reading(ruby, kanji_field):
    ruby = (ruby or "").strip()
    if ruby:
        return "kanji", ruby[:100]
    return "kana", (kanji_field or "").strip()[:100]


def parse_fields(flds):
    return flds.split("\x1f")


def _f(fields, i):
    return fields[i] if i < len(fields) else ""


def build_kanji_row(fields):
    return (
        nz(_f(fields, 0), 10),                  # character
        nz(_f(fields, 2)),                      # meaning_ko (훈음 일상무따)
        nz(_f(fields, 4)),                      # components (모양자)
        extract_stroke_count(_f(fields, 5)),    # stroke_count
        nz(_f(fields, 8), 100),                 # on_reading (음독)
        nz(_f(fields, 9), 100),                 # kun_reading (훈독)
        strip_html(_f(fields, 10)).strip(),     # meaning_ja (의미, <br> 정리)
        kanji_jlpt_level(_f(fields, 11)),       # jlpt_level (한자검정)
        nz(_f(fields, 1)),                      # meaning_ko_detail (훈음)
    )


def build_word(fields):
    raw_surface = _f(fields, 0)
    if re.search(r"<[^>]+>", raw_surface):
        # 센티널/템플릿 노트 (surface가 거대한 HTML 문자열) 걸러내기
        return None
    word_type, reading = word_type_and_reading(_f(fields, 1), _f(fields, 2))
    head = (
        nz(raw_surface, 100),                   # surface (단어)
        word_type,                              # word_type
        reading,                                # reading
        extract_part_speech(_f(fields, 5)),     # pos (part_speech 원문)
        None,                                   # jlpt_level (항상 NULL)
    )
    meanings = split_meanings(_f(fields, 4))    # 의미
    return head, meanings


import os
import sqlite3
import argparse
import psycopg2
from psycopg2.extras import execute_values

ANKI_DB_PATH = os.getenv("ANKI_DB_PATH", "./collection_extracted.anki21")
KANJI_MIDS = (1730037663052, 1730045851294)
WORD_MID = 1728981502167


def pg_connect():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "aws-1-ap-northeast-2.pooler.supabase.com"),
        port=os.getenv("DB_PORT", "6543"),
        dbname=os.getenv("DB_NAME", "postgres"),
        user=os.getenv("DB_USER", "postgres.vqztavgyegwuupmsgpnj"),
        password=os.getenv("DB_PASSWORD", "japavocapass1"),
    )


def read_anki():
    conn = sqlite3.connect(ANKI_DB_PATH)
    cur = conn.cursor()
    kanji_rows, word_units = [], []
    cur.execute("SELECT mid, flds FROM notes")
    for mid, flds in cur.fetchall():
        fields = parse_fields(flds)
        try:
            if mid in KANJI_MIDS:
                row = build_kanji_row(fields)
                if row[0]:  # character 필수
                    kanji_rows.append(row)
            elif mid == WORD_MID:
                built = build_word(fields)
                if built is None:  # 센티널/템플릿 노트 (HTML surface) 스킵
                    continue
                head, meanings = built
                if head[0]:  # surface 필수
                    word_units.append((head, meanings))
        except Exception as e:  # 단건 실패는 스킵
            print(f"⚠️ 파싱 스킵 (mid={mid}): {e}")
    conn.close()
    return kanji_rows, word_units


def insert_kanji(cur, kanji_rows):
    execute_values(
        cur,
        """
        INSERT INTO tbl_content_kanji
          (character, meaning_ko, components, stroke_count, on_reading,
           kun_reading, meaning_ja, jlpt_level, meaning_ko_detail, created_at)
        VALUES %s
        ON CONFLICT (character) DO NOTHING
        """,
        kanji_rows,
        template="(%s,%s,%s,%s,%s,%s,%s,%s,%s, now())",
    )


def insert_words(cur, word_units):
    heads = [u[0] for u in word_units]
    # NOTE: this INSERT has no ON CONFLICT clause, so PostgreSQL guarantees
    # RETURNING id comes back in the same order as the VALUES list. That is
    # what makes the positional zip(word_ids, word_units) below correct —
    # if ON CONFLICT is ever added to this word insert, rows can be skipped
    # and the ids/word_units pairing will silently misalign.
    rows = execute_values(
        cur,
        """
        INSERT INTO tbl_content_word
          (surface, word_type, reading, pos, jlpt_level, created_at)
        VALUES %s
        RETURNING id
        """,
        heads,
        template="(%s,%s,%s,%s,%s, now())",
        fetch=True,
    )
    word_ids = [r[0] for r in rows]
    meaning_rows = []
    for word_id, (_, meanings) in zip(word_ids, word_units):
        for i, mk in enumerate(meanings, start=1):
            meaning_rows.append((word_id, i, mk, ""))
    if meaning_rows:
        execute_values(
            cur,
            """
            INSERT INTO tbl_content_wordmeaning
              (word_id, sense_no, meaning_ko, note, created_at)
            VALUES %s
            ON CONFLICT (word_id, sense_no) DO NOTHING
            """,
            meaning_rows,
            template="(%s,%s,%s,%s, now())",
        )
    return len(meaning_rows)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    print("🔄 Anki 읽는 중...")
    kanji_rows, word_units = read_anki()
    print(f"   한자 {len(kanji_rows)}건 / 단어 {len(word_units)}건")

    if args.dry_run:
        print("\n[DRY-RUN] 한자 샘플 3건:")
        for r in kanji_rows[:3]:
            print("  ", r)
        print("[DRY-RUN] 단어 샘플 3건:")
        for u in word_units[:3]:
            print("  ", u)
        return

    conn = pg_connect()
    cur = conn.cursor()
    try:
        insert_kanji(cur, kanji_rows)
        n_meanings = insert_words(cur, word_units)
        conn.commit()
        print(f"✅ 한자 {len(kanji_rows)} / 단어 {len(word_units)} / 뜻 {n_meanings} 적재 완료")
    except Exception:
        conn.rollback()
        raise
    finally:
        cur.close()
        conn.close()


if __name__ == "__main__":
    main()
