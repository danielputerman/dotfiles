return {
  -- Powerline-like status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
    config = function()
      require('lualine').setup({
        options = { theme = 'catppuccin-mocha' }
      })
    end,
  },

  -- Color schemes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          mason = true,
          dap = true,
          dap_ui = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")

      -- Set terminal ANSI colors to catppuccin mocha palette
      -- This ensures terminal buffers (e.g. DAP console) use readable colors
      vim.g.terminal_color_0  = "#45475a"  -- surface1
      vim.g.terminal_color_1  = "#f38ba8"  -- red
      vim.g.terminal_color_2  = "#a6e3a1"  -- green
      vim.g.terminal_color_3  = "#f9e2af"  -- yellow
      vim.g.terminal_color_4  = "#89b4fa"  -- blue
      vim.g.terminal_color_5  = "#f5c2e7"  -- pink
      vim.g.terminal_color_6  = "#94e2d5"  -- teal
      vim.g.terminal_color_7  = "#bac2de"  -- subtext1
      vim.g.terminal_color_8  = "#585b70"  -- surface2 (bright black)
      vim.g.terminal_color_9  = "#f38ba8"  -- red (bright)
      vim.g.terminal_color_10 = "#a6e3a1"  -- green (bright)
      vim.g.terminal_color_11 = "#f9e2af"  -- yellow (bright)
      vim.g.terminal_color_12 = "#89b4fa"  -- blue (bright)
      vim.g.terminal_color_13 = "#cba6f7"  -- mauve (bright magenta)
      vim.g.terminal_color_14 = "#94e2d5"  -- teal (bright)
      vim.g.terminal_color_15 = "#cdd6f4"  -- text (bright white)
    end,
  },
  {
    "romainl/Apprentice",
    name = "apprentice",
    lazy = true,
  },
  { "chriskempson/base16-vim", lazy = true },
  { "altercation/vim-colors-solarized", lazy = true },

  -- Log handling
  { "MTDL9/vim-log-highlighting" },
}
