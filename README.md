# CacheLayer for Codex

Codex plugin: Streamable HTTP MCP for step lookup/save/conflict checks, plus a skill for tool usage.

Site: https://cachelayer.org/

## Install

Repo marketplace: copy this folder under `plugins/cachelayer` and register it in `$REPO_ROOT/.agents/plugins/marketplace.json`, then restart Codex.

Personal: copy to `~/.codex/plugins/cachelayer`, register in `~/.agents/plugins/marketplace.json`, restart Codex.

Or open `codex /plugins` after the marketplace entry exists.

### Auth (required)

This plugin’s bundled `.mcp.json` (inside the plugin directory — not `~/.codex/config.toml`) must send a connect token:

```json
{
  "mcpServers": {
    "CacheLayer": {
      "url": "https://api.cachelayer.org/mcp/http",
      "headers": {
        "Authorization": "Bearer YOUR_clct_TOKEN"
      }
    }
  }
}
```

Unauthenticated requests return **401**. Codex’s global MCP config lives in `~/.codex/config.toml` if you prefer to register the same server there instead of via the plugin bundle.

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
