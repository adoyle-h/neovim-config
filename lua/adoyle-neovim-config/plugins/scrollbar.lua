local M = {
	'petertriho/nvim-scrollbar',
	config = function(config)
		require('scrollbar').setup(config.scrollbar)
	end,
}

M.defaultConfig = function(config)
	local colors = config.colors
	local has_hlslens = pcall(require, 'hlslens')

	return {
		'scrollbar',
		{
			excluded_buftypes = { 'terminal' },

			excluded_filetypes = { 'prompt', 'TelescopePrompt' },

			handle = { color = colors.grey2 },

			marks = { Search = { priority = 0, color = colors.orange } },

			handlers = {
				diagnostic = true,
				search = has_hlslens, -- will auto run require('scrollbar.handlers.search').setup()
			},
		},
	}
end

return M
