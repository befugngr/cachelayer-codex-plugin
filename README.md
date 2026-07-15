# CacheLayer for Codex

Streamable HTTP MCP for step lookup, save, and conflict checks, plus a skill for tool usage.

Site: https://cachelayer.org/

## Prerequisites

- [Codex](https://developers.openai.com/codex/) CLI / app with plugin support
- A **CacheLayer account** and connect token (`clct_…`) — required; MCP returns **401** without it

## 1. Get a connect token

1. Sign up or sign in at https://cachelayer.org/
2. Create a connect token from your account (API: `POST /user/connect-token` while logged in)
3. Copy the full value once — it looks like `clct_<your-token>`

You will set this as `CACHELAYER_KEY` below.

## 2. Install

```bash
codex plugin marketplace add befugngr/cachelayer-codex-plugin
codex plugin add cachelayer
```

Use `codex plugin list` / `codex plugin remove` to manage installs.

Dev / personal install: copy this folder under `plugins/cachelayer`, register it in `.agents/plugins/marketplace.json` (repo or `~`), then restart Codex.

## 3. Auth (required)

Export your connect token:

```bash
export CACHELAYER_KEY='clct_<your-token>'
```

The bundled `.mcp.json` sends:

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

Optional: register the same server in `~/.codex/config.toml` instead of (or in addition to) the plugin bundle:

```toml
# ~/.codex/config.toml

[mcp_servers.cachelayer]
url = "https://api.cachelayer.org/mcp"

[mcp_servers.cachelayer.http_headers]
Authorization = "Bearer ${CACHELAYER_KEY}"
```

Missing or invalid token → MCP **401**.

## 4. Verify

- MCP server `cachelayer` is connected
- Tools available: `lookup_step`, `save_step`, `check_conflict`, `run_status`
- Skill `cachelayer-tools` is loaded
- A test `lookup_step` does not return unauthorized / 401

## Tools

- `lookup_step` / `save_step` / `check_conflict` / `run_status` over Streamable HTTP

Codex has no Claude-style PreToolUse hooks in this plugin. Behavior is MCP tools + skill guidance (plus optional `config.toml` execution policy on your side).

One UUID `run_id` per task. Keep descriptors short and consistent (e.g. `read file src/auth.js`).

## Layout

```text
.codex-plugin/plugin.json
.mcp.json
skills/cachelayer-tools/SKILL.md
LICENSE
README.md
```

## Limits

- Keep descriptions short so lookups match saves
- Do not save secrets from env files
- Write/mutating steps are not replayed from cache

## Compliance

1. No impersonation. CacheLayer only; not OpenAI or Codex.
2. No malicious code.
3. A CacheLayer account/subscription is required.

## Contact

https://cachelayer.org/

## Legal

Apache License 2.0. See `LICENSE`.
