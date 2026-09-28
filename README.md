# CacheLayer for Codex

https://cachelayer.org/

CacheLayer Agent OS sits in front of the LLM: it clears the agent’s memory and only gives it what the current step needs. This plugin connects your editor (managed keys, hooks, and MCP).

Personal / BYOK: https://cachelayer.org/integrations/codex

## CLI

### Agent OS (LLM traffic)

Point the model at CacheLayer Agent OS so it clears memory and only gives the agent what the current step needs:

```bash
export OPENAI_BASE_URL="https://api.cachelayer.org/cl-gate/v1"
export OPENAI_API_KEY="$CACHELAYER_KEY"
# Optional Anthropic-shaped clients:
# export ANTHROPIC_BASE_URL="https://api.cachelayer.org/cl-gate"
# export ANTHROPIC_API_KEY="$CACHELAYER_KEY"
```

Hooks and MCP stay on `https://api.cachelayer.org` (unchanged).

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
