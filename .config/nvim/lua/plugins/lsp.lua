return {
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
}
