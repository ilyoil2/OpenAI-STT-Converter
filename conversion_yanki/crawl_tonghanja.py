#!/usr/bin/env python3
"""tonghanja.com 한자 데이터 크롤러.

tonghanja.com 은 WordPress 사이트이고 REST API 가 공개돼 있어서
HTML 스크래핑 없이 JSON 으로 한자 글을 전부 받아올 수 있다.

각 글 = 한자 1개. 제목이 `훈 음(漢字)` 형식 (예: "얼굴 모(皃)").
본문에는 의미 / 구성요소(부수) / 풀이 설명이 들어있다.

사용 예:
    # 1) 전체 크롤링 -> CSV 저장
    python crawl_tonghanja.py crawl --out tonghanja.csv

    # 2) 내 DB 글자 목록과 비교 (한자 한 글자씩 들어있는 텍스트/CSV 파일)
    python crawl_tonghanja.py compare --crawl tonghanja.csv --mine my_chars.txt

`mine` 파일은 한자가 한 줄에 하나씩 있거나, 첫 컬럼이 한자인 CSV 면 된다.
DB 에서 뽑으려면:  psql -tAc "SELECT character FROM tbl_content_kanji" > my_chars.txt
"""

import argparse
import csv
import html
import re
import sys
import time
import urllib.request

BASE = "http://tonghanja.com/wp-json/wp/v2/posts"
PER_PAGE = 100

# 큰 글자(24px) 바로 뒤의 작은(11px) 메타 영역: ".급수  한자: 훈음  한자: 훈음"
META_RE = re.compile(
    r"font-size:\s*24px[^>]*>(.*?)</span>\s*"
    r"<span[^>]*font-size:\s*11px[^>]*>(.*?)</span>",
    re.S,
)
# 메타에서 'X:' 형태로 콜론 앞에 오는 한자 1글자 (CJK 통합+호환)
COMP_RE = re.compile("([" "㐀-鿿豈-﫿" "])\\s*:")

# 부수 이형(異形) 정규화: 사이트/내 DB 표기 차이를 흡수. 변형 -> 대표형.
RADICAL_NORMALIZE = {
    "氵": "水",  # 氵 -> 水
    "扌": "手",  # 扌 -> 手
    "刂": "刀",  # 刂 -> 刀
    "忄": "心",  # 忄 -> 心
    "艹": "艸",  # 艹 -> 艸
    "辶": "辵",  # 辶 -> 辵
    "犭": "犬",  # 犭 -> 犬
    "礻": "示",  # 礻 -> 示
    "衤": "衣",  # 衤 -> 衣
    "亻": "人",  # 亻 -> 人
    "灬": "火",  # 灬 -> 火
    "罒": "网",  # 罒 -> 网
    "糹": "糸",  # 糹 -> 糸 (실사변, 코드포인트만 다름)
}


def normalize_comp(ch):
    return RADICAL_NORMALIZE.get(ch, ch)


def extract_components(content_html):
    """본문 HTML 에서 구성요소 한자 집합과 상태를 추출.

    반환: (comps:set[str], status)
      status = "ok"    : 구성요소 한자 추출됨
               "image" : 콜론은 있으나 한자가 이미지(유니코드 X) -> 못 읽음
               "none"  : 구성요소 메타가 없음(기본 부수 등)
    """
    m = META_RE.search(content_html)
    if not m:
        return set(), "none"
    meta = html.unescape(re.sub(r"<[^>]+>", "", m.group(2)))
    comps = {normalize_comp(c) for c in COMP_RE.findall(meta)}
    if comps:
        return comps, "ok"
    if ":" in meta:
        return set(), "image"
    return set(), "none"


# 메타에서 '한자: 훈음' 쌍 추출 (훈음은 다음 '한자:' 또는 끝까지)
COMP_DETAIL_RE = re.compile(
    r"([㐀-鿿豈-﫿])\s*:\s*(.*?)(?=[㐀-鿿豈-﫿]\s*:|$)", re.S
)


def extract_components_detail(content_html):
    """사이트 메타에서 '한자(훈음)' 형태의 사람이 읽는 구성요소 문자열 추출.

    예: '壴: 북 주  十: 모양  又: 또(손) 우' -> '壴(북 주) 十(모양) 又(또(손) 우)'
    """
    m = META_RE.search(content_html)
    if not m:
        return ""
    meta = html.unescape(re.sub(r"<[^>]+>", "", m.group(2)))
    out = []
    for ch, reading in COMP_DETAIL_RE.findall(meta):
        reading = reading.strip().strip(",").strip()
        out.append(f"{ch}({reading})" if reading else ch)
    return " ".join(out)
