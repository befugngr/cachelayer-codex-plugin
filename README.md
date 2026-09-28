# CacheLayer for Codex

https://cachelayer.org/

CacheLayer controls the agent through silent tool hooks and MCP — not by proxying the LLM. Hooks look up/save steps and put only the needed cached result back on a hit.

Personal / BYOK: https://cachelayer.org/integrations/codex

## CLI

### How CacheLayer controls the agent

The plugin does **not** attach your editor to the LLM proxy. Silent hooks sit on tool use:

1. **Before** allowlisted read/search tools → lookup a prior safe step result
2. On **hit** → skip the native tool and put only that cached result back into the agent
3. **After** the tool → save the result for the next step
4. Optional MCP tools (`lookup_step`, `save_step`, `check_conflict`, `run_status`) for explicit control

Set `CACHELAYER_KEY` (`cl_…` or legacy `clct_…`). For per-flow Agent OS metrics in the console:

```bash
export CACHELAYER_FLOW_ID="<flow_id_from_console>"
```

Hooks and MCP stay on `https://api.cachelayer.org`.


## 1. Add the CacheLayer marketplace and install the plugin

```bash
codex plugin marketplace add befugngr/cachelayer-codex-plugin
codex plugin add cachelayer@cachelayer-codex-plugin
```

### 2. Add your CacheLayer token

Use a connect token from https://cachelayer.org/ (`cl_…` or legacy `clct_…`).

#### macOS / Linux

```bash
export CACHELAYER_KEY="<your-token>"
# Optional when Codex is launched outside the repository:
export CACHELAYER_WORKSPACE_ROOT="/absolute/path/to/repository"
```

To persist:

```bash
echo 'export CACHELAYER_KEY="<your-token>"' >> ~/.zshrc
```

#### Windows (PowerShell)

```powershell
[Environment]::SetEnvironmentVariable("CACHELAYER_KEY", "<your-token>", "User")
```

### 3. Restart Codex

Fully quit and reopen Codex (open a new terminal for CLI).

## Desktop / IDE

### 1. Open Plugins in the Codex sidebar

### 2. Click Add, then Add marketplace

### 3. Enter the marketplace source

```text
befugngr/cachelayer-codex-plugin
```

### 4. Install the CacheLayer plugin

### 5. Add your CacheLayer token

Use a connect token from https://cachelayer.org/ (`cl_…` or legacy `clct_…`).

#### macOS (Desktop / IDE)

Dock apps do not read `~/.zshrc`. Use:

```bash
launchctl setenv CACHELAYER_KEY '<your-token>'
```

#### Windows (PowerShell)

```powershell
[Environment]::SetEnvironmentVariable("CACHELAYER_KEY", "<your-token>", "User")
```

### 6. Restart Codex

Fully quit Codex (Cmd+Q on macOS) and reopen.
