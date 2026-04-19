#!/usr/bin/env bash
set -euo pipefail

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "If a GUI installer appeared, finish it first, then rerun this script."
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update
brew install git curl jq python@3.12 uv node postgresql@17

echo ""
echo "Starting PostgreSQL service..."
brew services start postgresql@17

echo ""
echo "Installed tool versions:"
git --version || true
curl --version | head -n 1 || true
jq --version || true
python3.12 --version || true
uv --version || true
node --version || true
/opt/homebrew/opt/postgresql@17/bin/psql --version || true
