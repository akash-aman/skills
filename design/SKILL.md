---
name: design
description: "Router for the open-design system — 109 design-templates (artifact shapes), 155 functional skills, 150 brand design-systems, and 11 craft rulebooks, all sourced live from the open-design submodule. Use whenever the user wants a visual/UI artifact: landing page, deck, dashboard, blog post, poster, magazine, mobile app, email, pricing page, docs page, design critique, etc. Reads ./index.md, picks the matching template + design-system + craft sections, then loads and follows them."
---

# design router

You are the `/design` router. The user gave you a brief for a visual artifact.
Everything you route to lives under this folder via symlinks into the
`open-design` submodule (`repos/open-design/`), organized as **four axes**:

| Axis | Folder | What it gives you |
|---|---|---|
| **Shape** | `design-templates/` | The artifact's structure — landing page, deck, dashboard, poster, email, mobile app… (109 entries) |
| **Capability** | `skills/` | Functional work invoked mid-task — briefs, critiques, audits, ad/image/video asset work… (155 entries) |
| **Look** | `design-systems/` | A brand's visual language as a 9-section `DESIGN.md` + tokens — stripe, linear-app, apple, notion… (150 brands) |
| **Rules** | `craft/` | Universal craft knowledge layered on top — typography, color, accessibility, anti-AI-slop… (11 rulebooks) |

The mental model: **one template (shape) + one design-system (look) + the
relevant craft sections (rules)** produce a great UI. Functional skills are
pulled in as the task needs them.

## Step 1 — Read the index

Open [./index.md](./index.md). It lists every entry across all four axes with a
one-line description. Only descriptions are loaded so far, not the bodies.

## Step 2 — Classify the brief and pick entries

1. **Shape (required for most briefs).** Pick the single best `design-templates/<slug>`
   for the artifact the user wants. If the brief is purely *work on existing
   material* (critique, brief-writing, fidelity audit, asset generation) with no
   new rendered artifact, pick a `skills/<slug>` instead and skip to Step 4.
2. **Look.** If the user named a brand or vibe ("make it feel like Linear",
   "Stripe-style", "brutalist"), pick the matching `design-systems/<slug>`. If
   they didn't, suggest 2–3 fitting systems from the index and ask, or default to
   `design-systems/default/` and say so.
3. **Rules.** Note the craft sections the template's own frontmatter requests
   (`od.craft.requires`) plus any obviously relevant ones (a form → `form-validation`,
   anything interactive → `accessibility-baseline` + `state-coverage`, marketing →
   `anti-ai-slop` + `laws-of-ux`).

## Step 3 — Load the chosen entries, in order

1. Open the chosen `design-templates/<slug>/SKILL.md` (or `skills/<slug>/SKILL.md`)
   and treat it as the active skill. Follow its frontmatter contract (inputs,
   outputs, preview entry) and body exactly.
2. Open the chosen `design-systems/<slug>/DESIGN.md` and honour its color,
   typography, layout, and component tokens. Prefer its `tokens.css` /
   `design-tokens.json` when the template wires them in.
3. Open each required `craft/<section>.md` and apply its rules as you build.
   These override generic habits (e.g. ALL-CAPS always needs ≥0.06em tracking).

Open side files (`assets/`, `references/`, `example.html`, scripts) lazily, only
when the active skill points at them — not up front.

## Step 4 — Disambiguate when needed

If two or three templates/skills are plausible, list the top 3 with a one-line
rationale and ask the user to pick. Don't silently guess on the artifact shape.

## Step 5 — Stay inside the chosen entry

Do not blend instructions from multiple templates. The design-system and craft
files are *layers* on the one chosen template — that composition is expected; a
second template is not. If the user pivots the artifact mid-task ("make it a
poster instead of a deck"), restart at Step 1.

## Notes

- These folders are **symlinks into `repos/open-design/`** — they always reflect
  the current submodule checkout. To pull newer skills, update the submodule;
  `index.md` is regenerated from it (see the generator note at the repo root).
- `prompt-templates/image/` and `prompt-templates/video/` hold prompt scaffolds
  for generative image/video work referenced by some skills.
