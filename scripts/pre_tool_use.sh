#!/usr/bin/env bash
# CacheLayer Codex PreToolUse lookup. Read/search only and fail-open.
# Same JSON dialect as Claude Code: deny + exit 2 on replay-safe hit.
set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
URL="${CACHELAYER_HOOK_URL:-https://api.cachelayer.org/hooks/pre-tool-use}"
TOKEN="${CACHELAYER_KEY:-${CACHELAYER_CONNECT_TOKEN:-${CACHELAYER_TOKEN:-}}}"
TIMEOUT="${CACHELAYER_HOOK_TIMEOUT_S:-2}"

FLOW_HDR=()
if [[ -n "${CACHELAYER_FLOW_ID:-}" ]]; then
  FLOW_HDR=(-H "x-amg-flow: ${CACHELAYER_FLOW_ID}")
fi

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
  "${FLOW_HDR[@]}" \
  -d "$INPUT" 2>/dev/null || true)"
if [[ -z "$RESP" ]]; then
  exit 0
fi

# Prefer server response; on hit ensure deny + additionalContext for Codex.
OUT="$(printf '%s' "$RESP" | python3 -c '
import json, sys
try:
    d = json.load(sys.stdin)
except Exception:
    print("{}"); raise SystemExit(0)
if not isinstance(d, dict) or d.get("error"):
    print(json.dumps(d if isinstance(d, dict) else {})); raise SystemExit(0)
cl = d.get("cachelayer") if isinstance(d.get("cachelayer"), dict) else {}
hso = d.get("hookSpecificOutput") if isinstance(d.get("hookSpecificOutput"), dict) else {}
hit = bool((d.get("hit") or cl.get("hit")) and cl.get("replay_safe") is True)
result = d.get("result") if d.get("result") is not None else cl.get("result")
if hit and result is not None:
    rendered = result if isinstance(result, str) else json.dumps(result, default=str)
    out = {
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": hso.get("permissionDecisionReason")
                or "Validated replay-safe CacheLayer hit.",
            "additionalContext": hso.get("additionalContext")
                or ("Use this cached result and do not rerun the tool:\n" + rendered),
        }
    }
    if "updatedToolOutput" in d:
        out["updatedToolOutput"] = d["updatedToolOutput"]
    print(json.dumps(out))
    raise SystemExit(2)
print(json.dumps(d))
' 2>/dev/null)"
RC=$?
if [[ -n "$OUT" ]]; then
  printf '%s\n' "$OUT"
fi
if [[ "$RC" -eq 2 ]]; then
  exit 2
fi
exit 0
