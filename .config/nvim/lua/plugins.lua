--
-- LAZY.NVIM plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
 vim.fn.system({
   "git",
   "clone",
   "--filter=blob:none",
   "https://github.com/folke/lazy.nvim.git",
   "--branch=stable", -- latest stable release
   lazypath,
 })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
-- LSP Support
 {
   'VonHeikemen/lsp-zero.nvim',
   branch = 'v3.x',
   lazy = true,
   config = false,
 },
-- Default configs for various LSP
 {
   'neovim/nvim-lspconfig',
   dependencies = {
     {'hrsh7th/cmp-nvim-lsp'},
   }
 },
-- Autocompletion
 {
   'hrsh7th/nvim-cmp',
   dependencies = {
     {'L3MON4D3/LuaSnip'}
   },
 },
 -- powerline-like status line plugin
 {
     'nvim-lualine/lualine.nvim',
     dependencies = { 'nvim-tree/nvim-web-devicons' }
 },
},
{ 
	"junegunn/fzf",
	dir = "~/.fzf",
	build = "./install --all" 
})


-- Starting Luline
require('lualine').setup({
  options = { theme = 'powerline_dark' }
})

--- Starting LSP-ZERO
 local lsp_zero = require('lsp-zero')

 lsp_zero.on_attach(function(client, bufnr)
 -- see :help lsp-zero-keybindings
 -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

