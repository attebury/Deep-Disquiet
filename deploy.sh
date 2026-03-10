#!/usr/bin/env bash
# Build Jekyll and push the built site to the 'deploy' branch.
# Server pulls 'deploy' and points nginx at the repo root (no _site/ subdir).
set -e
bundle exec jekyll build

# Keep build in a temp dir; after "git checkout deploy" the working tree is deploy's,
# so _site/ would be overwritten by deploy's _site/ if that dir is tracked.
BUILD_DIR=$(mktemp -d)
cp -r _site/. "$BUILD_DIR"

if ! git show-ref --verify refs/heads/deploy 2>/dev/null; then
  # First time: create orphan branch with built site at root
  git checkout --orphan deploy
  git rm -rf . 2>/dev/null || true
  cp -r "$BUILD_DIR"/* .
  [[ -f "$BUILD_DIR/.gitignore" ]] && cp "$BUILD_DIR/.gitignore" . || true
  git add -A
  git commit -m "Deploy built site"
  git push -u origin deploy
  git checkout main
else
  git checkout deploy
  # Remove any _site/ on deploy so rsync doesn't try to match dest _site/ to source
  rm -rf _site
  rsync -av --delete "$BUILD_DIR"/ . --exclude .git
  git add -A
  git diff --staged --quiet && echo "No changes to deploy" || git commit -m "Deploy built site"
  git push origin deploy
  git checkout main
fi
rm -rf "$BUILD_DIR"

echo "Deployed to branch 'deploy'. On server: git pull origin deploy"
