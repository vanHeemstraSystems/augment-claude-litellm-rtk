# 07 - Verification

## Verify Homebrew tools

Run:

```bash
brew --version
git --version
python3.12 --version
uv --version
node --version
```

## Verify PostgreSQL

Run:

```bash
/opt/homebrew/opt/postgresql@17/bin/psql --version
brew services list | grep postgresql
```

Confirm the service is started and the database exists:

```bash
/opt/homebrew/opt/postgresql@17/bin/psql -d litellm -c "SELECT 1 AS connected;"
```

## Verify Claude Code

Run:

```bash
claude --version
claude mcp --help
```

## Verify Auggie

Run:

```bash
auggie --version
claude mcp list
```

You should see `auggie` in the MCP list.

## Verify RTK

Run:

```bash
rtk --version
rtk gain
```

## Verify LiteLLM

Run:

```bash
litellm --help
```

Then start the proxy and test:

```bash
bash examples/litellm-test-request.sh
```

## Verify the LiteLLM admin UI

Open your browser to:

```text
http://127.0.0.1:4000/ui
```

Log in with your `UI_USERNAME` and `UI_PASSWORD`.

## End-to-end practical test

Inside Claude Code, open a repository and ask:

```text
Use Augment MCP to locate the files most relevant to article publishing automation in this repo. Then run git status and rg "dev.to|DEV.to|front matter|publish" . and summarize the result in a compact way.
```

What this tests:

- Augment MCP semantic retrieval
- shell command execution
- `rtk` interception of shell-heavy steps
- compact summarization inside Claude Code
