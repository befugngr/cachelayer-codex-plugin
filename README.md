# CacheLayer for Codex

This plugin connects Codex to CacheLayer step caching over Streamable HTTP MCP, with an optional PreToolUse hook on non-Windows platforms.

Website: [https://cachelayer.org/](https://cachelayer.org/)

## Getting started

1. Install from this repo / your marketplace (`/plugins` in the Codex CLI).
2. Confirm MCP points at `https://api.cachelayer.org/mcp/http`.
3. Restart Codex.

Example MCP config (also in `.mcp.json`):

```json
{
  "mcpServers": {
    "CacheLayer": {
      "url": "https://api.cachelayer.org/mcp/http"
    }
  }
}
```

When auth ships, set `CACHELAYER_CONNECT_TOKEN` for the hook and add Authorization on the MCP entry without changing the URL.

## Features

- MCP tools over Streamable HTTP: `lookup_step`, `save_step`, `check_conflict`, `run_status`
- PreToolUse hook (fail-open, 2s timeout) on macOS/Linux
- Skill for correct tool argument patterns

## Notes and limitations

- **Windows:** Codex hooks are not Windows-compatible. Windows users get MCP tools + skills only, not hook enforcement.
- Hook is fail-open if CacheLayer is down or slow.
- A CacheLayer account/subscription is required once auth is enabled.

## Compliance

1. **No impersonation.** This plugin is CacheLayer only. It does not present itself as OpenAI, Codex, or any other company or brand.
2. **No malicious code.** This plugin does not steal user data, modify the system without permission, or bundle malware.
3. **Transparent requirement.** A third-party CacheLayer account/subscription is required to use this plugin.

## Contact

[https://cachelayer.org/](https://cachelayer.org/)

## Legal

Licensed under the Apache License 2.0. See `LICENSE` if present in this repo, or https://www.apache.org/licenses/LICENSE-2.0
