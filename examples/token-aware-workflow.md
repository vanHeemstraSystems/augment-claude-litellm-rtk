# Token-Aware Workflow

## Good

- Use Augment MCP to locate files before reading them.
- Ask for a short answer.
- Run `rg` instead of opening many files manually.
- Run tests only for the affected package or module.
- Use `git diff` instead of asking for a full repository explanation.

## Avoid

- "Read the whole codebase and explain everything"
- long multi-page prose outputs
- full logs when only failures matter
- repeated restating of the same project rules

## Compact prompt pattern

```text
Use Augment MCP to find the files relevant to X.
Inspect only the top candidates.
Run the smallest useful shell commands.
Return:
- the likely root cause,
- the exact files to change,
- the minimal patch plan.
```
