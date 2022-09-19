local M = { 'petertriho/nvim-scrollbar', disable = false }

function M.config()
	local has_hlslens = pcall(require, 'hlslens')
	local config = require('adoyle-neovim-config.config').config

	require('scrollbar').setup {
		excluded_buftypes = { 'terminal' },

		excluded_filetypes = { 'prompt', 'TelescopePrompt' },

		handle = { color = config.color.scrollbarBG },

		marks = { Search = { priority = 0, color = config.color.orange } },

		handlers = {
			diagnostic = true,
			search = has_hlslens, -- Requires hlslens to be loaded, will run require('scrollbar.handlers.search').setup() for you
		},
	}
end

return M
