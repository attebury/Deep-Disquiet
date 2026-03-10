#!/usr/bin/env bash
# Build Jekyll and push the built site to the 'deploy' branch.
# Server pulls 'deploy' and points nginx at the repo root (no _site/ subdir).
set -e
bundle exec jekyll build

if ! git show-ref --verify refs/heads/deploy 2>/dev/null; then
  # First time: create orphan branch with built site at root
  git checkout --orphan deploy
  git rm -rf . 2>/dev/null || true
  cp -r _site/* .
  [[ -f _site/.gitignore ]] && cp _site/.gitignore . || true
  git add -A
  git commit -m "Deploy built site"
  git push -u origin deploy
  git checkout main
else
  git checkout deploy
  rsync -av _site/ . --exclude .git
  git add -A
  git diff --staged --quiet && echo "No changes to deploy" || git commit -m "Deploy built site"
  git push origin deploy
  git checkout main
fi

echo "Deployed to branch 'deploy'. On server: git pull origin deploy"
