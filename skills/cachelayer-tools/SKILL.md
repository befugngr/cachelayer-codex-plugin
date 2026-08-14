---
name: cachelayer-tools
description: >-
  Optional CacheLayer MCP tools for Codex. Use for expensive reuse, conflict
  checks, and resume — not before every step.
---

# CacheLayer tools

Set `CACHELAYER_KEY` to your `clct_<token>`. Codex has no PreToolUse hooks; use MCP **sparingly**.

## When to call

- Expensive/repeated steps: `lookup_step` then on miss do work + `save_step`
- Risky writes: `check_conflict`
- Resume: `run_status`

## Local coding-agent tools

- `verify_edit` — once after a coherent code edit; typecheck → lint → affected tests.
- `run_affected_tests` — a bounded impacted subset, not the full suite.
- `debug_failure` — **once** after a failed test/command. Pass its traceback/output, use the one-shot rubric and `next`, and do not launch a second debug loop.

Never call local tools on every Read/Grep, markdown edit, or passing test.

## Do not

- Lookup/save before every trivial read
- Save secrets
- Vague descriptions — use `read file <path>`, `run command <cmd>`, `search <query>`

One UUID `run_id` per task. Same description on lookup and save.
