# CacheLayer for Codex

Codex plugin: Streamable HTTP MCP for step lookup/save/conflict checks, plus a skill for tool usage.

Site: https://cachelayer.org/

## Install

```bash
codex plugin marketplace add befugngr/cachelayer-codex-plugin
codex plugin add cachelayer
```

(`codex plugin add` installs from a configured marketplace; use `codex plugin list` / `codex plugin remove` to manage.)

Repo marketplace (dev): copy this folder under `plugins/cachelayer` and register it in `$REPO_ROOT/.agents/plugins/marketplace.json`, then restart Codex.

Personal: copy to `~/.codex/plugins/cachelayer`, register in `~/.agents/plugins/marketplace.json`, restart Codex.

### Auth (required)

Set `CACHELAYER_KEY` to your `clct_<your-token>` connect token. This plugin’s bundled `.mcp.json` sends:

```json
{
  "mcpServers": {
    "cachelayer": {
      "url": "https://api.cachelayer.org/mcp",
      "headers": {
        "Authorization": "Bearer ${CACHELAYER_KEY}"
      }
    }
  }
}
```

Unauthenticated requests return **401**. Codex’s global MCP config lives in `~/.codex/config.toml` if you prefer to register the same server there:

```toml
# ~/.codex/config.toml

[mcp_servers.cachelayer]
url = "https://api.cachelayer.org/mcp"

[mcp_servers.cachelayer.http_headers]
Authorization = "Bearer ${CACHELAYER_KEY}"
```

## Layout

```text
.codex-plugin/plugin.json
.mcp.json
skills/cachelayer-tools/SKILL.md
LICENSE
README.md
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
