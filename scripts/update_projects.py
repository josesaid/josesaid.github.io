"""Build _data/projects.json from public repos of the user that carry the 'portfolio' topic.

A repo gets a 'page' link only when it has docs/index.html, because that file is the
GitHub Pages site for the project. Otherwise the card links to the repo only.
"""
import json
import os
import urllib.error
import urllib.request
from datetime import datetime, timedelta, timezone

USER = "josesaid"
TOPIC = "portfolio"
OUT = "docs/_data/projects.json"
NEW_DAYS = 3
LOCAL_TZ = timezone(timedelta(hours=-6))  # America/Mexico_City (no DST)


def _headers(token):
    h = {
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        "User-Agent": "projects-index-updater",
    }
    if token:
        h["Authorization"] = f"Bearer {token}"
    return h


def fetch_repos(token):
    url = f"https://api.github.com/users/{USER}/repos?per_page=100&type=public&sort=pushed"
    req = urllib.request.Request(url, headers=_headers(token))
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.load(resp)


def has_docs_index(full_name, token):
    url = f"https://api.github.com/repos/{full_name}/contents/docs/index.html"
    req = urllib.request.Request(url, headers=_headers(token))
    try:
        with urllib.request.urlopen(req, timeout=30):
            return True
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return False
        raise


def load_previous():
    """Return {name: first_seen} from the last run, so new repos can be flagged."""
    if not os.path.exists(OUT):
        return {}
    with open(OUT, encoding="utf-8") as f:
        return {p["name"]: p.get("first_seen", "") for p in json.load(f)}


def main():
    token = os.environ.get("GITHUB_TOKEN")
    seen = load_previous()
    now = datetime.now(LOCAL_TZ).date()
    items = []
    for r in fetch_repos(token):
        if r.get("fork") or r.get("archived"):
            continue
        if r["name"] == f"{USER}.github.io":
            continue
        if TOPIC not in (r.get("topics") or []):
            continue
        page = ""
        if r.get("has_pages") and has_docs_index(r["full_name"], token):
            page = f"https://{USER}.github.io/{r['name']}/"
        first_seen = seen.get(r["name"]) or now.isoformat()
        age = (now - datetime.fromisoformat(first_seen).date()).days
        items.append({
            "name": r["name"],
            "description": r.get("description") or "",
            "url": r["html_url"],
            "page": page,
            "language": r.get("language") or "",
            "updated": (r.get("pushed_at") or "")[:10],
            "first_seen": first_seen,
            "new": age < NEW_DAYS,
        })
    items.sort(key=lambda x: x["updated"], reverse=True)
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(items, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"{len(items)} project(s) written to {OUT}")


if __name__ == "__main__":
    main()
