#!/usr/bin/env bash
set -euo pipefail

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is required. Run scripts/install_prereqs.sh first."
  exit 1
fi

NODE_MAJOR=$(node -p "process.versions.node.split('.')[0]")
if [ "$NODE_MAJOR" -lt 22 ]; then
  echo "Node.js 22 or newer is required. Current version: $(node --version)"
  exit 1
fi

npm install -g @augmentcode/auggie

echo ""
echo "Auggie version:"
auggie --version

echo ""
echo "Next steps:"
echo "1. Run: auggie"
echo "2. Complete the sign-in flow"
echo "3. Register MCP with the command from docs/04-install-auggie-and-mcp.md"
