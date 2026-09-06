### Hei 👋

I'm [Osmar](https://osmarpetry.dev) — Luxembourgish-Brazilian, based in Luxembourg,
building and operating full-stack products in TypeScript and Python for AI resilient products.

I speak **Portuguese** and **English**, I'm learning **French**, and the plan after
that is **Luxembourgish** and **German**. Ask me anything in the first two; be
patient with the third.

My CV also lives in DNS, if you have a terminal:

```bash
dig +short TXT cv.osmarpetry.dev
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

{{- range goodReadsCurrentlyReading 3 }}
- **[{{ .Book.Title }}]({{ .Book.Link }})** by _{{ range .Book.Authors }}{{ .Name }}{{ end }}_
{{- end }}

More on my [Goodreads](https://www.goodreads.com/user/show/YOUR_GOODREADS_ID).

#### 📄 Latest blog posts

{{- range rss "https://osmarpetry.dev/rss.xml" 3 }}
- [{{ .Title }}]({{ .URL }}) ({{ humanize .PublishedAt }})
{{- end }}

#### 🐖 And finally

They keep telling me software engineering is over. I keep shipping anyway.

<!--
  Everything above this line is generated daily by readme-scribe.
  Edit templates/readme.md.tpl, never README.md — your edits there get overwritten.
-->
