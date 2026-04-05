return {
  -- Debug Adapter Protocol core
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Continue / Start" },
      { "<leader>dn", function() require("dap").step_over() end,         desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end,          desc = "Step out" },
      { "<leader>dq", function() require("dap").terminate() end,         desc = "Stop debugger" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "Toggle DAP UI" },
    },
    config = function()
      -- Breakpoint signs with catppuccin mocha colors
      vim.api.nvim_set_hl(0, 'DapBreakpoint',        { fg = '#f38ba8' })  -- red
      vim.api.nvim_set_hl(0, 'DapBreakpointCondition',{ fg = '#f9e2af' })  -- yellow
      vim.api.nvim_set_hl(0, 'DapStopped',            { fg = '#a6e3a1' })  -- green

      vim.fn.sign_define('DapBreakpoint',         { text = '●', texthl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition',{ text = '◆', texthl = 'DapBreakpointCondition' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '●', texthl = 'Comment' })
      vim.fn.sign_define('DapStopped',            { text = '▶', texthl = 'DapStopped', linehl = 'CursorLine' })

      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      -- DAP UI stays open after program ends; close manually with <leader>du
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  -- Mason-managed DAP adapter installation
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "js", "codelldb" },
        automatic_installation = true,
        handlers = {},  -- use default configs for each adapter
      })
    end,
  },

  -- Python DAP support
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "python",
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    end,
  },

  -- Go DAP support
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "go",
    config = function()
      require("dap-go").setup()
    end,
  },
}
