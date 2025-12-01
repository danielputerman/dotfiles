return {
  -- Surround and commentary
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },

  -- Formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>j',
        function()
          require('conform').format({ async = true, lsp_fallback = true })
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      formatters_by_ft = {
        json = { 'prettier' },
        jsonc = { 'prettier' },
	 python = { "isort", "black" },
	lua = { 'stylua' },
	markdown = { 'prettier' },
	sh = { 'shfmt' },
	yaml = { 'prettier' },
      },
    },
  },
}
