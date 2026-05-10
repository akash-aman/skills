# Skills

A curated collection of **AI agent skills** sourced from across the open-source ecosystem, packaged so they can be plugged into **any AI tool or coding assistant** — Claude Code, GitHub Copilot, Cursor, Windsurf, Continue, Aider, or your own custom agent.

## What is a "skill"?

A *skill* is a self-contained bundle of domain knowledge — usually a `SKILL.md` plus supporting templates, examples, and assets — that teaches an LLM **how** to do a specific task well (build a pitch deck, write a runbook, design a dashboard, generate a knowledge graph, critique a layout, etc.).

Instead of re-prompting from scratch every time, you point your agent at a skill and it inherits the conventions, structure, and taste baked into it.

## What's in this repo?

- **[design/](design/)** — 120+ design skills covering decks, landing pages, blog posts, dashboards, magazines, mobile apps, posters, editorial layouts, and more. Includes a router (`design/SKILL.md`) that picks the right sub-skill based on the artifact you want.
- More skill packs will be added over time.

## Why a single repo?

- **Tool-agnostic** — plain Markdown + assets, no proprietary format. Works wherever an agent can read files.
- **Composable** — drop the whole folder into `~/.claude/skills/`, `~/.copilot/skills/`, a Cursor rules folder, or reference it from any custom agent.
- **Curated, not exhaustive** — every skill here has been vetted for quality, clarity, and reusability.
- **Open source** — sources are credited; improvements flow back upstream where possible.

## Usage

Clone or symlink this repo into the location your AI tool expects skills to live, for example:

```sh
git clone https://github.com/akash-aman/skills.git ~/.skills

# Claude Code
ln -s ~/.skills ~/.claude/skills

# GitHub Copilot
ln -s ~/.skills ~/.copilot/skills
```

Then reference a skill from your agent's instructions or invoke it directly (e.g. `/graphify`, `/design`).

## Contributing

Found a great open-source skill? Open a PR with:
1. The skill folder under the right pack (or propose a new pack).
2. A `SKILL.md` with a clear `description` so agents know when to invoke it.
3. Attribution to the original source.
