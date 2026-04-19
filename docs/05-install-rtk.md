# 05 - Install RTK

## Why RTK matters

`rtk` is the shell-output compression layer. It helps reduce the token impact of noisy commands.

## Install RTK with Homebrew

Recommended:

```bash
brew install rtk
```

Verify:

```bash
rtk --version
rtk gain
```

`rtk gain` may show little or no data at first. That is normal before real usage.

## Initialize RTK for Claude Code

Run:

```bash
rtk init -g
```

Follow the prompts.

When prompted to patch Claude Code settings, answer:

```text
y
```

## Important macOS note

Claude Code hooks may run with a restricted `PATH`.

On Apple Silicon Macs, Homebrew binaries usually live in:

```text
/opt/homebrew/bin
```

If `rtk` is not found from inside Claude Code hooks, add this to `~/.zshrc`:

```bash
export PATH="/opt/homebrew/bin:$PATH"
```

Then reload your shell:

```bash
source ~/.zshrc
```

## Restart Claude Code

After `rtk init -g`, restart Claude Code.

## Test that RTK is active

Inside Claude Code, ask it to run:

```text
git status
```

or

```text
rg "TODO" .
```

Then inspect your `rtk` stats:

```bash
rtk gain
```

## Recommended usage habit

Whenever you know a command may be verbose, prefer shell commands that can be intercepted by `rtk`.

Examples:

- `git status`
- `git diff`
- `rg`
- `cat`
- `npm test`
- `cargo test`

