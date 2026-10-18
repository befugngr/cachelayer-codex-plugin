#!/usr/bin/env bash
# CacheLayer Codex PostToolUse save. Read/search only and fail-open.
set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
URL="${CACHELAYER_POST_HOOK_URL:-https://api.cachelayer.org/hooks/post-tool-use}"
TOKEN="${CACHELAYER_KEY:-${CACHELAYER_CONNECT_TOKEN:-${CACHELAYER_TOKEN:-}}}"
FLOW_HDR=()
if [[ -n "${CACHELAYER_FLOW_ID:-}" ]]; then
  FLOW_HDR=(-H "x-cachelayer-flow: ${CACHELAYER_FLOW_ID}")
fi


if [[ -z "$TOKEN" ]] || ! command -v python3 >/dev/null 2>&1; then
  exit 0
fi
INPUT="$(python3 "$ROOT/filter_hook_payload.py" || true)"
if [[ -z "$INPUT" ]]; then
  exit 0
fi
# Save after the editor has the tool result. Do not wait on the network.
nohup curl -sS --max-time 5 -X POST "$URL" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${TOKEN}" \
  "${FLOW_HDR[@]}" \
  -d "$INPUT" >/dev/null 2>&1 &
exit 0
