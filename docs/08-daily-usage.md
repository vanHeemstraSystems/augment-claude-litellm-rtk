# 08 - Daily Usage

## Best-practice workflow

### 1. Make sure PostgreSQL is running

```bash
brew services list | grep postgresql
```

If not running:

```bash
brew services start postgresql@17
```

### 2. Start LiteLLM if you are testing gateway workflows

```bash
cd ~/Workspace/your-repo
set -a && source .env.litellm && set +a
litellm --config litellm.config.yaml
```

You can monitor usage via the admin UI at `http://127.0.0.1:4000/ui`.

### 3. Start Claude Code

Open Claude Code in the repository.

### 4. Prefer semantic retrieval before brute-force file dumps

Good prompt:

```text
Use Augment MCP to find the files that control the article publishing workflow. Then inspect only the most relevant files.
```

Less good prompt:

```text
Read the whole repository and explain everything.
```

### 5. Prefer shell commands that RTK can compress

Good examples:

```text
Run git diff
Run rg "publish" .
Run npm test
```

### 6. Keep outputs short

Ask for:

- a short summary
- only changed files
- only failing tests
- only the final patch

## Model economy tips

- Use semantic retrieval first.
- Avoid asking for step-by-step prose unless you really need it.
- Ask for compact summaries.
- Start a fresh session for a new task instead of dragging a huge chat history forward.
