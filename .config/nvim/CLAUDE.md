# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Neovim config using **lazy.nvim**. Work in progress — may have startup errors.

- **Entry point chain:** `init.vim` → `lua/new_init.lua` → `lua/plugins.lua` → `lua/plugins/*.lua`
- Each plugin module in `lua/plugins/*.lua` returns a lazy.nvim spec table
- Leader key is `<Space>`, arrow keys disabled, `;` remapped to `:`
- Format-on-save via conform.nvim with LSP fallback

For full architecture, plugin details, keybindings, and conventions, see [OVERVIEW.md](OVERVIEW.md).
