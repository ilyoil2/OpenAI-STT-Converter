#!/usr/bin/env python3
"""
N1~N5 anki 파일로 JapaVoca DB의 jlpt_level 업데이트.

Usage:
    # 특정 레벨만
    python set_jlpt_level.py word-level-data/n1-vocab-kanji-hiragana.anki N1 [--dry-run]

    # N1~N5 전체 일괄 처리
    python set_jlpt_level.py --all [--dry-run]
"""
import sys
import os
import re
import sqlite3
import psycopg2

DB_CONFIG = {
    "dbname": "postgres",
    "user": "postgres.vqztavgyegwuupmsgpnj",
    "password": "japavocapass1",
    "host": "aws-1-ap-northeast-2.pooler.supabase.com",
    "port": 6543,
}

WORD_LEVEL_DIR = os.path.join(os.path.dirname(__file__), "word-level-data")

ALL_FILES = {
    "N1": "n1-vocab-kanji-hiragana.anki",
    "N2": "n2-vocab-kanji-hiragana.anki",
    "N3": "n3-vocab-kanji-hiragana.anki",
    "N4": "n4-vocab-kanji-hiragana.anki",
    "N5": "n5-vocab-kanji-hiragana.anki",
}


def load_anki_words(anki_path: str) -> set[str]:
    conn = sqlite3.connect(anki_path)
    cur = conn.cursor()
    rows = cur.execute("SELECT value FROM fields WHERE ordinal = 0").fetchall()
    conn.close()
    return {row[0].strip() for row in rows if row[0].strip()}


def _variant_forms(text: str) -> set[str]:
    # 하나의 표기 문자열에서 매칭 후보를 만든다.
    # DB reading은 여러 한자표기를 ·/・ 로 묶어두는 경우가 있고(예:
    # '良い·善い·好い'), 파일은 그중 하나만 담고 있어 완전일치가 깨진다.
    # /(슬래시)로 대체표기를 나열하는 경우도 함께 분해한다.
    if not text:
        return set()
    return {p.strip() for p in re.split(r"[·・/]", text) if p.strip()}


def update_jlpt_level(level: str, words: set[str], dry_run: bool = False) -> None:
    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    cur.execute("SELECT id, surface, reading FROM tbl_content_word")
    all_words = cur.fetchall()

    # DB 단어별로 매칭 후보(surface + reading의 ·/・// 분해 형태)를 만들어
    # 파일 단어 집합과 교집합이 있으면 매칭으로 본다. surface 완전일치뿐 아니라
    # 가나 surface ↔ 한자 reading, 여러 표기 중 하나만 일치하는 경우까지 잡는다.
    matched_ids = []
    matched_words: set[str] = set()
    for wid, surface, reading in all_words:
        forms = _variant_forms(surface) | _variant_forms(reading)
        if surface:
            forms.add(surface.strip())
        hits = forms & words
        if hits:
            matched_ids.append(wid)
            matched_words |= hits
    unmatched = words - matched_words

    print(f"  파일 단어 수:      {len(words)}")
    print(f"  매칭된 단어 수:    {len(matched_ids)}")
    print(f"  매칭 안 된 단어:   {len(unmatched)}")

    if dry_run:
        print("  [dry-run] 업데이트 건너뜀.")
        conn.close()
        return

    if not matched_ids:
        print("  업데이트할 항목 없음.")
        conn.close()
        return

    cur.execute(
        "UPDATE tbl_content_word SET jlpt_level = %s WHERE id = ANY(%s)",
        (level, matched_ids),
    )
    conn.commit()
    print(f"  → {cur.rowcount}개 레코드 업데이트 완료.")
    conn.close()


def run_level(level: str, anki_path: str, dry_run: bool) -> None:
    print(f"\n[{level}] {os.path.basename(anki_path)}")
    if not os.path.exists(anki_path):
        print(f"  파일 없음: {anki_path}")
        return
    words = load_anki_words(anki_path)
    update_jlpt_level(level, words, dry_run=dry_run)


def main():
    dry_run = "--dry-run" in sys.argv
    args = [a for a in sys.argv[1:] if a != "--dry-run"]

    if args and args[0] == "--all":
        print("N1~N5 전체 처리" + (" (dry-run)" if dry_run else ""))
        for level, filename in ALL_FILES.items():
            run_level(level, os.path.join(WORD_LEVEL_DIR, filename), dry_run)
        print("\n완료.")
    elif len(args) >= 2:
        anki_path, level = args[0], args[1].upper()
        if level not in ALL_FILES:
            print(f"잘못된 레벨: {level}. N1~N5 중 하나여야 함.")
            sys.exit(1)
        run_level(level, anki_path, dry_run)
    else:
        print("Usage:")
        print("  python set_jlpt_level.py --all [--dry-run]")
        print("  python set_jlpt_level.py <anki_file> <level> [--dry-run]")
        sys.exit(1)


if __name__ == "__main__":
    main()
