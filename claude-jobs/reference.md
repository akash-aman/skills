# Job file reference

A job is one TOML file in `~/.config/claude/jobs/`. Required: `schedule`, `account`, `prompt`.

## Keys

| Key | Meaning | Default |
|---|---|---|
| `name` | Job name (used in commands, tmux window, report folder) | file name |
| `schedule` | 5-field cron, local time | required |
| `account` | `work` (cw) or `personal` (ch) | required |
| `prompt` | The task. Placeholders below | required |
| `cwd` | Folder the session starts in; must be trusted on that account | `~` |
| `mode` | `fresh` = new session per run; `persistent` = one session that remembers earlier runs | `fresh` |
| `precheck` | Shell command run first; empty output = skip the run (no tokens) | none |
| `allowed_tools` | Tools pre-approved, permission-rule syntax | none |
| `permission_mode` | `auto`, `default`, `acceptEdits`, `plan`, `dontAsk`, `bypassPermissions` | `auto` |
| `model` / `effort` | e.g. `sonnet` / `low` | account default |
| `max_session_pct` | Skip when the account's 5-hour usage is above this | `90` |
| `timeout_min` | Notify if still running after this | `60` |
| `notify` | Notifiers in `~/.config/claude/notify.d/` | `["macos"]` |
| `keep_window` | `always`, `on_error`, `never` | `on_error` |
| `catch_up` | Run once after a slot missed while the Mac was off | `true` |
| `enabled` | On/off | `true` (new jobs: write `false`) |
| `hosts` | Machines it runs on (`hostname -s`), e.g. `["Akashs-MacBook-Pro"]`. Job files are shared between the Mac and the server, so set this to avoid double runs | every machine |

## Placeholders in `prompt` and `allowed_tools`

- `{precheck}`: output of the precheck command
- `{outdir}`: this run's report folder, `~/claude-jobs/<job>/<date>/<time>/`
- `{date}`: today, `YYYY-MM-DD`

## Cron

`minute hour day-of-month month day-of-week`. Day-of-week: 0 or 7 = Sunday, 1 = Monday.

| Plain words | Cron |
|---|---|
| Every day at 20:03 | `3 20 * * *` |
| Weekdays at 10:03 | `3 10 * * 1-5` |
| Every 30 minutes | `*/30 * * * *` |
| Mondays at 9:07 | `7 9 * * 1` |
| 1st of the month at 8:03 | `3 8 1 * *` |
| Hourly, 9–18, weekdays | `5 9-18 * * 1-5` |

## Tool rules

- MCP tool: `mcp__<server>__<tool>`, e.g. `mcp__timeentry__get_timesheet`
- Shell prefix: `Bash(gh pr view *)` (the space before `*` matters)
- Files: `Read`, `Write({outdir}/**)`

## Examples

PR review (report-only, skipped when nothing is waiting):

```toml
name      = "pr-review"
schedule  = "3 10 * * 1-5"
account   = "work"
cwd       = "~/GitHub"
precheck  = "gh search prs --review-requested=@me --state=open --json url,title,number"
prompt    = """
These PRs wait for my review: {precheck}
For each: read it with `gh pr view` and `gh pr diff`, write a review to
{outdir}/<repo>-<number>.md. Do not comment on GitHub.
Reply with one line per PR: number, title, verdict.
"""
allowed_tools = ["Bash(gh pr view *)", "Bash(gh pr diff *)", "Read", "Write({outdir}/**)"]
enabled   = false
```

Daily timesheet summary (read-only MCP tools):

```toml
name      = "timeentry-report"
schedule  = "3 20 * * *"
account   = "work"
cwd       = "~/GitHub/timeentry"
model     = "sonnet"
effort    = "low"
prompt    = """
Build today's ({date}) time report. READ ONLY: never add or change entries.
Use get_timesheet, github_my_prs, slack_my_activity. Write {outdir}/report.md.
Reply in 3 lines: hours logged, hours suggested, gap to 8h.
"""
allowed_tools = ["mcp__timeentry__get_timesheet", "mcp__timeentry__github_my_prs",
                 "mcp__timeentry__slack_my_activity", "Write({outdir}/**)"]
enabled   = false
```

Persistent weekly notes (remembers earlier weeks):

```toml
name      = "weekly-notes"
schedule  = "7 17 * * 5"
account   = "personal"
mode      = "persistent"
prompt    = "It's Friday {date}. Compare this week to the earlier weeks we discussed and write {outdir}/notes.md."
allowed_tools = ["Read", "Write({outdir}/**)"]
enabled   = false
```
