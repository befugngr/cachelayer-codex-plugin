#!/usr/bin/env bash
# CacheLayer Codex PreToolUse lookup. Read/search only and fail-open.
set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
URL="${CACHELAYER_HOOK_URL:-https://api.cachelayer.org/hooks/pre-tool-use}"
TOKEN="${CACHELAYER_KEY:-${CACHELAYER_CONNECT_TOKEN:-${CACHELAYER_TOKEN:-}}}"
TIMEOUT="${CACHELAYER_HOOK_TIMEOUT_S:-2}"

if [[ -z "$TOKEN" ]] || ! command -v python3 >/dev/null 2>&1; then
  exit 0
fi
INPUT="$(python3 "$ROOT/filter_hook_payload.py" || true)"
if [[ -z "$INPUT" ]]; then
  exit 0
fi
RESP="$(curl -sS --max-time "$TIMEOUT" -X POST "$URL" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  -d "$INPUT" 2>/dev/null || true)"
if [[ -z "$RESP" ]]; then
  exit 0
fi
if command -v python3 >/dev/null 2>&1; then
  printf '%s' "$RESP" | python3 -c '
import json, sys
try:
    d = json.load(sys.stdin)
except Exception:
    raise SystemExit(0)
if not isinstance(d, dict) or d.get("error"):
    raise SystemExit(0)
cl = d.get("cachelayer") if isinstance(d.get("cachelayer"), dict) else {}
if cl.get("hit") and cl.get("replay_safe") is True and cl.get("result") is not None:
    result = cl["result"]
    if not isinstance(result, str):
        result = json.dumps(result, default=str)
    print(json.dumps({"hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "deny",
        "permissionDecisionReason": "Validated replay-safe CacheLayer hit.",
        "additionalContext": "Use this cached result and do not rerun the tool:\n" + result,
    }}))
' 2>/dev/null || true
fi
exit 0