# CJK 통합 한자 + 확장 + 호환 영역
HANJA_RE = re.compile(r"\(([㐀-鿿豈-﫿\U00020000-\U0002ebef])\)")


def fetch_json(url, retries=3):
    for attempt in range(retries):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "hanja-compare/1.0"})
            with urllib.request.urlopen(req, timeout=30) as r:
                total = r.headers.get("X-WP-Total")
                import json
                return json.loads(r.read().decode("utf-8")), total
        except Exception as e:  # noqa: BLE001
            if attempt == retries - 1:
                raise
            sys.stderr.write(f"  재시도 {attempt + 1}: {e}\n")
            time.sleep(2)


def strip_html(s):
    s = re.sub(r"<[^>]+>", " ", s)
    s = html.unescape(s)
    return re.sub(r"\s+", " ", s).strip()


def parse_title(title):
    """제목에서 (한자) 와 훈음을 추출. 한자 없으면 (None, None)."""
    title = title.strip()
    m = HANJA_RE.search(title)
    if not m:
        return None, None
    char = m.group(1)
    hun_eum = HANJA_RE.sub("", title).strip()  # 괄호 한자 제거 -> "얼굴 모"
    return char, hun_eum


def crawl(out_path, delay=0.3):
    rows = []
    seen = set()
    page = 1
    total_pages = None
    while True:
        url = (
            f"{BASE}?per_page={PER_PAGE}&page={page}"
            f"&_fields=id,link,title,content"
        )
        data, total = fetch_json(url)
        if not data:
            break
        if total_pages is None and total:
            total_pages = (int(total) + PER_PAGE - 1) // PER_PAGE
        for d in data:
            title = d["title"]["rendered"]
            char, hun_eum = parse_title(title)
            if not char or char in seen:
                continue  # 'ttt' 같은 쓰레기 글 / 중복 건너뛰기
            seen.add(char)
            content_html = d.get("content", {}).get("rendered", "")
            comps, status = extract_components(content_html)
            rows.append(
                {
                    "character": char,
                    "hun_eum": hun_eum,
                    # 정렬·부수정규화된 구성요소 한자열 (예: "弗水"). DB의 comp_norm()과 같은 규칙.
                    "components_norm": "".join(sorted(comps)),
                    # 사람이 읽는 형태: '壴(북 주) 十(모양) 又(또 우)'
                    "components_detail": extract_components_detail(content_html),
                    "comp_status": status,
                    "title": strip_html(title),
                    "link": d.get("link", ""),
                    "content": strip_html(content_html)[:2000],
                }
            )
        sys.stderr.write(
            f"page {page}"
            + (f"/{total_pages}" if total_pages else "")
            + f"  수집 {len(rows)}\n"
        )
        if total_pages and page >= total_pages:
            break
        if len(data) < PER_PAGE:
            break
        page += 1
        time.sleep(delay)

    with open(out_path, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(
            f,
            fieldnames=[
                "character", "hun_eum", "components_norm", "components_detail",
                "comp_status", "title", "link", "content",
            ],
        )
        w.writeheader()
        w.writerows(rows)
    sys.stderr.write(f"\n완료: {len(rows)}개 한자 -> {out_path}\n")


def load_chars(path):
    """한 줄 1글자 텍스트, 또는 첫 컬럼이 한자인 CSV 에서 한자 집합 추출."""
    chars = set()
    with open(path, encoding="utf-8") as f:
        sample = f.read()
    for line in sample.splitlines():
        line = line.strip().strip('"').strip("'")
        if not line:
            continue
        first = line.split(",")[0].strip().strip('"')
        for ch in first:
            if "㐀" <= ch <= "鿿" or "豈" <= ch <= "﫿":
                chars.add(ch)
                break
    return chars


def compare(crawl_path, mine_path):
    site = {}
    with open(crawl_path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            site[row["character"]] = row["hun_eum"]
    mine = load_chars(mine_path)
    site_chars = set(site)

    only_site = sorted(site_chars - mine)
    only_mine = sorted(mine - site_chars)
    both = site_chars & mine

    print(f"사이트(tonghanja): {len(site_chars)}개")
    print(f"내 DB:            {len(mine)}개")
    print(f"공통:             {len(both)}개\n")
    print(f"=== 사이트에만 있음 (내 DB 에 추가 후보) : {len(only_site)}개 ===")
    for ch in only_site:
        print(f"  {ch}  {site[ch]}")
    print(f"\n=== 내 DB 에만 있음 : {len(only_mine)}개 ===")
    print("  " + " ".join(only_mine))


def comp_set(text):
    """문자열에서 구성요소 한자 집합 추출 + 부수 이형 정규화.

    내 DB components 예: '凵(입벌릴 감) + 米(쌀 미) + 匕(비수 비)'
    -> 괄호 안 훈음은 버리고 한자만 추출.
    """
    cleaned = re.sub(r"\([^)]*\)", "", text or "")  # 괄호 훈음 제거
    out = set()
    for ch in cleaned:
        if "㐀" <= ch <= "鿿" or "豈" <= ch <= "﫿":
            out.add(normalize_comp(ch))
    return out


def load_mine_components(path):
    """내 DB 의 (character, components) 매핑 로드.

    CSV(헤더에 character/components) 또는 'character<TAB/,>components' 2컬럼.
    """
    mp = {}
    with open(path, encoding="utf-8") as f:
        text = f.read()
    has_header = "character" in text.splitlines()[0].lower() if text else False
    f2 = path
    with open(f2, encoding="utf-8") as f:
        if has_header:
            reader = csv.DictReader(f)
            for row in reader:
                ch = (row.get("character") or "").strip()
                if ch:
                    mp[ch[0]] = comp_set(row.get("components", ""))
        else:
            for line in f:
                parts = re.split(r"[\t,]", line.rstrip("\n"), maxsplit=1)
                if not parts or not parts[0].strip():
                    continue
                ch = parts[0].strip()[0]
                mp[ch] = comp_set(parts[1] if len(parts) > 1 else "")
    return mp


def compare_components(crawl_path, mine_path, show_all=False):
    site = {}
    with open(crawl_path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            site[row["character"]] = (
                comp_set(row.get("components_norm", "")),
                row.get("comp_status", ""),
            )
    mine = load_mine_components(mine_path)
    shared = sorted(set(site) & set(mine))

    same = diff = unreadable = both_empty = 0
    diffs = []
    for ch in shared:
        s_comps, status = site[ch]
        m_comps = mine[ch]
        if status in ("image",) and not s_comps:
            unreadable += 1
            continue
        if not s_comps and not m_comps:
            both_empty += 1
            continue
        if s_comps == m_comps:
            same += 1
        else:
            diff += 1
            diffs.append((ch, s_comps, m_comps))

    print(f"공통 한자: {len(shared)}개")
    print(f"  구성요소 일치     : {same}")
    print(f"  구성요소 불일치   : {diff}")
    print(f"  사이트 못읽음(이미지): {unreadable}")
    print(f"  양쪽 구성요소 없음: {both_empty}\n")
    print("=== 불일치 목록 (글자: 사이트 / 내DB) ===")
    for ch, s, m in diffs:
        only_s = "".join(sorted(s - m)) or "-"
        only_m = "".join(sorted(m - s)) or "-"
        print(
            f"  {ch}  사이트[{''.join(sorted(s))}] vs 내DB[{''.join(sorted(m))}]"
            f"   (사이트만:{only_s} 내DB만:{only_m})"
        )


def main():
    ap = argparse.ArgumentParser(description="tonghanja.com 한자 크롤러/비교")
    sub = ap.add_subparsers(dest="cmd", required=True)

    c = sub.add_parser("crawl", help="전체 크롤링 -> CSV")
    c.add_argument("--out", default="tonghanja.csv")
    c.add_argument("--delay", type=float, default=0.3, help="페이지간 대기(초)")

    p = sub.add_parser("compare", help="크롤 CSV 와 내 DB 글자 목록(존재) 비교")
    p.add_argument("--crawl", required=True)
    p.add_argument("--mine", required=True)

    cc = sub.add_parser(
        "compare-components", help="공통 한자의 구성요소(components) 비교"
    )
    cc.add_argument("--crawl", required=True, help="crawl 로 만든 tonghanja.csv")
    cc.add_argument(
        "--mine", required=True,
        help="내 DB export: character,components (CSV 또는 2컬럼)",
    )

    args = ap.parse_args()
    if args.cmd == "crawl":
        crawl(args.out, args.delay)
    elif args.cmd == "compare":
        compare(args.crawl, args.mine)
    else:
        compare_components(args.crawl, args.mine)


if __name__ == "__main__":
    main()
