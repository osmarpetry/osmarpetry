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

The record stores the line breaks and the ANSI colors as escapes, so plain
`dig +short` hands you one long single-quoted line. The `sed` glues the 255-byte
chunks back together and unescapes them; `printf %b` turns `\n` and `\033[..m` into
real newlines and real color. Sections: `experience.`, `projects.`, `contact.`

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

{{- range rss "https://osmarpetry.dev/rss.xml" 3 }}
- [{{ .Title }}]({{ .URL }}) ({{ humanize .PublishedAt }})
{{- end }}

#### 🐖 And finally

They keep telling me software engineering is over. I keep shipping anyway.

![Four panels: two chatbots agreeing with an angry user; someone shipping "hello world"; a designer asking people to stop using their intuition; and an O'Reilly book called "The End of Software Engineering" with a sleeping boar on the cover](cool-image.png)

<!--
  Everything above this line is generated daily by readme-scribe.
  Edit templates/readme.md.tpl, never README.md — your edits there get overwritten.
-->
