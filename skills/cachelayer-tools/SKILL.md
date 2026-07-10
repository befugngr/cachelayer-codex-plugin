---
name: cachelayer-tools
description: >-
  Correct usage of CacheLayer MCP tools. Consult any time the agent is about
  to use CacheLayer's lookup_step, save_step, check_conflict, or run_status tools.
---

# CacheLayer tools

Use one UUID `run_id` per task. Call `lookup_step` before native steps, `check_conflict` before edits, `save_step` after each step. Descriptions must be concise and consistent. On a hit, use the returned result. Do not save secrets from env files.
