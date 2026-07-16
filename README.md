# CacheLayer for Codex

Cache completed agent steps and reuse them in future tasks.

## Prerequisites

- Codex with plugin support
- Git (required for marketplace installation)
  - Windows: `winget install --id Git.Git -e`
  - Or download from https://git-scm.com/
- A CacheLayer connect token (`clct_...`) from https://cachelayer.org/

## Install

```bash
codex plugin marketplace add befugngr/cachelayer-codex-plugin
codex plugin add cachelayer@cachelayer-codex-plugin
```

Restart Codex or start a new session so the bundled skill and MCP tools load.

Manage the plugin:

```bash
codex plugin list
codex plugin remove cachelayer
```

## Authenticate

Set your connect token as `CACHELAYER_KEY`.

PowerShell:

```powershell
$env:CACHELAYER_KEY = "clct_<your-token>"
```

macOS/Linux:

```bash
export CACHELAYER_KEY='clct_<your-token>'
```

The bundled `.mcp.json` uses:

```json
{
  "mcpServers": {
    "cachelayer": {
      "url": "https://api.cachelayer.org/mcp",
      "bearer_token_env_var": "CACHELAYER_KEY"
    }
  }
}
```

Optional `~/.codex/config.toml` configuration:

```toml
[mcp_servers.cachelayer]
url = "https://api.cachelayer.org/mcp"
bearer_token_env_var = "CACHELAYER_KEY"
```

Missing or invalid tokens return MCP `401`. Restart Codex or start a new session after installation or configuration changes.

## Verify

- `codex plugin list` shows `cachelayer`.
- The `cachelayer` MCP server is connected.
- `lookup_step`, `save_step`, `check_conflict`, and `run_status` are available.
- The `cachelayer-tools` skill is loaded.

## Repository layout

```text
.agents/plugins/marketplace.json
.codex-plugin/plugin.json
.mcp.json
skills/cachelayer-tools/SKILL.md
.github/workflows/lint.yml
.gitignore
LICENSE
README.md
```

## Security

- A valid `clct_...` token is required.
- Never save tokens or secrets from `.env` files in cached results.
- CacheLayer is a third-party service unaffiliated with OpenAI or Codex.
