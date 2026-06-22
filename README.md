# Skills

Curated AI-agent skills as plain Markdown. Works with any tool that can read
files — Claude Code, Copilot, Cursor, or a custom agent.

Each pack has a `SKILL.md` router and an `index.md`; content is symlinked live
from upstream repos under [`repos/`](repos/) (git submodules).

## Packs

| Pack | Invoke | What it does |
|------|--------|--------------|
| [`design/`](design/) | `/design` | Build UI artifacts — landing pages, decks, dashboards, posters, mobile apps. Routes across 109 templates, 155 skills, 150 brand design-systems, and craft rules from [open-design](https://github.com/nexu-io/open-design). |
| [`cleancode/`](cleancode/) | `/cleancode` | Clean Code guidance and refactors per language: JavaScript, TypeScript, Python, PHP, Go. |
| [`caveman/`](caveman/) | `/caveman` | Token-efficient communication, commits, and reviews. |

## Usage

```sh
git clone --recurse-submodules https://github.com/akash-aman/skills.git ~/.skills
ln -s ~/.skills ~/.claude/skills      # Claude Code (or ~/.copilot/skills, etc.)
```

Already cloned? Pull the submodule content:

```sh
git submodule update --init --recursive
```

Then invoke a pack directly, e.g. `/design` or `/cleancode`.

## Contributing

Add a pack as `<pack>/SKILL.md` (router) + `index.md`, symlinking content from a
submodule under `repos/`. Credit the upstream source.
