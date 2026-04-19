# 06 - Install LiteLLM

## What LiteLLM is doing here

LiteLLM is your local gateway layer.

In this repository, it is installed as a **local proxy** so you can:

- test model routing
- centralize provider API keys
- add budgets later
- expose an OpenAI-compatible endpoint on localhost
- use the admin UI dashboard for monitoring

## Prerequisites

Make sure PostgreSQL is installed and running:

```bash
brew install postgresql@17
brew services start postgresql@17
```

## Create the LiteLLM database

```bash
/opt/homebrew/opt/postgresql@17/bin/createdb litellm
```

## Install LiteLLM Proxy

LiteLLM requires Python 3.12+. Use `uv` with the `--python` flag:

```bash
uv tool install --python 3.12 'litellm[proxy]'
```

Verify:

```bash
litellm --help
```

## Install and configure Prisma

LiteLLM uses Prisma to manage its PostgreSQL schema. Install it into the LiteLLM virtual environment:

```bash
uv pip install --python ~/.local/share/uv/tools/litellm/bin/python prisma
```

Push the database schema:

```bash
DATABASE_URL="postgresql://$USER@localhost:5432/litellm" \
  PATH="$HOME/.local/share/uv/tools/litellm/bin:$PATH" \
  prisma db push --schema ~/.local/share/uv/tools/litellm/lib/python3.12/site-packages/litellm/proxy/schema.prisma
```

## Prepare the environment file

Copy the example file:

```bash
cp config/litellm.env.example .env.litellm
```

Edit it:

```bash
nano .env.litellm
```

Set the following values:

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_API_KEY` | Your Anthropic API key |
| `OPENAI_API_KEY` | Your OpenAI API key (optional) |
| `GEMINI_API_KEY` | Your Gemini API key (optional) |
| `UI_USERNAME` | Username for the LiteLLM admin UI |
| `UI_PASSWORD` | Password for the LiteLLM admin UI |
| `LITELLM_MASTER_KEY` | Master key for API auth (must match `master_key` in config yaml) |
| `DATABASE_URL` | PostgreSQL connection string: `postgresql://YOUR_MACOS_USERNAME@localhost:5432/litellm` |

Leave unused provider keys blank or remove them.

## Prepare the LiteLLM config

Copy the example config:

```bash
cp config/litellm.config.yaml.example litellm.config.yaml
```

## Start the proxy

Run:

```bash
set -a && source .env.litellm && set +a
litellm --config litellm.config.yaml
```

By default this repository config uses:

```text
http://127.0.0.1:4000
```

## Access the admin UI

Open your browser to:

```text
http://127.0.0.1:4000/ui
```

Log in with the `UI_USERNAME` and `UI_PASSWORD` you set in `.env.litellm`.

From the UI you can monitor model health, view request logs, set budgets, and manage API keys.

## Run LiteLLM in another terminal tab

Keep the proxy running while you test requests from a second terminal.

## Verify the proxy health

In another terminal, run:

```bash
set -a && source .env.litellm && set +a
curl -s http://127.0.0.1:4000/health -H "Authorization: Bearer $LITELLM_MASTER_KEY" | jq
```

If that endpoint is unavailable in your installed LiteLLM build, use the model test script in `examples/litellm-test-request.sh`.

## Important limitation note

This repository treats LiteLLM as a **local, ready gateway**.

Whether your current Claude Code installation can be pointed directly at that proxy depends on the provider/base-URL options available in your installed Claude Code build.

That is why this repo sets up LiteLLM in a way that is immediately useful even before a direct Claude Code bridge is switched on.
