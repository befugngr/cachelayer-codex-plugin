# CacheLayer for Codex

Codex plugin: Streamable HTTP MCP for step lookup/save/conflict checks, plus a skill for tool usage.

Site: https://cachelayer.org/

## Install

Repo marketplace: copy this folder under `plugins/cachelayer` and register it in `.agents/plugins/marketplace.json`, then restart Codex.

Personal: copy to `~/.codex/plugins/cachelayer`, register in `~/.agents/plugins/marketplace.json`, restart Codex.

Or open `codex /plugins` after the marketplace entry exists.

MCP URL (in `.mcp.json`): `https://api.cachelayer.org/mcp/http`

When auth ships, add Authorization on the MCP entry without changing the URL.

## Layout

```text
.codex-plugin/plugin.json
.mcp.json
skills/cachelayer-tools/SKILL.md
```

## Tools

- `lookup_step` / `save_step` / `check_conflict` / `run_status` over Streamable HTTP

Codex has no Claude-style PreToolUse hooks. Behavior is MCP tools + skill guidance (and optional `config.toml` execution policy on your side).

## Limits

- Keep descriptions short so lookups match saves
- Do not save secrets from env files

## Compliance

1. No impersonation. CacheLayer only; not OpenAI or Codex.
2. No malicious code.
3. A CacheLayer account/subscription is required.

## Contact

https://cachelayer.org/

## Legal

Apache License 2.0. See `LICENSE`.
