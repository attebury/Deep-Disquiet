# Deploying Deep Disquiet

This is a Jekyll site. Pushing to the repo does **not** automatically update the live site.

## Build locally

```bash
bundle install
bundle exec jekyll build
```

Output is in `_site/`. Serve that directory with any web server (e.g. nginx `root` pointing at `_site`), or upload `_site/` to your host.

## If you see "Welcome to nginx!"

The server is serving nginx’s default page, not this site. You need to either:

1. **Point nginx at the built site** — set the vhost `root` to this repo’s `_site/` directory (after running `jekyll build` on the server or in CI), or  
2. **Use a Git-based host** (e.g. GitHub Pages, Statichost, IONOS Deploy Now) so they build and serve the site; then you don’t use nginx for this project.

See the main project’s [dx/deep-disquiet-site-deployment.md](../../dx/deep-disquiet-site-deployment.md) (in the deep-disquiet repo) for full options.
