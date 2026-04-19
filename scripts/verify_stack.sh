#!/usr/bin/env bash
set -euo pipefail

echo "== Homebrew tools =="
brew --version | head -n 1 || true
git --version || true
python3.12 --version || true
uv --version || true
node --version || true

echo ""
echo "== PostgreSQL =="
/opt/homebrew/opt/postgresql@17/bin/psql --version || true
if brew services list | grep -q "postgresql.*started"; then
  echo "PostgreSQL service is running"
else
  echo "[warn] PostgreSQL service is not running — run: brew services start postgresql@17"
fi
if /opt/homebrew/opt/postgresql@17/bin/psql -lqt 2>/dev/null | cut -d \| -f 1 | grep -qw litellm; then
  echo "Database 'litellm' exists"
else
  echo "[warn] Database 'litellm' not found — run: createdb litellm"
fi

echo ""
echo "== Claude Code =="
claude --version || true
claude mcp --help >/dev/null 2>&1 && echo "claude mcp available" || echo "claude mcp not available"

echo ""
echo "== Auggie =="
auggie --version || true
claude mcp list || true

echo ""
echo "== RTK =="
rtk --version || true
rtk gain || true

echo ""
echo "== LiteLLM =="
litellm --help >/dev/null 2>&1 && echo "litellm available" || echo "litellm not available"

# Source env for master key if available
if [ -f .env.litellm ]; then
  set -a && source .env.litellm && set +a
fi

if curl -sf http://127.0.0.1:4000/health -H "Authorization: Bearer ${LITELLM_MASTER_KEY:-}" >/dev/null 2>&1; then
  echo "LiteLLM health endpoint reachable on localhost:4000"
  echo "LiteLLM admin UI available at http://127.0.0.1:4000/ui"
else
  echo "LiteLLM health endpoint not reachable on localhost:4000 (proxy may not be running)"
fi
