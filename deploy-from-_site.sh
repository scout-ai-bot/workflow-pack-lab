#!/bin/bash
# Fallback deploy script — run from _site/ directory
# Usage: cd _site && bash deploy-from-_site.sh
set -e
CANONICAL="https://scout-ai-bot.github.io/workflow-pack-lab"
STALE="https://scout-ai-bot.github.io/workflow-pack-lab"

echo "=== Deploy from _site/ ==="
echo "Canonical domain: $CANONICAL"

# Fix domain in sitemap if stale
if grep -q "$STALE" sitemap.xml 2>/dev/null; then
  sed -i "s|$STALE|$CANONICAL|g" sitemap.xml
  echo "Fixed sitemap domain → $CANONICAL"
fi

# Git operations (this IS the git repo root)
git add .
git commit -m "deploy: auto-$(date +%Y-%m-%d-%H%M)" || echo "Nothing to commit"
git push origin
echo "Deploy complete: $CANONICAL/"
