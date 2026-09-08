# How to set up

How this README is generated, which tokens it needs, and how to do a **local dry run**
before pushing.

## What runs

`.github/workflows/readme.yaml` builds `markscribe` from source (pinned to commit
`d838b6e71dc673e8a3ef248b0e75fbd44ce8cc4c` on `muesli/markscribe`) and runs:

```
markscribe -write README.md templates/readme.md.tpl
```

That pin matters: the `muesli/readme-scribe@master` action runs
`docker://fribbledom/markscribe`, a third-party image frozen since 2021 — it predates
literal.club support and can never render the "Books I'm reading" section. No tagged
release of `markscribe` includes literal.club support either (last tag `v0.6.0` is from
2021); it only exists on `master`. Building from source at that pinned commit is what
makes the section work, in CI and locally.

After rendering, `stefanzweifel/git-auto-commit-action` commits the generated
`README.md`.

Rule: edit `templates/readme.md.tpl`. `README.md` is a build artifact, overwritten
daily at 06:00 UTC (and on every push).

## Tokens

The template uses three functions. Two need credentials:

| Function in the template | Needs | If missing |
| --- | --- | --- |
| `recentRepos 5` | `GITHUB_TOKEN` | fails (GitHub's GraphQL API requires auth) |
| `recentContributions 3` | `GITHUB_TOKEN` | fails |
| `rss "…goodreads.com/review/list_rss/117658013?shelf=currently-reading" 3` | nothing | works without a token |
| `rss "https://osmarpetry.dev/rss.xml" 3` | nothing | works without a token |

### `GITHUB_TOKEN`

Classic PAT: `Settings` → `Developer settings` → `Personal access tokens` →
`Tokens (classic)` → `Generate new token (classic)`.

Scopes: **`public_repo`**, **`read:user`**, **`repo:status`**.

Don't use the automatic Actions `GITHUB_TOKEN`: it can't read cross-repository
contributions, which is why the workflow reads from `secrets.GH_PAT` instead.

A fine-grained token doesn't work well here — the GraphQL API used by
`recentContributions` expects the classic scopes above.

### Books: no credential at all

The reading list comes from the public Goodreads shelf RSS feed:

```
https://www.goodreads.com/review/list_rss/117658013?shelf=currently-reading
```

No token, no API key. Two things to know:

- The feed only lists what is on the **currently-reading** shelf. If that shelf is
  empty, the section renders empty — that is a Goodreads state, not a template bug.
- Goodreads **stopped issuing API keys in December 2020**, so the `goodReads*` template
  functions are dead for any account without an old key. literal.club is the other
  supported option, but it needs `LITERAL_EMAIL` / `LITERAL_PASSWORD` and email/password
  login, which an account created via Google/Apple sign-in does not have. The RSS feed
  avoids both problems.

### Why the blog feed is fetched from `new-hugo-eka.pages.dev`

The zone `osmarpetry.dev` runs Cloudflare **Bot Fight Mode** on the Free plan, which
challenges non-browser clients coming from datacenter IPs. A GitHub runner gets
`403 Forbidden` and a `Just a moment...` challenge page for **every** User-Agent —
browser strings included — so `markscribe` aborts and the whole README render dies with
it, not just that one section.

Free-plan Bot Fight Mode is zone-wide and cannot be skipped per path (only Super Bot
Fight Mode, Pro and up, supports skip rules). A Configuration Rule turning off Browser
Integrity Check and Security Level for `/rss.xml` was tried and did **not** help.

So the template reads the feed from the Cloudflare Pages origin instead, which is not
behind the zone WAF. The file is byte-identical and its item links are canonical
`osmarpetry.dev` URLs, so the rendered output is exactly the same. If the Pages project
is ever renamed, update that URL.

## Where to put the secrets

On GitHub: `Settings` → `Secrets and variables` → `Actions` → `New repository secret`.
Exact name, as referenced by the workflow: **`GH_PAT`**. Nothing else is needed.

## Local dry run

Start Docker Desktop first (`open -a Docker`).

Create `.env.local` at the repo root — **and make sure it's in `.gitignore`**:

```bash
echo '.env.local' >> .gitignore

cat > .env.local <<'EOF'
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx
EOF
chmod 600 .env.local
```

Docker `.env` format: `KEY=value`, no `export`, no quotes, no space around `=`.

Render to a temporary file, not to the real `README.md`, so the dry run doesn't dirty
the tree:

```bash
docker run --rm --env-file .env.local \
  -v "$PWD:/github/workspace" -w /github/workspace \
  golang:1.22 sh -c "go install github.com/muesli/markscribe@d838b6e71dc673e8a3ef248b0e75fbd44ce8cc4c && markscribe -write README.dryrun.md templates/readme.md.tpl"

cat README.dryrun.md
```

Without the secrets (useful to check the overall structure first):

```bash
docker run --rm -v "$PWD:/github/workspace" -w /github/workspace \
  golang:1.22 sh -c "go install github.com/muesli/markscribe@d838b6e71dc673e8a3ef248b0e75fbd44ce8cc4c && markscribe -write README.dryrun.md templates/readme.md.tpl"
```

Without `GITHUB_TOKEN`, `markscribe` panics on the
first function call that needs them — rendering stops right there, so everything after
that section in the template is silently missing from the output too. That's expected;
it's not a sign the rest of the template is broken.

To see it rendered for real, paste the output into any GitHub markdown preview — images
with a relative path (`cool-image.png`) only resolve once the file is committed to the
repo.

Delete the artifact afterward: `rm README.dryrun.md`.

## What to do on GitHub

1. **Repository name.** A profile README is only rendered on your profile if the repo is
   named exactly like the user: `osmarpetry/osmarpetry`. This one is
   `osmarpetry/gh-profile`, so the generated file never shows up there. Either rename it
   under `Settings` -> `General` -> `Repository name`, or make the workflow push
   `README.md` to the profile repo instead (that PAT then needs the `repo` scope).
2. Repo must be **public** — a profile README in a private repo is not displayed.
3. `Settings` -> `Secrets and variables` -> `Actions`: add `GH_PAT`. That is the only
   secret the workflow reads.
4. `Settings` -> `Actions` -> `General` -> `Workflow permissions`: **Read and write**,
   otherwise `git-auto-commit-action` cannot push the generated `README.md`.
5. Push. `on: push` triggers the job; the generated commit is made with the default
   `GITHUB_TOKEN`, which does not re-trigger workflows — no loop.

## Checklist before pushing

- [ ] `cool-image.png` committed (otherwise the generated README points to a 404)
- [ ] `https://osmarpetry.dev/rss.xml` actually responds
- [ ] `.env.local` is in `.gitignore`, never committed
- [ ] `README.dryrun.md` deleted, not committed
- [ ] truncated dry-run `README.md` not committed — let CI generate it
- [ ] repo renamed to `osmarpetry`, or the cross-repo push sorted out
