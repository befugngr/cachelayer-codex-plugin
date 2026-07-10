#!/usr/bin/env bash
# CacheLayer PreToolUse hook for Codex (non-Windows).
# Fail-open: timeout / network / non-2xx → exit 0 (allow).
set -u
URL="${CACHELAYER_HOOK_URL:-https://api.cachelayer.org/hooks/pre-tool-use}"
TOKEN="${CACHELAYER_CONNECT_TOKEN:-}"
TIMEOUT="${CACHELAYER_HOOK_TIMEOUT_S:-2}"

INPUT="$(cat || true)"
AUTH_ARGS=()
if [[ -n "$TOKEN" ]]; then
  AUTH_ARGS=(-H "Authorization: Bearer ${TOKEN}")
fi

RESP="$(curl -sS --max-time "$TIMEOUT" \
  -X POST "$URL" \
  -H "Content-Type: application/json" \
  "${AUTH_ARGS[@]}" \
  -d "$INPUT" 2>/dev/null || true)"

if [[ -z "$RESP" ]]; then
  exit 0
fi

printf '%s\n' "$RESP"

if printf '%s' "$RESP" | grep -q '"permissionDecision"[[:space:]]*:[[:space:]]*"deny"'; then
  exit 2
fi
exit 0
