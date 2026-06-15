import sqlite3
import psycopg2
from psycopg2.extras import execute_values

# ==========================================
# 1. 설정 정보 (본인의 정보에 맞게 수정하세요)
# ==========================================
ANKI_DB_PATH = "./collection_extracted.anki21"  # zstd 압축 해제된 SQLite 파일

PG_HOST = "localhost"
PG_PORT = "5432"
PG_DBNAME = "kanjify"
PG_USER = "root"
PG_PASSWORD = "1234"


# ==========================================
# 2. SQLite (Anki)에서 데이터 읽어오기
# ==========================================
print("🔄 Anki SQLite 데이터베이스 읽는 중...")
try:
    sqlite_conn = sqlite3.connect(ANKI_DB_PATH)
    cursor = sqlite_conn.cursor()
    
    # notes 테이블에서 flds(단어묶음)와 tags(레벨 등)를 가져옵니다.
    cursor.execute("SELECT flds, tags FROM notes")
    rows = cursor.fetchall()
    
    kanji_data = []       # 개별 한자 (음독/훈독 있음)
    vocabulary_data = []  # 단어 (음독/훈독 없음)

    for row in rows:
        flds, tags = row[0], row[1]

        fields = flds.split('\x1f')

        # 12개 필드 전부 추출, 부족한 경우 빈 문자열로 채움
        def f(i): return fields[i].strip() if i < len(fields) else ""

        kanji_record = (
            f(0),   # kanji
            f(1),   # korean_reading_detail
            f(4),   # etymology
            f(5),   # stroke_count_ko
            f(6),   # radical_ja
            f(8),   # onyomi
            f(9),   # kunyomi
            f(10),  # meaning_ja
            f(11),  # level
        )

        vocabulary_record = (
            f(0),   # word
            f(1),   # korean_reading_detail
            f(2),   # korean_reading
            f(4),   # etymology
            f(5),   # stroke_count_ko
            f(7),   # stroke_count_ja
            f(8),   # onyomi
            f(9),   # kunyomi
            f(10),  # meaning_ja
            f(11),  # level
        )

        # 음독 또는 훈독이 있으면 개별 한자, 없으면 단어
        onyomi = f(8)
        kunyomi = f(9)

        if onyomi or kunyomi:
            kanji_data.append(kanji_record)
        else:
            vocabulary_data.append(vocabulary_record)

    sqlite_conn.close()
    print(f"✅ Anki에서 총 {len(rows)}개 추출 완료")
    print(f"   - 개별 한자: {len(kanji_data)}개 → tbl_kanji")
    print(f"   - 단어: {len(vocabulary_data)}개 → tbl_vocabulary")

except Exception as e:
    print(f"❌ Anki 파일 읽기 실패: {e}")
    exit()

# ==========================================
# 3. PostgreSQL에 테이블 생성 및 데이터 삽입
# ==========================================
if not kanji_data and not vocabulary_data:
    print("⚠️ 추출된 데이터가 없어 PostgreSQL 이관을 중단합니다.")
    exit()

print("🔄 PostgreSQL 연결 및 데이터 삽입 중...")
try:
    pg_conn = psycopg2.connect(
        host=PG_HOST,
        port=PG_PORT,
        database=PG_DBNAME,
        user=PG_USER,
        password=PG_PASSWORD
    )
    pg_cursor = pg_conn.cursor()

    # 3-1. tbl_kanji 테이블 생성
    create_kanji_table = """
    CREATE TABLE IF NOT EXISTS tbl_kanji (
        id SERIAL PRIMARY KEY,
        kanji TEXT,
        korean_reading_detail TEXT,
        etymology TEXT,
        stroke_count_ko TEXT,
        radical_ja TEXT,
        onyomi TEXT,
        kunyomi TEXT,
        meaning_ja TEXT,
        level TEXT
    );
    """
    pg_cursor.execute(create_kanji_table)

    # 3-2. tbl_vocabulary 테이블 생성
    create_vocabulary_table = """
    CREATE TABLE IF NOT EXISTS tbl_vocabulary (
        id SERIAL PRIMARY KEY,
        word TEXT,
        korean_reading_detail TEXT,
        korean_reading TEXT,
        etymology TEXT,
        stroke_count_ko TEXT,
        stroke_count_ja TEXT,
        onyomi TEXT,
        kunyomi TEXT,
        meaning_ja TEXT,
        level TEXT
    );
    """
    pg_cursor.execute(create_vocabulary_table)

    # 3-3. 개별 한자 데이터 삽입
    if kanji_data:
        insert_kanji_query = """
        INSERT INTO tbl_kanji (
            kanji, korean_reading_detail,
            etymology, stroke_count_ko, radical_ja,
            onyomi, kunyomi, meaning_ja, level
        ) VALUES %s;
        """
        execute_values(pg_cursor, insert_kanji_query, kanji_data)
        print(f"✅ tbl_kanji에 {len(kanji_data)}개 삽입 완료")

    # 3-4. 단어 데이터 삽입
    if vocabulary_data:
        insert_vocabulary_query = """
        INSERT INTO tbl_vocabulary (
            word, korean_reading_detail, korean_reading,
            etymology, stroke_count_ko, stroke_count_ja,
            onyomi, kunyomi, meaning_ja, level
        ) VALUES %s;
        """
        execute_values(pg_cursor, insert_vocabulary_query, vocabulary_data)
        print(f"✅ tbl_vocabulary에 {len(vocabulary_data)}개 삽입 완료")

    pg_conn.commit()
    print("🎉 PostgreSQL로 데이터 이관이 완전히 끝났습니다!")

except Exception as e:
    print(f"❌ PostgreSQL 작업 실패: {e}")
    if pg_conn:
        pg_conn.rollback()

finally:
    if pg_cursor: pg_cursor.close()
    if pg_conn: pg_conn.close()