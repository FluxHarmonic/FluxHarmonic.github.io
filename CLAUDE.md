# Flux Harmonic — Creative Workspace

This repo is both the **fluxharmonic.com website** (built with Press) and the
**Flux Harmonic working space** (a folio knowledge graph under `folio/`). The
two are meant to converge: the website becomes a rendered view of the folio.

Flux Harmonic is David Wilson's creative label for his projects, and a community
for people who build their own tools, their own way, for their own use cases. The
work is **building his own programming language, tools, games, and music, in the
open**, with a throughline of creating authentically in the age of AI. It all
starts with **Sigil**, his custom Scheme implementation and the foundation
everything else sits on: games like Cinder Cadence, the Motif music engine, and
creative tools (Easel, Press, Live Crafter, this site). It runs alongside
**System Crafters**, now the legacy Emacs and Guix channel.

## Public by default — the core principle

**Everything in this workspace is public. That is the whole point.** Treat every
file under `folio/` (and everything else in the repo) as already published.

- Never put anything here you wouldn't put on the public site: no credentials, no
  private personal reminders, no half-formed thoughts about people, no internal
  business numbers you don't want public.
- There is no `draft`/`private` convention to hide behind. The discipline is at
  the door: if it's private, it doesn't go in the FH folder at all.

When in doubt about whether something belongs here, ask David.

## The folio workspace

`folio/` is a folio knowledge graph with its own MCP server (configured in this
repo's `.mcp.json`, scoped via `FOLIO_ROOT`). It is its **own instance**,
independent of any other folio you run elsewhere.

Structure:

```
folio/
├── notes/
│   ├── streams/   # one note per stream — the running log of each session
│   └── topics/    # atomic knowledge notes (games, music, Sigil techniques)
├── projects/      # ongoing projects (games, tools, albums)
└── archive/
```

Conventions:

- **Use the folio MCP tools** (`folio_note-create`, `folio_note-edit`,
  `folio_note-patch`, `folio_task-*`, etc.) to edit folio notes, not bare
  `Edit`/`Write`. The MCP keeps the index and backlinks in sync.
- **Wiki-links** between folio notes: `[[notes/streams/2026-06-26]]`.
  Backticks and markdown links don't create tracked backlinks.
- Every note that should render as a page needs a **`title:`** field in its
  frontmatter so Press renders the page title correctly.

## Stream notes

Each stream gets a note in `folio/notes/streams/<date>.md`. It is a public
page and a live working doc. Standard structure:

```markdown
---
title: "<Stream Title>"
tags:
  - stream
date: YYYY-MM-DD
---

# <Stream Title>

<One or two sentences: what this stream is about.>

## News
<Things to mention up top before starting on the work.>

## The Plan
<Bullets of what we'll do this session.>

## Progress Log
<!-- Populated by Claude during and after the stream. One bullet per thing that
got accomplished, each followed by the commit(s) that comprise it.
Format:  - What got done ([`a1b2c3d`](https://codeberg.org/OWNER/REPO/commit/a1b2c3d), …) -->

## Next Time
<Follow-ups and plans for the next stream, captured as they come up.>

## Links
<Anything interesting we hit or discussed that doesn't fit above.>
```

**Claude keeps the Progress Log and notes updated live.** As commits land during the stream
(across whatever repos: cinder-cadence, sigil, this site, etc.), add one bullet
per accomplishment with the commit(s) that make it up, each linked to the repo
it landed in. Tidy into clean accomplishment-level entries at the end.

## Writing voice (anything public)

All public-facing copy (stream descriptions, site pages, social posts) uses
David's voice. See [[notes/topics/writing-voice]] for the FH voice note.

The load-bearing rules:

- **No em-dashes (—). Ever.** Use colons, semicolons, commas, parentheses, or a
  period and a new sentence. Em-dashes are the strongest AI-writing tell.
- **Keep David's exclamation points.** He uses them at genuine moments of
  enthusiasm, one at a time. Don't strip them and don't stack them.
- **Specifics over vague claims.** If you can't be specific, cut the claim.
- Conversational but technical, honest, not salesy. First person ("I'll show
  you…", "we can see…", "you might be wondering…"). Contractions are natural.
- No corporate-speak ("leverage", "utilize", "empower", "unlock the power of").

## Building the site

Built with **Press** (Sigil-native static site generator), `sigil: ^0.17`.

```
sigil deps install
sigil run -- build     # build the site into public/
sigil run -- serve     # dev server with live reload
```

The current site is a single SXML landing page (`site/index.sxml`). Rendering the
folio into site pages ("website = rendered folio") is a planned build, not yet
wired up. `content/*.org` is old Org Mode content; ignore it.

## Repo notes

- This is a public repo (github.com/FluxHarmonic/fluxharmonic.github.io). Keep it
  clean: no personal absolute paths or machine-specific config committed. (The
  current `.mcp.json` uses absolute paths for local convenience and should be made
  portable before it's committed.)
- Strip AI-related references from commit messages (no "Generated with…" /
  "Co-Authored-By" footers).
