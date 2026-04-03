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
       local lspconfig = require('lspconfig')

       -- Ruff: skip unnamed buffers to prevent panic on missing document path
       vim.lsp.config('ruff', {
         root_dir = function(bufnr, on_dir)
           local fname = vim.api.nvim_buf_get_name(bufnr)
           if fname == '' then return end
           local root = vim.fs.root(bufnr, { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' })
           on_dir(root or vim.fn.getcwd())
         end,
       })

       vim.diagnostic.config({
         signs = true,
         underline = true,
         update_in_insert = false,
         severity_sort = true,
       })

       -- Handlers must be inside setup()
       require('mason-lspconfig').setup({
         ensure_installed = {
           'lua_ls',
           'pyright',
           'ts_ls',
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
