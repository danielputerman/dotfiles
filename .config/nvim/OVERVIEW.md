# Neovim Configuration Overview

## Architecture

**Entry point chain:** `init.vim` → `lua/new_init.lua` → `lua/plugins.lua` → `lua/plugins/*.lua`

- `init.vim` — Vimscript layer: leader key (`<Space>`), basic keybindings, clipboard/search options
- `lua/new_init.lua` — Lua layer: vim options (line numbers, search, mouse, etc.), requires the plugin manager
- `lua/plugins.lua` — lazy.nvim bootstrap and plugin spec imports from `lua/plugins/` modules
- `lua/plugins/*.lua` — Modular plugin configs (10 files), each returns a lazy.nvim spec table

## Plugin Modules

| Module | Purpose | Key plugins |
|---|---|---|
| `lsp.lua` | Language servers via mason + nvim 0.11 native LSP | pyright, ruff, ts_ls, rust_analyzer, lua_ls, jdtls |
| `completion.lua` | Autocompletion | nvim-cmp, LuaSnip, cmp sources |
| `navigation.lua` | File finding & tree | fzf-lua, nvim-tree |
| `ui.lua` | Colorscheme & statusline | catppuccin (mocha), lualine |
| `editing.lua` | Formatting & text manipulation | conform.nvim (ruff, stylua, prettier, shfmt), vim-surround, vim-commentary |
| `git.lua` | Git integration | fugitive, gitsigns |
| `treesitter.lua` | Syntax highlighting via FileType autocmd | nvim-treesitter (15 parsers, new API) |
| `dap.lua` | Debugging | nvim-dap, nvim-dap-ui, nvim-dap-python (debugpy at `~/.virtualenvs/debugpy/bin/python`) |
| `ai.lua` | AI assistance | copilot.vim |
| `markdown.lua` | Markdown preview | markdown-preview.nvim |

## Key Conventions

- Leader key is `<Space>` (set in both init.vim and new_init.lua)
- Arrow keys are deliberately disabled — use hjkl
- `;` is remapped to `:` for command mode
- Format-on-save is enabled via conform.nvim with LSP fallback
- Python tooling: ruff (linting/formatting) + pyright (type checking/navigation) — see [python-lsp.md](python-lsp.md) for details
- LSP servers requiring custom config use `vim.lsp.config()` (nvim 0.11 API); mason-lspconfig's `automatic_enable` starts installed servers automatically
- lua_ls is configured with `diagnostics.globals = { 'vim' }` and the Neovim runtime library for proper nvim Lua support
- Treesitter uses the new nvim-treesitter API: `require('nvim-treesitter').install({...})` for parsers, `vim.treesitter.start()` via FileType autocmd for highlighting
- Each plugin module file must return a valid lazy.nvim spec (table or list of tables)

## Keybindings

| Keybinding | Action |
|---|---|
| `<leader>f` | Find files (fzf) |
| `<leader>s` | Live grep search (fzf) |
| `<leader>d` | Show document diagnostics |
| `<leader>e` | Show diagnostic float for current line |
| `<leader>n` | Toggle file explorer (nvim-tree) |
| `<leader>j` | Format buffer |
| `<leader>vs` | Select Python virtualenv |
| `<leader>o` / `<leader>O` | Insert empty line below/above |
| `<leader>w` | Window control |
| `<C-w>f` | Maximize window |
| `<C-w>e` | Equal window sizes |
| `<Tab>` | Match brace (visual mode) |

## Working With This Config

- After changing plugin specs, restart nvim and run `:Lazy sync`
- To add a new plugin module, create `lua/plugins/<name>.lua` returning a spec table, then add `{ import = "plugins.<name>" }` to `lua/plugins.lua`
- LSP servers are managed by mason — add new servers to `ensure_installed` in `lsp.lua`. Custom per-server config goes in `vim.lsp.config()` calls (not the legacy `handlers` table, which is bypassed by `automatic_enable`)
- `lazy-lock.json` is the lockfile — commit it to pin plugin versions

## Visualization

```
┌─────────────────────────────────────────────────────────┐
│                       init.vim                          │
│              (leader, keymaps, clipboard)                │
└──────────────────────┬──────────────────────────────────┘
                       │ require('new_init')
┌──────────────────────▼──────────────────────────────────┐
│                    new_init.lua                          │
│              (vim options, require plugins)              │
└──────────────────────┬──────────────────────────────────┘
                       │ require('plugins')
┌──────────────────────▼──────────────────────────────────┐
│                    plugins.lua                           │
│              (lazy.nvim bootstrap + imports)             │
└──────────────────────┬──────────────────────────────────┘
                       │ imports lua/plugins/*
       ┌───────┬───────┼───────┬───────┬───────┐
       ▼       ▼       ▼       ▼       ▼       ▼
   ┌───────┐┌──────┐┌──────┐┌─────┐┌──────┐┌──────┐
   │ lsp   ││ cmp  ││  ui  ││ nav ││ edit ││ git  │
   │       ││      ││      ││     ││      ││      │
   │pyright││nvim- ││catpu-││fzf- ││confo-││fugi- │
   │ts_srv ││cmp   ││ccin  ││lua  ││rm    ││tive  │
   │rust   ││LuaSn-││lual- ││nvim-││surr- ││gits- │
   │lua_ls ││ip    ││ine   ││tree ││ound  ││igns  │
   │jdtls  ││      ││      ││     ││comm- ││      │
   │mason  ││      ││      ││     ││entary││      │
   └───────┘└──────┘└──────┘└─────┘└──────┘└──────┘
       ┌───────┬───────┬───────┐
       ▼       ▼       ▼       ▼
   ┌───────┐┌──────┐┌──────┐┌──────┐
   │ dap   ││  ai  ││tree- ││ mark-│
   │       ││      ││sitter││ down │
   │nvim-  ││copil-││      ││      │
   │dap    ││ot    ││15    ││previ-│
   │dap-ui ││      ││parse-││ew   │
   │dap-py ││      ││rs    ││      │
   └───────┘└──────┘└──────┘└──────┘
```
