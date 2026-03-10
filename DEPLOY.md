# Deploying Deep Disquiet

This is a Jekyll site. **Recommended:** use the `deploy` branch so `main` stays source-only and the server pulls built files.

## Deploy branch (recommended)

Build and push the built site to branch `deploy`. The server clones/pulls `deploy` and points nginx at the repo root.

```bash
bundle install   # once
./deploy.sh
```

On the server (first time): `git clone -b deploy <repo-url> deep-disquiet && cd deep-disquiet`  
Then point nginx `root` at this directory. For updates: `git pull origin deploy`.

`main` stays clean (no `_site/` committed). Only the `deploy` branch holds the built HTML/assets.

## Alternative: commit _site on main

If you prefer a single branch, unignore `_site/` in `.gitignore`, then:

```bash
bundle exec jekyll build
git add _site
git commit -m "Build site"
git push
```

On the server: pull, point nginx at `_site/`.

## If you see "Welcome to nginx!"

The server is serving nginx’s default page, not this site. You need to either:

1. **Point nginx at the built site** — set the vhost `root` to this repo’s `_site/` directory (after running `jekyll build` on the server or in CI), or  
2. **Use a Git-based host** (e.g. GitHub Pages, Statichost, IONOS Deploy Now) so they build and serve the site; then you don’t use nginx for this project.

See the main project’s [dx/deep-disquiet-site-deployment.md](../../dx/deep-disquiet-site-deployment.md) (in the deep-disquiet repo) for full options.
