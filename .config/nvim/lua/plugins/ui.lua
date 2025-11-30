return {
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

  -- Log handling
  { "MTDL9/vim-log-highlighting" },
}
