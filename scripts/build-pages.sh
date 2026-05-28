#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/dist"
CNAME_FILE="$ROOT/public/CNAME"

rm -rf "$OUT"
mkdir -p "$OUT"

cp -r "$ROOT/public/images" "$OUT/images"
if [ -f "$ROOT/public/Naveen-Singh-CV.pdf" ]; then
  cp "$ROOT/public/Naveen-Singh-CV.pdf" "$OUT/Naveen-Singh-CV.pdf"
fi
if [ -f "$CNAME_FILE" ]; then
  cp "$CNAME_FILE" "$OUT/CNAME"
fi
touch "$OUT/.nojekyll"

# GitHub Pages: project sites live at https://user.github.io/REPO_NAME/
# Custom domains are served from the domain root (https://example.com/), not /REPO/.
# Relative "images/..." can resolve to https://user.github.io/images/... without a trailing slash.
IMAGE_PREFIX="/images/"
SITE_PREFIX="/"
USE_CUSTOM_DOMAIN=0

if [ -f "$CNAME_FILE" ]; then
  CUSTOM_DOMAIN="$(tr -d '[:space:]' < "$CNAME_FILE")"
  if [ -n "$CUSTOM_DOMAIN" ]; then
    USE_CUSTOM_DOMAIN=1
    echo "Custom domain (public/CNAME) → root paths: ${IMAGE_PREFIX}"
  fi
fi

if [ "$USE_CUSTOM_DOMAIN" -eq 0 ] && [ -n "${GITHUB_REPOSITORY:-}" ]; then
  OWNER="${GITHUB_REPOSITORY%%/*}"
  REPO="${GITHUB_REPOSITORY##*/}"
  if [ "$REPO" != "${OWNER}.github.io" ]; then
    SITE_PREFIX="/${REPO}/"
    IMAGE_PREFIX="${SITE_PREFIX}images/"
    echo "GitHub Pages project site → image prefix: ${IMAGE_PREFIX}"
  else
    echo "GitHub Pages user site → image prefix: ${IMAGE_PREFIX}"
  fi
fi

CV_HREF="${SITE_PREFIX}Naveen-Singh-CV.pdf"

sed -e "s|src=\"images/|src=\"${IMAGE_PREFIX}|g" \
    -e "s|href=\"Naveen-Singh-CV.pdf\"|href=\"${CV_HREF}\"|g" \
    "$ROOT/index.html" > "$OUT/index.html"

echo "Built GitHub Pages site in dist/"
