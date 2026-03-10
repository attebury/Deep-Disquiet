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

### GitHub shows deploy "X ahead, Y behind main"

Deploy is an orphan branch (no shared history with main). GitHub still shows ahead/behind; that’s normal. If deploy picked up source files (e.g. `deploy.sh`) from earlier runs, run `./deploy.sh` again from `main` so it pushes a clean built site; the next push updates deploy and should trigger your host.

### DanubeData (or other Git-deploy hosts)

1. **Which branch does the project use?** In DanubeData, set the project to deploy from branch **`deploy`** (not `main`). Then each push to `deploy` is a new deployment.
2. **Trigger a deployment:** From your machine, run `./deploy.sh` (on `main`). It builds, updates the `deploy` branch, and pushes. DanubeData should see the push to `deploy` and deploy.
3. If the project is set to `main`, then pushes to `deploy` won’t trigger. Either switch the project to branch `deploy`, or use a single-branch flow (commit `_site` on main and point the project at `main`).

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
