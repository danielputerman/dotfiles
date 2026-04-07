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
    end
  },
}
