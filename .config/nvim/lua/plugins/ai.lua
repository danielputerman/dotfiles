return {
  {
    'github/copilot.vim',
    lazy = false,
    config = function()
      vim.defer_fn(function()
        if vim.fn['copilot#Enabled']() == 0 then
          vim.notify("Copilot: not authenticated. Run :Copilot setup", vim.log.levels.WARN)
        end
      end, 3000)

      -- Dismiss Copilot suggestions with <Esc> in insert mode
      vim.keymap.set('i', '<Esc>', function()
        local suggestion = vim.fn['copilot#GetDisplayedSuggestion']()
        if suggestion and suggestion.text ~= '' then
          vim.fn['copilot#Dismiss']()
          return ''
        end
        return '<Esc>'
      end, { expr = true, silent = true })
    end
  },
}
