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

  {
    'github/copilot.vim',
    lazy = false,
  },

  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
  },

  -- LSP server manager
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
  },

  -- LSP configurations
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
    },

    config = function()
       local lsp_zero = require('lsp-zero')
       local lspconfig = require('lspconfig')

       lsp_zero.on_attach(function(client, bufnr)
         lsp_zero.default_keymaps({buffer = bufnr})
       end)

       -- Extend lspconfig with lsp-zero defaults
       lsp_zero.extend_lspconfig()

       -- FIXED: Handlers must be inside setup() to prevent the "automatic_enable" crash
       require('mason-lspconfig').setup({
         ensure_installed = {
           'lua_ls',
           -- 'ts_ls',
           -- 'rust_analyzer',
         },
         handlers = {
           -- The default handler (applies to all servers)
           function(server_name)
             lspconfig[server_name].setup({})
           end,
         },
       })
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',           -- Snippet engine
      'saadparwaiz1/cmp_luasnip',   -- Snippet completions
      'hrsh7th/cmp-buffer',          -- Buffer completions
      'hrsh7th/cmp-path',            -- Path completions
      'hrsh7th/cmp-nvim-lsp',        -- LSP completions
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },

  -- Powerline-like status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'powerline_dark' }
      })
    end,
  },

  -- Fuzzy file finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end,
  },

  -- Git plugins
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
      })
    end,
  },

  -- Log handling
  { "MTDL9/vim-log-highlighting" },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw (Neovim's built-in file explorer)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },

  -- Surround and commentary
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },

  -- Color schemes
  {
    "romainl/Apprentice",
    name = "apprentice",
    lazy = false,
    priority = 1000,
    config = function()
      -- Safely load colorscheme, ignore errors if not yet installed
      pcall(vim.cmd, [[colorscheme apprentice]])
    end,
  },
  { "chriskempson/base16-vim" },
  { "altercation/vim-colors-solarized" },
})
