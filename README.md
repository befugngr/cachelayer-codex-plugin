# CacheLayer Managed Keys for Codex

https://cachelayer.org/

Install the Codex plugin, add your CacheLayer connect token, and restart.

This repo is for managed keys only (`clct_…` as `CACHELAYER_KEY`).  
Personal API keys: https://cachelayer.org/integrations/codex

## CLI

### 1. Add the CacheLayer marketplace and install the plugin

```bash
codex plugin marketplace add befugngr/cachelayer-codex-plugin
codex plugin add cachelayer@cachelayer-codex-plugin
```

### 2. Add your CacheLayer token

Use a connect token from https://cachelayer.org/ (starts with `clct_`).

#### macOS / Linux

```bash
export CACHELAYER_KEY="clct_<your-token>"
```

To persist:

```bash
echo 'export CACHELAYER_KEY="clct_<your-token>"' >> ~/.zshrc
```

#### Windows (PowerShell)

```powershell
[Environment]::SetEnvironmentVariable("CACHELAYER_KEY", "clct_<your-token>", "User")
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

Use a connect token from https://cachelayer.org/ (starts with `clct_`).

#### macOS (Desktop / IDE)

Dock apps do not read `~/.zshrc`. Use:

```bash
launchctl setenv CACHELAYER_KEY 'clct_<your-token>'
```

#### Windows (PowerShell)

```powershell
[Environment]::SetEnvironmentVariable("CACHELAYER_KEY", "clct_<your-token>", "User")
```

### 6. Restart Codex

Fully quit Codex (Cmd+Q on macOS) and reopen.
