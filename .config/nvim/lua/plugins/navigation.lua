return {
  -- Fuzzy file finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})

      -- Keybindings
      vim.keymap.set('n', '<leader>f', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
      vim.keymap.set('n', '<leader>s', '<cmd>FzfLua live_grep<cr>', { desc = 'Find text in files' })
      vim.keymap.set('n', '<leader>d', '<cmd>FzfLua diagnostics_document<cr>', { desc = 'Show document diagnostics' })
    end,
  },

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

      -- Keybinding
      vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })
    end,
  },
}
