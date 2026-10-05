---
name: claude-prs
description: "list · show [pr] · publish <pr> [approve|request-changes] · discard <pr> · review <pr> · attach <pr>. Drafted PR reviews (pending, unpublished) for PRs requesting my review in rtCamp/wpcomvip. Use for 'my pending reviews', 'show the review for PR 123', 'publish/approve the review', 'discard it', 'review PR X now'."
argument-hint: "list | show [pr] | publish <pr> [approve|request-changes] | discard <pr> | review <pr> | attach <pr>"
---

# claude-prs

The `claude-prs` CLI drafts reviews for PRs where my review is requested (rtCamp, wpcomvip) and keeps them as **pending** GitHub reviews until I publish. A scheduled job polls every 10 minutes; each PR gets its own Claude session in tmux session `jobs`. Act only through the CLI.

`<pr>` is `owner/repo#123`, or just `123` when only one tracked PR has that number.

## First

- If `$CLAUDE_PR` is set, you are inside a PR's review session: only `show` and `publish` for that same PR are allowed.
- If `claude-prs` isn't on PATH, say it isn't installed (mac-dotfiles `install.sh` links it) and stop.

## Actions

| User wants | Do |
|---|---|
| Overview (no args) | `claude-prs list` → table: PR, state, title |
| Unpublished feedback | `claude-prs show [pr]` → summarize per PR: verdict, count of 🔴/🟡/🟢, the 🔴 items in one line each, the GitHub link |
| Publish | **Confirm first** (it posts publicly under my name): which PR and which event: comment (default), approve, or request-changes. Then `claude-prs publish <pr> [approve|request-changes]` and give the PR link |
| Discard | Confirm, then `claude-prs discard <pr>` |
| Review one now | `claude-prs review <owner/repo#n>` (also for older requests the baseline skipped). Say it's running in tmux window `jobs:<repo>-<n>` |
| Open the session | Tell them to run `claude-prs attach <pr>` in a terminal (you can't attach tmux from here) |

## Rules

- Never publish, approve or request changes without an explicit "yes" for that PR in this conversation.
- Don't post comments or reviews with `gh` directly; use `claude-prs` so state stays in sync.
- Editing the drafted comments happens on GitHub (Files changed → pending comments) or by discussing in the PR's session.
