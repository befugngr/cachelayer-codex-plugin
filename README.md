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

The post-edit hook is fail-open and fast by default: it checks only edited code files and never runs tests on each keystroke. After one coherent edit batch, call `verify_edit` once with `mode: "coherent"` and a stable `edit_cycle_id` (or have an integration explicitly send `critic_mode: "coherent"`/`full_gate: true`). Typecheck and lint prerequisites run concurrently with at most three subprocesses; affected tests run only after all prerequisites pass. Commands use argument arrays rather than a shell and have bounded time, output, and per-process memory where the OS supports it.

If checks fail, `feedback.action` requests one coherent corrective edit and recheck with the same cycle ID. State is stored in the workspace's small `.cachelayer` state file, cleared on success, reset for a new cycle, and capped at three attempts. At the cap, stop and report the diagnostics. The hook and MCP tool return corrective context only; they do not edit user code.

For richer selection and diagnosis, projects may optionally install `pytest-testmon`/`pytest-cov`, Jest, Smart Test Picker, STARTS, Ekstazi, Gradle affectedTest, JaCoCo, or Joern. `run_affected_tests` keeps this priority: Smart Test Picker, seeded STARTS, seeded Ekstazi, safety-inspected affectedTest, native per-test JaCoCo XML/session reports, then bounded static test mapping.

Aggregate `jacoco.xml` is coverage validation only and never claims per-test selection. Existing `cpg.bin`/`joern-slice` data can expand Java callers/callees; otherwise the result labels its bounded import/type slice as degraded. Scalpel is not presented as a slicer because it has no verified TIA API.

Gradle affectedTest runs `--explain` first and refuses `FULL_SUITE`, `ALL_TESTS`, or full-suite fallback status. Missing `.starts`, `.ekstazi`, Smart Picker maps, and per-test JaCoCo reports produce honest seed/install guidance. Pass `seed_rts: true` only to get a dry-run additive profile/snippet plan; it never rewrites `pom.xml` or Gradle files and does not execute a baseline.

Python still prefers pytest-testmon, then coverage contexts, then bounded import/name mapping; Jest uses `--findRelatedTests`. When nothing safely maps, it runs nothing rather than escalating to the full suite.

`debug_failure` automatically builds Ochiai evidence by rerunning only parsed failing pytest files when coverage support is available. Python failures use a bounded def-use/control backward slice. Joern uses an existing `cpg.bin`; Flacoco can be on `PATH` or supplied with `FLACOCO_JAR`. Real ddmin/HDD requires `failing_input` and a bounded `repro.argv`; commands run directly without a shell.

### Post-edit lint hook

The plugin also bundles a `PostToolUse` hook that lints the file after each `apply_patch` and reports type or lint errors back to the agent in the same turn. Codex only runs bundled hooks after you enable the feature and trust the plugin's hooks:

```toml
# ~/.codex/config.toml
[features]
codex_hooks = true
```

The hook is fail-open: without Python 3 or a linter it stays silent, and the cache MCP is unaffected.
