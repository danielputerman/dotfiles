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

  -- Java LSP (uses ftplugin/java.lua to launch)
  { 'mfussenegger/nvim-jdtls', ft = 'java' },

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
       -- Disable hover so only pyright responds to K
       vim.lsp.config('ruff', {
         root_dir = function(bufnr, on_dir)
           local fname = vim.api.nvim_buf_get_name(bufnr)
           if fname == '' then return end
           local root = vim.fs.root(bufnr, { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' })
           on_dir(root or vim.fn.getcwd())
         end,
         on_attach = function(client)
           client.server_capabilities.hoverProvider = false
         end,
       })

       -- lua_ls: recognize Neovim runtime and 'vim' global
       vim.lsp.config('lua_ls', {
         settings = {
           Lua = {
             runtime = { version = 'LuaJIT' },
             workspace = {
               library = { vim.env.VIMRUNTIME },
               checkThirdParty = false,
             },
             diagnostics = { globals = { 'vim' } },
           },
         },
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
           -- jdtls is handled by nvim-jdtls via ftplugin/java.lua
           function(server_name)
             if server_name == 'jdtls' then return end
             lspconfig[server_name].setup({})
           end,

           -- Pyright: type checking and go-to-definition only; ruff handles linting
           pyright = function()
             lspconfig.pyright.setup({
               settings = {
		pyright = {
			-- Use Ruff's import organizer instead
			disableOrganizeImports = true,
		},
                 python = {
                   analysis = {
                     autoSearchPaths = true,
                     useLibraryCodeForTypes = true,
                     -- Suppress all linting diagnostics; ruff owns those
                     ignore = { '**/*' },
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
