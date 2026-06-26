# POS 정규화 작업 지시서

## 목적

`conversion_yanki/kanjify_data1.py`의 `extract_part_speech()` 함수가
Anki 데이터의 품사(pos)를 정규화 없이 그대로 추출하고 있어,
같은 품사가 다른 표기로 DB에 혼재됨. 이를 코드 수준에서 정규화한다.

---

## 수정 대상 파일

```
/conversion_yanki/kanjify_data1.py
```

---

## 해야 할 작업

### 1. `normalize_pos()` 함수 추가

`extract_part_speech()` 함수 바로 아래에 `normalize_pos()` 함수를 새로 추가한다.

이 함수가 처리해야 할 내용:

**① 반각 카타카나 → 전각으로 통일**
NFKC 정규화를 적용한다. 예: `ﾀﾞ` → `ダ`, `ﾅ` → `ナ`
- `명사, ﾀﾞナ` (103건) → `명사, ダナ`
- `ﾀﾞナノ` (15건) → `ダナノ`
- 기타 파생 케이스 모두 처리됨

**② 가운뎃점 문자 통일**
`∙`(U+2219 BULLET OPERATOR)를 `·`(U+00B7 MIDDLE DOT)로 치환한다.
그 다음, 약어 표기(`자·타`)를 풀어쓰기(`자동사·타동사`)로 통일한다.
- `5단활용 자∙타동사` → `5단활용 자동사·타동사`
- `하1단 자·타동사` → `하1단 자동사·타동사`
- `サ행변격 자∙타동사` → `サ행변격 자동사·타동사`
- `상1단 자∙타동사` → `상1단 자동사·타동사`
- `ス자∙타동사` → `ス자동사·타동사`

### 2. `extract_part_speech()` 반환 직전에 `normalize_pos()` 호출

현재 마지막 줄:
```python
return strip_html(m.group(1)).strip()[:50]
```
→ 추출한 텍스트에 `normalize_pos()`를 적용한 뒤 반환하도록 수정.

---

## 건드리지 말아야 할 것

- `ダナ` 단독 (120건) 과 `명사, ダナ` (73건) 은 **다른 품사**임. 합치지 말 것.
  - `ダナ` 단독: 순수 な형용사 (嫌, 綺麗, 静か 등)
  - `명사, ダナ`: 명사이면서 な형용사로도 쓰이는 단어
- 나머지 78종 pos 값은 위 두 가지 정규화 외에 추가 변경 없음.

---

## 검증 방법

수정 후 아래 명령으로 변환 결과 확인:

```bash
cd conversion_yanki
python3 -c "
import sqlite3, re, html as _html, unicodedata
# kanjify_data1.py의 extract_part_speech + normalize_pos 를 import해서
# Anki DB에서 pos 값 전체를 추출하고 출력
from kanjify_data1 import extract_part_speech, parse_fields
from collections import Counter
WORD_MID = 1728981502167
conn = sqlite3.connect('collection_extracted.anki21')
cur = conn.cursor()
cur.execute('SELECT flds FROM notes WHERE mid = ?', (WORD_MID,))
counter = Counter()
for (flds,) in cur.fetchall():
    fields = parse_fields(flds)
    pos = extract_part_speech(fields[5] if len(fields) > 5 else '')
    if pos: counter[pos] += 1
conn.close()
for pos, cnt in counter.most_common():
    print(f'{cnt:4d}  {repr(pos)}')
"
```

정규화가 제대로 됐다면:
- `ﾀﾞ`가 포함된 항목이 결과에 없어야 함
- `∙`(U+2219)가 포함된 항목이 없어야 함
- `자·타동사` 약어 표기가 없어야 함 (모두 `자동사·타동사`로 풀려야 함)
