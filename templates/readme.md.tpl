### Moien 👋
I'm [Osmar](https://osmarpetry.dev) — Luxembourgish-Brazilian, based in Luxembourg,
building and operating resilient AI products in TypeScript and Python.

**Operating** is the part that is not on the [resume](https://osmarpetry.dev/resume/): I go
as deep as the product needs. Temporal workflows that survive retries and partial failures,
Postgres and Supabase schemas and queries, tracing and structured logs so a bad run is
diagnosed from evidence instead of guessed at. Not a DBA, not an SRE — the slice of each
that keeps my own products up.

I speak **Portuguese** and **English**, I'm learning **French**. Ask me anything in the first two; be
patient with the third.

My CV also lives in DNS, if you have a terminal:

```bash
printf '%b\n' "$(dig +short TXT cv.osmarpetry.dev | sed 's/" "//g; s/^"//; s/"$//; s/\\\\/\\/g')"
```

#### 🛠️ Repositories I created recently

{{- range recentRepos 5 }}
- **[{{ .Name }}]({{ .URL }})**{{ with .Description }} - {{ . }}{{ end }}
{{- end }}

#### ⛏️ What I've been working on
{{ range recentContributions 3 }}
- [{{.Repo.Name}}]({{.Repo.URL}})
{{- end }}

#### 📚 Books I'm reading

{{- range rss "https://www.goodreads.com/review/list_rss/117658013?shelf=currently-reading" 3 }}
- **[{{ .Title }}]({{ .URL }})**
{{- end }}

More on my [Goodreads](https://www.goodreads.com/user/show/117658013-osmarpetry).

#### 📄 Latest blog posts

{{- range rss "https://new-hugo-eka.pages.dev/rss.xml" 3 }}
- [{{ .Title }}]({{ .URL }}) ({{ humanize .PublishedAt }})
{{- end }}

#### 🔕 Where I am not

I don't do social media. The noise costs more than the signal — it's like having your best
friends hang out in a bar full of alcoholics and smokers. I read the web through Inoreader
over RSS, and when a site insists, an anonymous account. YouTube is the worst offender of
the lot, but with Untrap I get to pretend I'm in control.

People I've worked with left **[recommendations on LinkedIn](https://www.linkedin.com/in/osmarpetry/details/recommendations/)** — I try to keep at least one per role.

#### 🐖 And finally

They keep telling me software engineering is over. I keep shipping anyway.

![Four panels: two chatbots agreeing with an angry user; someone shipping "hello world"; a designer asking people to stop using their intuition; and an O'Reilly book called "The End of Software Engineering" with a sleeping boar on the cover](cool-image.png)

<!--
  Everything above this line is generated daily by readme-scribe.
  Edit templates/readme.md.tpl, never README.md — your edits there get overwritten.
-->
