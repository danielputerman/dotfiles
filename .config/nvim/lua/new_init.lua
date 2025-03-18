
-- PLUGIN CONFIGUATIONS
 
vim.cmd ({ cmd='source' , args={"/Users/danielputerman/.dotfiles/.config/nvim/plugins.vimrc"} })
require("plugins")

-- OPTIONS

--[[Vim is based on Vi. Setting `nocompatible` switches from the default
 Vi-compatibility mode and enables useful Vim functionality. This
 configuration option turns out not to be necessary for the file named
 '~/.vimrc', because Vim automatically enters nocompatible mode if that file
 is present. But we're including it here just in case this config file is
 loaded some other way (e.g. saved as `foo`, and then Vim started with
 `vim -u foo`).
]]
vim.opt.compatible = false


-- Turn on syntax highlighting.
vim.cmd( { cmd='syntax', args={"on"} })

-- Disable the default Vim startup message.
vim.opt.shortmess:append("I")

-- Show line numbers.
vim.opt.number = true

--[[ This enables relative line numbering mode. With both number and
 relativenumber enabled, the current line shows the true line number, while
 all other lines (above and below) are numbered relative to the current line.
 This is useful because you can tell, at a glance, what count is needed to
 jump up or down to a particular line, by {count}k to go up or {count}j to go
 down.
 ]]
vim.opt.relativenumber = true

-- No automatic wrapping of text (especially annoying for log files)
vim.opt.wrap = false

-- If we do enable wrap at some point, we want the line to break at word boundary.
vim.opt.linebreak = true

-- Always show the status line at the bottom, even if you only have one window open.
vim.opt.laststatus = 2

--[[ The backspace key has slightly unintuitive behavior by default. For example,
 by default, you can't backspace before the insertion point vim.o.with 'i'.
 This configuration makes backspace behave more reasonably, in that you can
 backspace over anything.
]]
vim.opt.backspace = { "indent", "eol", "start" }


-- Moving between lines with "h" and "l"
vim.opt.whichwrap:append("hl")

--[[ By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
 shown in any window) that has unsaved changes. This is to prevent you from "
 forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
 hidden buffers helpful enough to disable this protection. See `:help hidden`
 for more information on this.
]]
vim.opt.hidden = true

--[[ This setting makes search case-insensitive when all characters in the string
 being searched are lowercase. However, the search becomes case-sensitive if
 it contains any capital letters. This makes searching more convenient.
]]
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable searching as you type, rather than waiting till you press enter.
vim.opt.incsearch = true

-- Make Vim refresh faster (default was 4000, i.e. 4 seconds)
vim.opt.updatetime = 100 
