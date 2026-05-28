#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/dist"

rm -rf "$OUT"
mkdir -p "$OUT"

cp -r "$ROOT/public/images" "$OUT/images"
if [ -f "$ROOT/public/Naveen-Singh-CV.pdf" ]; then
  cp "$ROOT/public/Naveen-Singh-CV.pdf" "$OUT/Naveen-Singh-CV.pdf"
fi
touch "$OUT/.nojekyll"

# GitHub Pages: project sites live at https://user.github.io/REPO_NAME/
# Relative "images/..." wrongly resolves to https://user.github.io/images/...
# Rewrite to absolute paths with the correct prefix.
IMAGE_PREFIX="/images/"
SITE_PREFIX="/"

if [ -n "${GITHUB_REPOSITORY:-}" ]; then
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
