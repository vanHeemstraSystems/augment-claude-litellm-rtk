# 04 - Install Auggie and connect Augment Context Engine MCP

## Install Auggie CLI

Auggie requires Node 22 or later.

Install it globally:

```bash
npm install -g @augmentcode/auggie
```

Verify:

```bash
auggie --version
```

## Sign in to Augment

Run:

```bash
auggie
```

Then complete the sign-in flow.

If needed, also visit the Augment MCP configuration page in your browser and sign in there.

## Add Augment MCP to Claude Code

### User scope

This makes the MCP server available in all projects:

```bash
claude mcp add-json auggie --scope user '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}'
```

### Project scope

If you prefer to register it only inside the current repository:

```bash
claude mcp add-json auggie --scope project '{"type":"stdio","command":"auggie","args":["--mcp","--mcp-auto-workspace"]}'
```

Use either **user** or **project** scope. Most people should use **user**.

## Verify the MCP registration

Run:

```bash
claude mcp list
```

You should see an entry named `auggie`.

## Restart Claude Code

Fully close and reopen Claude Code after MCP registration.

## First semantic retrieval test

Open one of your repositories in Claude Code and ask something like:

```text
Use the Augment MCP tools to explain the main modules in this repository and identify the files most relevant to publishing a DEV.to article.
```

That confirms the semantic retrieval path is available.

