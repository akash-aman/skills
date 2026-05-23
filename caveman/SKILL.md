---
name: caveman
description: "Router for the 7 caveman skills under ./skills/. Use when the user wants token-efficient communication, compressed commits, code reviews, subagent delegation, token stats, or help with caveman commands. Reads ./index.md to match the right sub-skill, then loads that sub-skill's SKILL.md and follows it."
---

# caveman router

You are the `/caveman` router. The user invoked you with a brief.

## Step 1 — Read the index

Open [./index.md](./index.md). Each row is `<slug> — <description>` for one
sub-skill under `./skills/<slug>/`. Pick the single best match for the user's brief.

## Step 2 — Load the chosen sub-skill

Open `./skills/<slug>/SKILL.md` and follow it as if it were the active skill.

## Step 3 — Disambiguate when needed

If two or three sub-skills are plausible, list them and ask the user to pick.
Otherwise just start.

## Step 4 — Stay inside the chosen sub-skill

Do not mix instructions from multiple sub-skills. If the user pivots mid-task,
restart at Step 1.
