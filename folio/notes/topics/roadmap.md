---
title: "What We're Building"
tags:
  - roadmap
---

# What We're Building

Flux Harmonic is where I build my own programming language, tools, games, and
music, in the open. Everything here sits on Sigil, my own Scheme implementation,
and every project doubles as a way to push the language forward. The list is long
on purpose: I've always had more ideas than I could build alone, and the whole
point now is to see how far I can get with my own ecosystem of tools and AI in
the loop.

Here's what's on the table. Some of it exists today, some is barely a sketch.
We'll build it in public, one stream at a time.

## The foundation: Sigil

- Push Sigil toward a **1.0 release this year**, locking the core toolchain into
  a stable contract you can build on.
- Make **interactive development** a joy: fast feedback and a real REPL-driven
  flow, the kind of live experience Lisp is supposed to have.
- Work out a genuine workflow for **live-coding Sigil by hand with AI in the
  loop**, where the human and the agent each do what they're best at.

## The gallery: games & music

- **Cinder Cadence**: a music-reactive bullet-hell where every beat is a bullet.
- **blackICE**: a cyberpunk Sokoban that runs right in your browser, built on
  Sigil's WASM bridges.
- **Revive the game-jam games**: I have a pile of old Lisp Game Jam entries
  written in Mesche and Guile Hoot. I want to port them to Sigil and bring them
  back to life!
- **A new game engine**: a reusable library to power all of these. I'm planning
  to revive Substratic for it.
- **Motif**: my engine for writing music as code, and eventually the sequencer UI
  I keep wanting to build.

## The tools: how it all gets made

Most of these run this very channel.

- **Easel**: generate images and art with Sigil code. It made the thumbnail for
  this stream.
- **Montage**: automated video editing for the channel, built on MLT with Whisper
  transcription.
- **Press**: a static site generator written in Sigil. This site is built with it.
- **This site, as a rendered folio**: flesh out fluxharmonic.com with Press so
  this folio workspace renders straight into the website. The notes, stream logs,
  and roadmap I write become the public pages, with no separate CMS in between.
- **Live Crafter**: the Lisp automation that runs my live streams (chat overlay,
  scenes, music, all of it).
- **A multi-agent stream workflow**: spawning several worker agents during a
  stream, each pushing a different storyline forward while I coordinate.

## The substrate: agents & communication

- **Enclave**: a self-hosted chat substrate for trusted groups, and the IRC
  server that powers it.
- **Apiary**: ephemeral agent identities that connect to a shared coordination
  room and work together, doing what it was always meant to do.

## The through-line

None of these are side quests. Every game and every tool is a forcing function
that hardens Sigil and drags it closer to 1.0: the games prove the runtime, the
tools prove the libraries, and the streams prove the workflow. If you're someone
who wants to build your own tools your own way, that's exactly what this is, and
you're welcome to build alongside me.
