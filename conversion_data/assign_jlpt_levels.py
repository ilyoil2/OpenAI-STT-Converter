import psycopg2
import google.generativeai as genai
import json
import time
import os
from dotenv import load_dotenv

# .env 파일 로드
load_dotenv()

# ==========================================
# 1. 설정
# ==========================================
PG_HOST = "localhost"
PG_PORT = "5432"
PG_DBNAME = "kanjify"
PG_USER = "root"
PG_PASSWORD = "1234"

# Gemini API 키 설정 (환경변수에서 읽기)
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
if not GEMINI_API_KEY:
    print("GEMINI_API_KEY 환경변수를 설정해주세요.")
    print("   export GEMINI_API_KEY='your-api-key'")
    exit()

genai.configure(api_key=GEMINI_API_KEY)
model = genai.GenerativeModel('gemini-2.5-flash')

BATCH_SIZE = 100  # 한 번에 처리할 단어 수

# ==========================================
# 2. PostgreSQL에서 level이 빈 단어 가져오기
# ==========================================
print("PostgreSQL에서 단어 데이터 가져오는 중...")
try:
    pg_conn = psycopg2.connect(
        host=PG_HOST,
        port=PG_PORT,
        database=PG_DBNAME,
        user=PG_USER,
        password=PG_PASSWORD
    )
    pg_cursor = pg_conn.cursor()

    # tbl_vocabulary에서 level이 빈 것만 가져오기
    pg_cursor.execute("""
        SELECT id, word, meaning_ja
        FROM tbl_vocabulary
        WHERE level IS NULL OR level = ''
        ORDER BY id
    """)

    vocab_data = pg_cursor.fetchall()
    print(f"총 {len(vocab_data)}개의 단어를 가져왔습니다.")

except Exception as e:
    print(f"PostgreSQL 연결 실패: {e}")
    exit()

# ==========================================
# 3. Gemini API로 JLPT 레벨 추정
# ==========================================
def estimate_jlpt_levels(batch):
    """Gemini API를 사용해 단어 배치의 JLPT 레벨 추정"""

    # 프롬프트 구성
    words_json = json.dumps([
        {"word": word, "meaning_ja": meaning_ja[:100]}  # 의미는 100자만
        for _, word, meaning_ja in batch
    ], ensure_ascii=False, indent=2)

    prompt = f"""다음 일본어 단어들의 JLPT 레벨(N5/N4/N3/N2/N1)을 추정해주세요.

기준:
- N5: 기초 단어 (예: 会う, 青い, 赤い)
- N4: 초급 단어 (예: 明るい, 開ける)
- N3: 중급 단어 (예: 生まれる, 美味しい)
- N2: 중상급 단어 (예: 受付, コミュニケーション)
- N1: 고급 단어 (예: デモンストレーション, 文法 표현)


두 레벨 사이에서 고민된다면 더 높은 레벨을 선택하세요.
예: N3와 N2 사이라면 → N2, N4와 N3 사이라면 → N3
응답은 반드시 다음 JSON 형식으로만 작성하세요:
[
  {{"word": "会う", "level": "N5"}},
  {{"word": "青い", "level": "N5"}}
]

단어 목록:
{words_json}

JSON만 응답하세요. 설명이나 다른 텍스트는 포함하지 마세요."""

    try:
        response = model.generate_content(prompt)
        response_text = response.text.strip()

        # JSON 추출 (```json ``` 제거)
        if "```json" in response_text:
            response_text = response_text.split("```json")[1].split("```")[0].strip()
        elif "```" in response_text:
            response_text = response_text.split("```")[1].split("```")[0].strip()

        results = json.loads(response_text)
        return results

    except json.JSONDecodeError as e:
        print(f"JSON 파싱 실패: {e}")
        print(f"   응답 전체: {response_text}")
        return None
    except Exception as e:
        print(f"API 호출 실패: {e}")
        return None

# ==========================================
# 4. 배치 처리 및 DB 업데이트
# ==========================================
print(f"\nGemini API로 JLPT 레벨 추정 시작 (배치 크기: {BATCH_SIZE})")

total_processed = 0
total_updated = 0

for i in range(0, len(vocab_data), BATCH_SIZE):
    batch = vocab_data[i:i+BATCH_SIZE]
    batch_num = (i // BATCH_SIZE) + 1
    total_batches = (len(vocab_data) + BATCH_SIZE - 1) // BATCH_SIZE

    print(f"\n배치 {batch_num}/{total_batches} 처리 중... ({len(batch)}개 단어)")

    # Gemini API 호출
    results = estimate_jlpt_levels(batch)

    if results:
        # DB 업데이트
        try:
            for item in results:
                word = item.get("word")
                level = item.get("level")

                if word and level:
                    # 해당 word의 id 찾기
                    matching = [row for row in batch if row[1] == word]
                    if matching:
                        record_id = matching[0][0]
                        pg_cursor.execute(
                            "UPDATE tbl_vocabulary SET level = %s WHERE id = %s",
                            (level, record_id)
                        )
                        total_updated += 1

            pg_conn.commit()
            print(f"{len(results)}개 업데이트 완료")

        except Exception as e:
            print(f"DB 업데이트 실패: {e}")
            pg_conn.rollback()

    total_processed += len(batch)

    # API 속도 제한 고려 (1초 대기)
    if i + BATCH_SIZE < len(vocab_data):
        time.sleep(1)

# ==========================================
# 5. 완료
# ==========================================
print(f"\n처리 완료!")
print(f"   - 총 처리: {total_processed}개")
print(f"   - 업데이트: {total_updated}개")

pg_cursor.close()
pg_conn.close()
