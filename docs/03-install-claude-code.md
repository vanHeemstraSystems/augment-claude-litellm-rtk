# 03 - Install Claude Code

## Overview

Claude Code is the preferred external agent in this setup.

## Install path

Use Anthropic's official installer or desktop flow for macOS.

If you are using the Claude desktop app with Code features, install the desktop app and sign in.

If you are using the terminal-first flow, follow the official Claude Code installation instructions for macOS Apple Silicon.

## After installation

Open Claude Code and sign in.

## Verify the CLI is available

Run:

```bash
claude --version
```

If that succeeds, continue.

If not, open Claude Code once from the app, then retry.

## Verify MCP support

Run:

```bash
claude mcp --help
```

You should see MCP-related subcommands.

## Recommended working pattern

Use a dedicated workspace folder such as:

```bash
mkdir -p ~/Workspace
cd ~/Workspace
```

Put your repositories there so both Claude Code and Augment MCP operate from a predictable root.

