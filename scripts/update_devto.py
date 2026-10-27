"""Build _data/devto_posts.json from the public Dev.to articles of the user.

Each article keeps the date it was first seen (first_seen). An article is marked
"new" for NEW_DAYS days after that, so the home page can show the NEW badge.
"""
import json
import os
import urllib.request
from datetime import datetime, timedelta, timezone

USER = "said_olano"
OUT = "docs/_data/devto_posts.json"
NEW_DAYS = 3
LOCAL_TZ = timezone(timedelta(hours=-6))  # America/Mexico_City (no DST)


def today():
    return datetime.now(LOCAL_TZ).date()


def fetch_articles():
    url = f"https://dev.to/api/articles?username={USER}&per_page=100"
    req = urllib.request.Request(url, headers={"User-Agent": "portfolio-index-updater"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.load(resp)


def load_previous():
    if not os.path.exists(OUT):
        return {}
    with open(OUT, encoding="utf-8") as f:
        return {p["url"]: p.get("first_seen", "") for p in json.load(f)}


def main():
    seen = load_previous()
    first_run = not seen
    now = today()
    items = []
    for a in fetch_articles():
        url = a["url"]
        published = (a.get("published_at") or "")[:10]
        # First run: treat existing articles as already seen, so only later ones are NEW.
        default = published if first_run and published else now.isoformat()
        first_seen = seen.get(url) or default
        age = (now - datetime.fromisoformat(first_seen).date()).days
        items.append({
            "title": a["title"],
            "description": a.get("description") or "",
            "url": url,
            "date": (a.get("published_at") or "")[:10],
            "first_seen": first_seen,
            "new": age < NEW_DAYS,
        })
    items.sort(key=lambda x: x["date"], reverse=True)
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(items, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"{len(items)} Dev.to article(s) written to {OUT}")


if __name__ == "__main__":
    main()
