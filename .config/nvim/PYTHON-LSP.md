# Python LSP Setup

## Role Split: Ruff + Pyright

Two LSP servers run for Python files with non-overlapping responsibilities:

- **Ruff** — primary linter and formatter
  - Inline linting diagnostics (unused imports, style violations, etc.)
  - Code actions (quick fixes like "remove unused import")
  - Formatting on save (via conform.nvim: `ruff_fix` + `ruff_format`)
  - Import organization (`pyright.disableOrganizeImports = true` defers to ruff)

- **Pyright** — type checking and navigation only
  - Type errors and type inference
  - Completions and hover docs (`K`)
  - Go-to-definition, find references
  - `analysis.ignore = ['**/*']` suppresses all linting diagnostics to avoid duplicates with ruff

## Deduplication Config

In `lsp.lua`, two settings prevent overlap:

1. **Pyright ignores linting**: `python.analysis.ignore = ['**/*']` tells pyright not to report diagnostics, so only ruff's linting shows up
2. **Ruff hover disabled**: `client.server_capabilities.hoverProvider = false` in ruff's `on_attach`, so `K` only triggers pyright's hover

## Ruff Unnamed Buffer Workaround

Ruff LSP panics with "a path to a document should have a parent path" when attached to an unsaved buffer (no file path). The fix is a custom `root_dir` function via `vim.lsp.config('ruff', ...)` that skips unnamed buffers by not calling the `on_dir` callback, which prevents ruff from activating for that buffer.

## Relevant Files

- `lua/plugins/lsp.lua` — LSP server configuration (pyright, ruff, lua_ls, etc.)
- `lua/plugins/editing.lua` — conform.nvim formatter config (`ruff_fix`, `ruff_format`)
