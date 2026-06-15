import csv
import kagglehub
import psycopg2
from psycopg2.extras import execute_values

PG_HOST = "localhost"
PG_PORT = "5432"
PG_DBNAME = "kanjify"
PG_USER = "root"
PG_PASSWORD = "1234"

pg_conn = None
pg_cursor = None

print("🔄 JLPT 레벨 데이터 다운로드 중...")
try:
    dataset_path = kagglehub.dataset_download("robinpourtaud/jlpt-words-by-level")
    csv_path = dataset_path + "/jlpt_vocab.csv"

    jlpt_map = {}
    with open(csv_path, encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            word = row["Original"].strip()
            level = row["JLPT Level"].strip()
            if word and level:
                jlpt_map[word] = level

    print(f"✅ JLPT 단어장 로드 완료: {len(jlpt_map)}개 단어")

    pg_conn = psycopg2.connect(
        host=PG_HOST,
        port=PG_PORT,
        database=PG_DBNAME,
        user=PG_USER,
        password=PG_PASSWORD
    )
    pg_cursor = pg_conn.cursor()

    update_data = [(word, level) for word, level in jlpt_map.items()]
    execute_values(
        pg_cursor,
        """
        UPDATE tbl_vocabulary SET level = v.level
        FROM (VALUES %s) AS v(word, level)
        WHERE tbl_vocabulary.word = v.word
        """,
        update_data
    )

    pg_conn.commit()
    print("✅ tbl_vocabulary JLPT 레벨 업데이트 완료")

except Exception as e:
    print(f"❌ JLPT 레벨 업데이트 실패: {e}")
    if pg_conn:
        pg_conn.rollback()

finally:
    if pg_cursor: pg_cursor.close()
    if pg_conn: pg_conn.close()
