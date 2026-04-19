# 02 - Prerequisites

## Hardware and OS

This repository assumes:

- **Mac Mini M4 Pro**
- **macOS on Apple Silicon**
- Terminal shell: **zsh**

## What must already be true

- You have admin rights on the Mac.
- You can install Homebrew packages.
- You already have **Intent by Augment** installed.
- You can sign in to Augment and Anthropic.

## Install Xcode Command Line Tools

Run:

```bash
xcode-select --install
```

If macOS says the tools are already installed, continue.

## Install Homebrew

If Homebrew is not installed, run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then add Homebrew to your shell if needed:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## Install the base packages

Run:

```bash
brew update
brew install git curl jq python@3.12 uv node postgresql@17
```

## Start PostgreSQL

Run:

```bash
brew services start postgresql@17
```

## Why these packages

- `git` for repository work
- `curl` for downloads and HTTP tests
- `jq` for JSON formatting
- `python@3.12` for LiteLLM runtime support (LiteLLM requires Python 3.10+ for modern syntax)
- `uv` for installing LiteLLM cleanly
- `node` because Auggie requires Node 22+
- `postgresql@17` as the backing database for the LiteLLM admin UI and usage tracking

## Verify versions

Run:

```bash
git --version
curl --version
jq --version
python3.12 --version
uv --version
node --version
/opt/homebrew/opt/postgresql@17/bin/psql --version
```

## Confirm Node major version is 22 or later

Run:

```bash
node -p "process.versions.node"
```

If the major version is lower than 22, upgrade Node before continuing.
