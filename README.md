# Claude Code + Augment Context Engine MCP + RTK + LiteLLM on a Mac Mini M4 Pro

This repository gives you a detailed, step-by-step setup for a **token-aware coding stack** on macOS Apple Silicon:

- **Claude Code** as the preferred external coding agent
- **Augment Context Engine MCP** for semantic codebase retrieval
- **rtk** for reducing verbose shell output before it hits the model context
- **LiteLLM** as a local AI gateway for routing, budgets, testing, and future expansion

> **Important honesty note**
>
> The fully documented and officially supported core path is:
> **Claude Code + Augment Context Engine MCP + rtk**
>
> LiteLLM is included here because it is useful and production-worthy, but the
> public docs do not clearly document a guaranteed direct Claude Code → LiteLLM
> base-URL workflow in every environment. In this repository, LiteLLM is set up
> in a safe, practical way so you can:
>
> - run and verify it locally
> - use it with OpenAI-compatible tools and scripts
> - prepare for a direct Claude Code routing path if/when your local Claude Code setup supports it

## What you will end up with

After following this repo, your Mac Mini M4 Pro will have:

- Homebrew-based prerequisites
- Python 3.12 (required by LiteLLM)
- Node.js for `auggie`
- Auggie CLI installed and ready
- Claude Code installed and logged in
- Augment MCP registered inside Claude Code
- `rtk` installed and initialized for Claude Code shell usage
- PostgreSQL 17 running locally (backing store for LiteLLM UI)
- LiteLLM Proxy running locally on `http://127.0.0.1:4000`
- LiteLLM admin UI accessible at `http://127.0.0.1:4000/ui`
- Verification scripts and example prompts

## Recommended order

Follow these documents in order:

1. `docs/01-architecture.md`
2. `docs/02-prerequisites.md`
3. `docs/03-install-claude-code.md`
4. `docs/04-install-auggie-and-mcp.md`
5. `docs/05-install-rtk.md`
6. `docs/06-install-litellm.md`
7. `docs/07-verification.md`
8. `docs/08-daily-usage.md`
9. `docs/09-troubleshooting.md`

If you want the fastest path, use the scripts in `scripts/`, then come back to the docs for the checks and explanations.

## Fast path

Open Terminal and run:

```bash
cd /path/to/your/workspace
chmod +x scripts/*.sh
./scripts/install_prereqs.sh
./scripts/install_auggie.sh
./scripts/install_rtk.sh
./scripts/setup_litellm.sh
```

Then manually complete:

- sign in to **Claude Code**
- sign in to **Auggie / Augment**
- register the MCP server using the documented command in `docs/04-install-auggie-and-mcp.md`
- restart Claude Code
- run `./scripts/verify_stack.sh`

## Repository layout

```text
.
├── README.md
├── config
│   ├── litellm.config.yaml.example
│   └── litellm.env.example
├── docs
│   ├── 01-architecture.md
│   ├── 02-prerequisites.md
│   ├── 03-install-claude-code.md
│   ├── 04-install-auggie-and-mcp.md
│   ├── 05-install-rtk.md
│   ├── 06-install-litellm.md
│   ├── 07-verification.md
│   ├── 08-daily-usage.md
│   └── 09-troubleshooting.md
├── examples
│   ├── claude-first-session-prompt.md
│   ├── litellm-test-request.sh
│   └── token-aware-workflow.md
└── scripts
    ├── install_auggie.sh
    ├── install_prereqs.sh
    ├── install_rtk.sh
    ├── setup_litellm.sh
    └── verify_stack.sh
```

## Suggested episode angle for your Augment series

A strong episode concept would be:

**Episode: From Intent to an External Agent Stack**

with themes such as:

- why semantic retrieval matters more than brute-force context stuffing
- why shell output is a hidden token tax
- why gateway-based model routing is useful even before full migration
- how to keep Opus-class reasoning for hard tasks while lowering day-to-day spend
