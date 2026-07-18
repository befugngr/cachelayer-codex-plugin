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

## Do not

- Lookup/save before every trivial read
- Save secrets
- Vague descriptions — use `read file <path>`, `run command <cmd>`, `search <query>`

One UUID `run_id` per task. Same description on lookup and save.
