---
name: claude-jobs
description: "Manage scheduled Claude jobs (the claude-jobs CLI): list, run now, read results, create, edit, enable/disable or remove jobs that run on a cron schedule as Claude sessions in tmux on the work (cw) or personal (ch) account. Use when the user mentions scheduled/recurring/cron Claude jobs, 'run my <job> now', 'make a job that…every day/weekday at…', job reports, or /claude-jobs."
argument-hint: "[list|run|logs|show|new|edit|enable|disable|remove] [job]"
---

# claude-jobs

Scheduled Claude jobs: each one is a TOML file in `~/.config/claude/jobs/`, and launchd starts due jobs as Claude sessions in tmux. The `claude-jobs` CLI is the only way to act on them. Never edit state files, launchd or tmux directly.

## First

- If `$CLAUDE_JOB` is set, you are inside a scheduled job: only `list`, `show` and `logs` are allowed. Refuse to create, enable, run or remove jobs.
- If `claude-jobs` isn't on PATH, say the scheduler isn't installed (mac-dotfiles `install.sh` links it) and stop.

## Actions

| User wants | Do |
|---|---|
| See jobs (no args) | `claude-jobs list` → short table: name, account, schedule in plain words, next run, on/off, last result |
| Details on one | `claude-jobs show <job>` |
| Run now | `claude-jobs run <job>` → say it's running in tmux window `jobs:<job>`, watch with `claude-jobs attach <job>` (they run it in a terminal; you can't attach), and the report lands in `~/claude-jobs/<job>/<date>/<time>/`. If it printed "skipped …" or "error …", explain why and how to fix it. |
| Last result | `claude-jobs logs <job> 1`, then read `report.md` in that folder if there is one; summarize |
| Create | follow **Create or edit** below |
| Change one | follow **Create or edit** below (edit the file `show` points to) |
| Turn on / off | `claude-jobs enable <job>` / `claude-jobs disable <job>` |
| Delete | ask first, then `claude-jobs remove <job>` (moves it to `jobs/.trash/`) |

## Create or edit

1. **Get the essentials:** what it should do, when, and which account (`work` = cw, `personal` = ch). Ask only for what's missing. For "when", turn plain words into cron and say it back ("weekdays at 10:03").
2. **Read [reference.md](reference.md)** for the keys, defaults and examples.
3. **Write the file:**
   - New jobs go to `~/.config/claude/jobs/<name>.toml`. Use `<name>.local.toml` if the job is client- or work-specific.
   - Kebab-case name. Comment the non-obvious lines.
4. **Validate:** `claude-jobs check <file>`. Fix every ERROR. Mention warnings, especially "cwd not trusted" (tell them to run `cd <cwd> && cw` or `ch` once and choose Trust).
5. **Show** the final file (or the diff, for an edit) and the `check` line with the next run.
6. **New jobs are saved with `enabled = false`.** Offer a test run (`claude-jobs run <name>`). Turn it on only when they say so.

Rules for job files:
- **Report-only by default:** tools limited to reading, plus `Write({outdir}/**)`. A job that posts, comments, approves, pushes or edits outside `{outdir}` only if the user asks for that explicitly. Name the exact extra tools you're adding.
- **No secrets in job files.** For a secret, tell them to store it in the Keychain as `dotfiles.<NAME>`.
- **Prompts are self-contained:** the job session has no memory of this chat. Use `{precheck}`, `{outdir}` and `{date}`, and say where to write output.
- **Skip empty runs:** add a `precheck` when the job only makes sense if there's something to do (e.g. open PRs), so empty runs cost nothing.
- **Off the hour:** pick a minute like `3`, not `0`.

## After changes

Job files live in mac-dotfiles. If the user wants it saved: `git -C ~/mac-dotfiles add -A && git -C ~/mac-dotfiles commit -m "jobs: <what changed>" && git -C ~/mac-dotfiles push`.
