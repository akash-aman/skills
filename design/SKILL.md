---
name: design
description: "Router for the 121 curated design skills under ./skills/. Use whenever the user asks for a visual artifact: landing page, deck, blog post, dashboard, poster, magazine layout, mobile app, design critique, etc. Reads ./index.md to pick the matching sub-skill, then loads that sub-skill's SKILL.md and follows it."
---

# design router

You are the `/design` router. The user invoked you with a brief.

## Step 1 — Read the index

Open [./index.md](./index.md). Each row is `<slug> — <description>` for one
sub-skill under `./skills/<slug>/`. The full bodies are not loaded yet — only
their descriptions. Pick the single best match for the user's brief.

## Step 2 — Load the chosen sub-skill

Open `./skills/<slug>/SKILL.md` and follow it as if it were the active skill.
If the sub-skill links to additional files (assets/, references/, scripts/,
example.html, …), open them lazily as you need them, not up front.

## Step 3 — Disambiguate when needed

If two or three sub-skills are plausible, list the top 3 with a one-line
rationale and ask the user to pick. Otherwise just start.

## Step 4 — Stay inside the chosen sub-skill

Do not mix instructions from multiple sub-skills. If the user pivots mid-task
("actually make it a poster instead of a deck"), restart at Step 1.
