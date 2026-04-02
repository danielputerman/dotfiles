return {
  -- Python environment selector for pyenv
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'ibhagwan/fzf-lua',
    },
    ft = 'python',
    opts = {
      pyenv_path = vim.fn.expand('~/.pyenv/versions'),
      dap_enabled = false,
      enable_cached_venvs = false,  -- Disable fd requirement
    },
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select Python environment' },
    },
  },

  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    config = true,
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

       vim.diagnostic.config(lsp_zero.defaults.diagnostics())

       lsp_zero.defaults.M.on_attach = function(client, bufnr)
         local opts = {buffer = bufnr, remap = false}
         -- Here you can add your own keymaps, see :help lsp-zero-keybindings
       end

       -- Handlers must be inside setup()
       require('mason-lspconfig').setup({
         ensure_installed = {
           'lua_ls',
           'pyright',
           'tsserver',
           'rust_analyzer',
           'jdtls',
         },
         handlers = {
           -- The default handler (applies to all servers)
           function(server_name)
             lspconfig[server_name].setup({})
           end,

           -- Python-specific configuration with venv detection
           pyright = function()
             lspconfig.pyright.setup({
               settings = {
                 python = {
                   analysis = {
                     autoSearchPaths = true,
                     useLibraryCodeForTypes = true,
                     diagnosticMode = 'workspace',
                   },
                 },
               },
             })
           end,
         },
       })
    end,
  },
}
