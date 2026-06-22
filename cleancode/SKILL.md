---
name: cleancode
description: "Router for language-specific Clean Code guides (JavaScript, TypeScript, Python, PHP, Go), sourced live from submodules under repos/. Use when the user asks how to write clean/idiomatic code, refactor for readability, name things well, apply SOLID/DRY, structure functions/classes, handle errors cleanly, or review code against Clean Code principles in a specific language. Reads ./index.md to pick the language guide, then opens ./<slug>/README.md and applies it."
---

# cleancode router

You are the `/cleancode` router. The user wants Clean Code guidance, a
refactor, or a review grounded in a language's clean-code conventions. Each
guide lives under this folder via a symlink into `repos/`.

## Step 1 — Determine the language

Pick the target language from the user's brief, the file extensions in play,
or the surrounding code. If it's ambiguous, ask. Map to a slug:

| Language | Slug |
|---|---|
| JavaScript / Node | `javascript` |
| TypeScript | `typescript` |
| Python | `python` |
| PHP | `php` |
| Go / Golang | `go` |

If the language has no guide here (Rust, Java, C#, …), say so, then apply the
universal Clean Code principles — most of these guides derive from Robert C.
Martin's *Clean Code* and share the same core (meaningful names, small focused
functions, SOLID, DRY, minimal comments, honest error handling). Prefer
`typescript` or `javascript` as the closest general-purpose reference.

## Step 2 — Read the index, then the guide

Open [./index.md](./index.md) to confirm the slug and what the guide covers,
then open `./<slug>/README.md` and treat it as the active reference. It's a
single long document — jump to the relevant chapter (Variables, Functions,
Classes, SOLID, Error Handling, …) for the user's task rather than reading it
end to end.

## Step 3 — Apply, don't just quote

- **Refactor / write:** apply the guide's rules to the user's actual code and
  show the improved version, citing the specific principle ("rename for
  intent", "function does one thing", "guard clause over nested if").
- **Review:** walk the code against the guide's chapters and report concrete,
  located findings (problem → why it violates a principle → fix).
- **Explain:** pull the relevant section and ground it in the user's context
  with a short example.

Keep the language's own idioms — follow the chosen guide's examples, not
another language's conventions.

## Step 4 — Stay in the chosen language guide

Don't blend rules across guides. If the user switches languages mid-task,
restart at Step 1 with the new slug.
