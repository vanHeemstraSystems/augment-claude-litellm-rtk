#!/usr/bin/env bash
set -euo pipefail

if [ ! -f .env.litellm ]; then
  echo "Missing .env.litellm in the current directory."
  echo "Copy config/litellm.env.example to .env.litellm first."
  exit 1
fi

set -a
source .env.litellm
set +a

curl -s http://127.0.0.1:4000/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${LITELLM_MASTER_KEY}" \
  -d '{
    "model": "claude-sonnet",
    "messages": [
      {"role": "user", "content": "Reply with exactly: LiteLLM is working."}
    ]
  }' | jq
