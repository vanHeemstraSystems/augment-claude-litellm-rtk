#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Run scripts/install_prereqs.sh first."
  exit 1
fi

brew install rtk

echo ""
echo "RTK version:"
rtk --version

echo ""
echo "Initial gain statistics:"
rtk gain || true

echo ""
echo "Running guided initialization for Claude Code..."
rtk init -g

echo ""
echo "If you use zsh, ensure this line exists in ~/.zshrc:"
echo 'export PATH="/opt/homebrew/bin:$PATH"'
