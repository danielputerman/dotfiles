# dotfiles

Personal dotfiles for macOS. Managed manually via symlinks.

## Shell (`zsh/`)

Uses [Prezto](https://github.com/sorin-ionescu/prezto) with [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt.

**Entry point**: `~/.zshenv` sets `ZDOTDIR=$HOME/.dotfiles/zsh`, so zsh loads config from `zsh/.zprezto/runcoms/`.

### Runtime managers

All three are set up for fast shell startup — version binaries are available immediately; the manager CLI lazy-loads on first use.

| Tool | Version | Notes |
|------|---------|-------|
| **nvm** | Node 24 default | `node`/`npm`/`npx` from `~/.nvm/versions/node/$(default)/bin` added to PATH directly. `nvm` command loads `nvm.sh` on first use. |
| **pyenv** | system default | Shims at `~/.pyenv/shims` added to PATH statically (no subprocess on startup). |
| **jenv** | system default | Shims at `~/.jenv/shims` added to PATH; `jenv init` runs lazily on first `jenv` call. |

### Prezto modules

`environment`, `terminal`, `editor`, `syntax-highlighting`, `history`, `directory`, `spectrum`, `utility`, `completion`, `history-substring-search`, `autosuggestions`, `prompt`, `git`, `python`, `ruby`

> The `node` Prezto module is intentionally excluded — nvm is managed directly in `zshrc`.

### Key bindings

`zsh/keys.zsh` — vi-style navigation in the tab-completion menu (`h`/`j`/`k`/`l`).

### Secrets

If `~/.zsecrets` exists it is sourced at shell start (not tracked).

## Neovim (`.config/nvim/`)

See `.config/nvim/OVERVIEW.md` for the full Neovim setup notes.
