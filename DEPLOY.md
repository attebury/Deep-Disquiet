# Deploying Deep Disquiet

This is a Jekyll site. You can **build locally and push** so the server only serves the built files (no Jekyll on the server).

## Deploy workflow: build locally, then push

```bash
bundle install
bundle exec jekyll build
git add _site
git commit -m "Build site"
git push
```

On the server: pull, then point nginx at the `_site/` directory. No Ruby or Jekyll needed on the server.

## If you see "Welcome to nginx!"

The server is serving nginx’s default page, not this site. You need to either:

1. **Point nginx at the built site** — set the vhost `root` to this repo’s `_site/` directory (after running `jekyll build` on the server or in CI), or  
2. **Use a Git-based host** (e.g. GitHub Pages, Statichost, IONOS Deploy Now) so they build and serve the site; then you don’t use nginx for this project.

See the main project’s [dx/deep-disquiet-site-deployment.md](../../dx/deep-disquiet-site-deployment.md) (in the deep-disquiet repo) for full options.
