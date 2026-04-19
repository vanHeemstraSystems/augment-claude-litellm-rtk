#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v uv >/dev/null 2>&1; then
  echo "uv is required. Run scripts/install_prereqs.sh first."
  exit 1
fi

echo "Installing LiteLLM with Python 3.12..."
uv tool install --python 3.12 'litellm[proxy]'

echo ""
echo "Installing Prisma into LiteLLM virtual environment..."
uv pip install --python ~/.local/share/uv/tools/litellm/bin/python prisma

echo ""
echo "Creating litellm database (if it does not exist)..."
if /opt/homebrew/opt/postgresql@17/bin/psql -lqt | cut -d \| -f 1 | grep -qw litellm; then
  echo "Database 'litellm' already exists."
else
  /opt/homebrew/opt/postgresql@17/bin/createdb litellm
  echo "Database 'litellm' created."
fi

echo ""
echo "Pushing Prisma schema to PostgreSQL..."
SCHEMA_PATH="$HOME/.local/share/uv/tools/litellm/lib/python3.12/site-packages/litellm/proxy/schema.prisma"
if [ -f "$SCHEMA_PATH" ]; then
  DATABASE_URL="postgresql://$USER@localhost:5432/litellm" \
    PATH="$HOME/.local/share/uv/tools/litellm/bin:$PATH" \
    prisma db push --schema "$SCHEMA_PATH"
else
  echo "[warn] Prisma schema not found at expected path."
  echo "       You may need to run prisma db push manually after locating schema.prisma."
fi

if [ ! -f .env.litellm ]; then
  cp config/litellm.env.example .env.litellm
  echo ""
  echo "Created .env.litellm from example template."
fi

if [ ! -f litellm.config.yaml ]; then
  cp config/litellm.config.yaml.example litellm.config.yaml
  echo ""
  echo "Created litellm.config.yaml from example template."
fi

echo ""
echo "LiteLLM is installed with PostgreSQL backing store."
echo ""
echo "Next steps:"
echo "  1. Edit .env.litellm and set your provider API keys, UI credentials, and DATABASE_URL"
echo "  2. To start LiteLLM:"
echo "       set -a && source .env.litellm && set +a"
echo "       litellm --config litellm.config.yaml"
echo "  3. Open the admin UI at http://127.0.0.1:4000/ui"
