# 01 - Architecture

## Goal

Build a token-aware coding stack on a Mac Mini M4 Pro that combines:

- **Claude Code** for coding assistance
- **Augment Context Engine MCP** for code retrieval
- **rtk** for shell-output token reduction
- **LiteLLM** for local gateway, routing, and cost controls

## Architecture diagram

```text
Your codebase
    |
    v
Claude Code
    | \
    |  \__ MCP tool calls ----------> Augment Context Engine MCP (via Auggie)
    |
    \__ shell commands -------------> rtk -> git / rg / cat / tests / build tools
    |
    \__ model usage ---------------> Claude provider path

Optional / parallel path
    |
    v
LiteLLM Proxy on localhost:4000
    |
    +--> Anthropic
    +--> OpenAI
    +--> Gemini
    +--> other providers later
    |
    v
PostgreSQL on localhost:5432
    (backing store for LiteLLM UI, budgets, and usage tracking)
```

## Why this split is useful

### Claude Code

Claude Code is the preferred external agent because it can:

- read and edit files
- run commands
- use MCP tools
- work well in terminal-heavy workflows

### Augment Context Engine MCP

Use this when the model needs **better codebase understanding**.

This is the semantic retrieval layer. It is much better than blindly pasting huge files into prompts.

### rtk

Use this when the agent runs **verbose shell commands**.

Examples:

- `git diff`
- `git status`
- `rg`
- `cat`
- `npm test`
- `pytest`
- `cargo test`
- `kubectl`
- `docker`

This is the cheapest and fastest way to stop token waste from command output.

### LiteLLM

Use LiteLLM for:

- local gateway experiments
- budget enforcement
- model routing
- fallback testing
- OpenAI-compatible local and remote tools
- admin UI dashboard for monitoring usage and health
- future integration paths

LiteLLM uses PostgreSQL as its backing store for the admin UI, usage tracking, and budget management.

## Supported core vs experimental edge

### Supported core

Treat this as the supported, dependable stack:

```text
Claude Code + Augment MCP + rtk
```

### Experimental / evolving edge

Treat this as useful but dependent on current client support:

```text
Claude Code -> LiteLLM -> provider
```

Because public docs can change, always validate whether your installed Claude Code build supports the exact provider or base-URL setup you want.

## Practical mental model

Use the right tool for the right source of waste:

- **Too much repo context?** Use Augment MCP.
- **Too much shell noise?** Use rtk.
- **Need budgets, routing, or shared gateway controls?** Use LiteLLM.
