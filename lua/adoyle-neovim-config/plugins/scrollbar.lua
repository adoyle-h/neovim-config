local config = require('adoyle-neovim-config.config').config

local M = {
	'petertriho/nvim-scrollbar',
	config = function()
		require('scrollbar').setup(config.scrollbar)
	end,
}

M.defaultConfig = function()
	local color = config.color
	local has_hlslens = pcall(require, 'hlslens')

	return {
		'scrollbar',
		{
			excluded_buftypes = { 'terminal' },

			excluded_filetypes = { 'prompt', 'TelescopePrompt' },

			handle = { color = color.grey2 },

			marks = { Search = { priority = 0, color = color.orange } },

			handlers = {
				diagnostic = true,
				search = has_hlslens, -- will auto run require('scrollbar.handlers.search').setup()
			},
		},
	}
end

return M
