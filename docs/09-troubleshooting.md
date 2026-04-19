# 09 - Troubleshooting

## Problem: `auggie` command not found

Check:

```bash
npm prefix -g
npm bin -g
which auggie
```

If your global npm bin directory is not on `PATH`, add it to `~/.zshrc`.

## Problem: `claude mcp list` does not show `auggie`

Re-run the registration command:

```bash
claude mcp add-json auggie --scope user '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}'
```

Then restart Claude Code.

## Problem: `rtk gain` shows nothing useful

That may be normal before real command traffic is intercepted.

Trigger a few verbose commands from Claude Code, then run:

```bash
rtk gain
```

## Problem: RTK does not seem active inside Claude Code

This is often a `PATH` problem on macOS Apple Silicon.

Confirm:

```bash
which rtk
```

If it returns:

```text
/opt/homebrew/bin/rtk
```

make sure that location is on the path used by your shell and Claude Code hooks.

Add to `~/.zshrc`:

```bash
export PATH="/opt/homebrew/bin:$PATH"
```

Then restart your terminal and Claude Code.

If `rtk init -g` did not automatically patch `~/.claude/settings.json`, you may need to create it manually:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/rtk-rewrite.sh"
          }
        ]
      }
    ]
  }
}
```

## Problem: PostgreSQL not running

Start the service:

```bash
brew services start postgresql@17
```

Verify:

```bash
brew services list | grep postgresql
```

## Problem: LiteLLM command not found

Check:

```bash
uv tool list
```

If LiteLLM is not installed, run:

```bash
uv tool install --python 3.12 'litellm[proxy]'
```

## Problem: LiteLLM crashes with `unsupported operand type(s) for |`

Your Python version is too old. LiteLLM requires Python 3.10+.

Fix:

```bash
brew install python@3.12
uv tool install --force --python 3.12 'litellm[proxy]'
```

## Problem: LiteLLM UI shows "Not connected to DB"

Check:

1. PostgreSQL is running: `brew services list | grep postgresql`
2. The `litellm` database exists: `/opt/homebrew/opt/postgresql@17/bin/psql -d litellm -c "SELECT 1;"`
3. `DATABASE_URL` is set correctly in `.env.litellm`: `postgresql://YOUR_MACOS_USERNAME@localhost:5432/litellm`
4. The Prisma schema has been pushed (see docs/06-install-litellm.md)

## Problem: LiteLLM crashes with `ModuleNotFoundError: prisma`

Prisma needs to be installed into the LiteLLM virtual environment:

```bash
uv pip install --python ~/.local/share/uv/tools/litellm/bin/python prisma
```

Then push the schema:

```bash
DATABASE_URL="postgresql://$USER@localhost:5432/litellm" \
  PATH="$HOME/.local/share/uv/tools/litellm/bin:$PATH" \
  prisma db push --schema ~/.local/share/uv/tools/litellm/lib/python3.12/site-packages/litellm/proxy/schema.prisma
```

## Problem: LiteLLM starts but model requests fail

Usually one of these is true:

- the provider API key is missing
- the provider model name is wrong
- the config file is not loaded

Re-check:

```bash
cat .env.litellm
cat litellm.config.yaml
```

Do not commit real API keys.

## Problem: direct Claude Code to LiteLLM routing is unclear

That is the expected cautious stance of this repository.

The supported core setup here does not depend on that direct bridge.

Treat LiteLLM as:

- useful immediately for local gateway testing and shared controls
- ready for direct Claude Code routing when your installed Claude Code build and provider options support it
