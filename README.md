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

## Optional local loop-cutters

The plugin also bundles a local, Python 3 stdlib-only MCP server alongside the managed-keys cache MCP. It provides `verify_edit` (CRITIC), `run_affected_tests` (TIA), and `debug_failure` for compact one-call feedback in the current workspace. These tools are optional: missing project analyzers degrade gracefully with install guidance, while the remote `cachelayer` server and `CACHELAYER_KEY` flow remain unchanged.

For richer selection and diagnosis, projects may optionally install `pytest-testmon`/`pytest-cov`, TypeScript/ESLint/Jest, or Java tooling such as JaCoCo, Ekstazi, Joern, and Flacoco.

`run_affected_tests` picks the strongest selection the project supports, and says which one it used:

| Project state | Selection |
| --- | --- |
| `pytest-testmon` installed | testmon's own impacted set |
| `.coverage` recorded with `pytest --cov --cov-context=test` | the exact tests that executed the changed lines |
| neither | changed modules plus their importers, mapped to matching test files |
| Jest | `jest --findRelatedTests` |
| Maven with a JaCoCo report | test classes referencing changed classes the suite covers, and a list of changed classes with no coverage |
| Maven or Gradle without a report | changed classes mapped to matching test classes |

When nothing maps, it runs nothing and says so rather than falling back to the full suite.

`debug_failure` automatically builds Ochiai evidence by rerunning only parsed failing pytest files when coverage support is available. Python failures use a bounded def-use/control backward slice. Joern uses an existing `cpg.bin`; Flacoco can be on `PATH` or supplied with `FLACOCO_JAR`. Real ddmin/HDD requires `failing_input` and a bounded `repro.argv`; commands run directly without a shell.

### Post-edit lint hook

The plugin also bundles a `PostToolUse` hook that lints the file after each `apply_patch` and reports type or lint errors back to the agent in the same turn. Codex only runs bundled hooks after you enable the feature and trust the plugin's hooks:

```toml
# ~/.codex/config.toml
[features]
codex_hooks = true
```

The hook is fail-open: without Python 3 or a linter it stays silent, and the cache MCP is unaffected.
