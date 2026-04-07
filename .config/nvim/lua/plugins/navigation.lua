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
	update_focused_file = { -- Make nvim-tree auto focus based on the current buffer.
	    enable = true,      -- Enables the feature
	    update_root = true, -- Updates the tree root to the current file's directory
	},
      })

      -- Keybinding
      vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })

      -- Auto-open nvim-tree when launched with a directory
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            require('nvim-tree.api').tree.open()
          end
        end,
      })
    end,
  },
}
