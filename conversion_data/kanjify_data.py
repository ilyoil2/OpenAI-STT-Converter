import sqlite3
import psycopg2
from psycopg2.extras import execute_values

# ==========================================
# 1. 설정 정보 (본인의 정보에 맞게 수정하세요)
# ==========================================
ANKI_DB_PATH = "./collection_extracted.anki21"  # zstd 압축 해제된 SQLite 파일

PG_HOST = "localhost"
PG_PORT = "5432"
PG_DBNAME = "your_database_name"
PG_USER = "your_username"
PG_PASSWORD = "your_password"

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
    
    parsed_data = []
    for row in rows:
        flds, tags = row[0], row[1]

        fields = flds.split('\x1f')

        # 12개 필드 전부 삽입, 부족한 경우 빈 문자열로 채움
        def f(i): return fields[i].strip() if i < len(fields) else ""

        parsed_data.append((
            f(0),   # kanji              — 한자 (예: 一, 右)
            f(1),   # korean_reading_detail — 한국어 음훈 상세 (예: 한 일, 오른쪽 우/도울 우)
            f(2),   # korean_reading     — 한국어 훈 단순 (예: 하나 일, 오른 우)
            f(3),   # radical_desc_ko    — 부수 설명 한국어 (예: 一 (한일, 1획))
            f(4),   # etymology          — 자원 설명, 한자가 만들어진 구성 원리
            f(5),   # stroke_count_ko    — 획수 한국어 (예: 1획, 5획)
            f(6),   # radical_ja         — 부수 일본어 (예: 一部（いち）)
            f(7),   # stroke_count_ja    — 획수 일본어 (예: １画(かく))
            f(8),   # onyomi             — 음독: 한자의 중국식 발음 유래 읽기 (예: イチ・イツ)
            f(9),   # kunyomi            — 훈독: 한자의 일본 고유어 읽기 (예: ひと・ひとつ)
            f(10),  # meaning_ja         — 일본어 의미 설명 (HTML 포함)
            f(11),  # level              — 한자검정 급수 (예: １０級(きゅう))
        ))
            
    sqlite_conn.close()
    print(f"✅ Anki에서 {len(parsed_data)}개의 단어를 성공적으로 추출했습니다.")

except Exception as e:
    print(f"❌ Anki 파일 읽기 실패: {e}")
    exit()

# ==========================================
# 3. PostgreSQL에 테이블 생성 및 데이터 삽입
# ==========================================
if not parsed_data:
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
    
    create_table_query = """
    CREATE TABLE IF NOT EXISTS tbl_vocabulary (
        id SERIAL PRIMARY KEY,
        kanji TEXT,
        korean_reading_detail TEXT,
        korean_reading TEXT,
        radical_desc_ko TEXT,
        etymology TEXT,
        stroke_count_ko TEXT,
        radical_ja TEXT,
        stroke_count_ja TEXT,
        onyomi TEXT,
        kunyomi TEXT,
        meaning_ja TEXT,
        level TEXT
    );
    """
    pg_cursor.execute(create_table_query)

    insert_query = """
    INSERT INTO tbl_vocabulary (
        kanji, korean_reading_detail, korean_reading, radical_desc_ko,
        etymology, stroke_count_ko, radical_ja, stroke_count_ja,
        onyomi, kunyomi, meaning_ja, level
    ) VALUES %s;
    """
    
    execute_values(pg_cursor, insert_query, parsed_data)
    
    pg_conn.commit()
    print("🎉 PostgreSQL로 데이터 이관이 완전히 끝났습니다!")

except Exception as e:
    print(f"❌ PostgreSQL 작업 실패: {e}")
    if pg_conn:
        pg_conn.rollback()

finally:
    if pg_cursor: pg_cursor.close()
    if pg_conn: pg_conn.close()