"""Build _data/projects.json from public repos of the user that carry the 'portfolio' topic."""
import json
import os
import urllib.request

USER = "josesaid"
TOPIC = "portfolio"
OUT = "_data/projects.json"


def fetch_repos(token):
    url = f"https://api.github.com/users/{USER}/repos?per_page=100&type=public&sort=pushed"
    headers = {
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        "User-Agent": "projects-index-updater",
    }
    if token:
        headers["Authorization"] = f"Bearer {token}"
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=30) as resp:
        return json.load(resp)


def main():
    repos = fetch_repos(os.environ.get("GITHUB_TOKEN"))
    items = []
    for r in repos:
        if r.get("fork") or r.get("archived"):
            continue
        if r["name"] == f"{USER}.github.io":
            continue
        if TOPIC not in (r.get("topics") or []):
            continue
        items.append({
            "name": r["name"],
            "description": r.get("description") or "",
            "url": r["html_url"],
            "page": f"https://{USER}.github.io/{r['name']}/" if r.get("has_pages") else "",
            "language": r.get("language") or "",
            "updated": (r.get("pushed_at") or "")[:10],
        })
    items.sort(key=lambda x: x["updated"], reverse=True)
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(items, f, ensure_ascii=False, indent=2)
        f.write("\n")
    print(f"{len(items)} project(s) written to {OUT}")


if __name__ == "__main__":
    main()
