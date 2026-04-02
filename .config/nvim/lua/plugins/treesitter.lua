return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "bash",
      "c",
      "dockerfile",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "rust",
      "typescript",
      "vim",
      "yaml",
    })

    -- Enable treesitter highlighting for common filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "bash", "c", "dockerfile", "go", "html", "java", "javascript",
        "json", "lua", "markdown", "python", "rust", "typescript", "vim", "yaml",
      },
      callback = function() vim.treesitter.start() end,
    })
  end,
}
