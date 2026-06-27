---
description: Weave a stream note into the FH folio graph — resolve and insert cross-refs, update neighbors to link back, run an orphan check, and do a final voice pass.
argument-hint: "[stream date YYYY-MM-DD, or blank for the most recent]"
---

# /weave-stream

You are running inside the **Flux Harmonic repo**, so this repo's folio MCP (`folio_*`, scoped to `folio/` via `FOLIO_ROOT`) is mounted. That is the whole point of this skill: only a session with the FH folio mounted can correctly link a note into the FH knowledge graph. The Ops session that *generated* the stream note could not resolve `[[...]]` against this graph or update its neighbors. You can. Do that job.

This skill is stage 3 ("Weave") of the cadence documented in the Ops workspace (`procedures/flux-harmonic-stream-cadence`). The note already has its title, News, and The Plan filled in. Your job is linking and polish, not rewriting the plan.

## Target note

- If `$ARGUMENTS` names a date, the target is `notes/streams/$ARGUMENTS`.
- Otherwise, target the most recent note under `notes/streams/` (latest date).

Read it first with `folio_note-read`. If it doesn't exist, stop and say so.

## What to do

### 1. Learn the graph
- `folio_notes` to list every note in this folio. Note the roadmap (`notes/topics/roadmap`), prior stream notes, and any `topics/` or `projects/` notes.
- Read `notes/topics/writing-voice` (the FH voice rules) and skim this repo's `CLAUDE.md` → "Stream notes" + "Writing voice" so your edits match the conventions.

### 2. Insert cross-refs into the stream note
Walk the note's prose (News, The Plan, Links) and wherever it names a concept that **already has a note in this folio**, link it with `[[...]]` wiki-link syntax:
- Roadmap projects (Sigil, Cinder Cadence, Motif, Easel, Press, Live Crafter, Enclave, Apiary, blackICE, etc.) → link to their note if one exists, otherwise to the relevant roadmap section heading.
- The prior stream → `[[notes/streams/<prev-date>]]` when the note refers back to it.
- Any topic note that covers something the stream discusses.

Rules:
- **Only link to notes that actually exist.** Verify against the `folio_notes` listing. Do NOT fabricate links to notes that aren't there. If the note *should* exist but doesn't, list it under "Suggested new notes" in your report instead of linking a dead target.
- Use wiki-links, never backticks or markdown links (those don't create tracked backlinks).
- Don't over-link: link the first meaningful mention of a thing, not every occurrence.
- Edit via `folio_note-patch` / `folio_note-edit`, never bare Edit/Write (keeps the index + backlinks in sync).

### 3. Update neighbors to link back (kill orphans)
A new note that only links outward is still weakly connected. For the most important neighbors, add a backlink *to this stream* from their note:
- The **roadmap**: if the stream advanced a roadmap item, add a link to this stream note next to that item (e.g. a "covered live in [[notes/streams/<date>]]" reference).
- The **prior stream's "Next Time"** section: if this stream picked up one of its follow-ups, mark it done with a link to this note.
- Any **project note** whose work this stream advanced.
Keep backlink edits light: one wiki-link in a sensible place, not a paragraph.

### 4. Orphan check
Run `folio_status`. Confirm the stream note is no longer orphaned and you haven't created new orphans. If `folio_status` flags anything you touched, fix it.

### 5. Final voice pass
Re-read the note against `notes/topics/writing-voice`:
- **No em-dashes (—).** Replace any with colons, commas, parentheses, semicolons, or a new sentence.
- **Keep genuine exclamation points**, one at a time, never stacked. Don't strip them.
- Specifics over vague claims; plain words (no "leverage"/"utilize"/"empower"); first person; contractions natural.
Fix anything that reads like a content team or an AI wrote it.

## Report back

When done, summarize:
- Which cross-refs you inserted (and into which sections).
- Which neighbors you updated to link back.
- `folio_status` result (orphan-free?).
- Any voice fixes you made.
- **Suggested new notes**: concepts the stream referenced that deserve a note but don't have one yet (don't create them unless asked).

Do NOT commit. Surface the changes for review; David decides when the FH repo gets committed and pushed.
