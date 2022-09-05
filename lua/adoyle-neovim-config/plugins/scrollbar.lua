local config = require('adoyle-neovim-config.config').global

local M = {
	'petertriho/nvim-scrollbar',
	disable = false,
}

function M.config()
	local hlslensOK, _ = pcall(require, 'kevinhwang91/nvim-hlslens')

	require('scrollbar').setup {
		excluded_buftypes = {
			-- 'terminal',
		},

		excluded_filetypes = {
			-- 'prompt',
			-- 'TelescopePrompt',
		},

		handle = {
			color = config.color.scrollbarBG,
		},

		marks = {
			Search = {
				priority = 0,
				color = config.color.yellowBG,
			},
		},

		handlers = {
			diagnostic = true,
			search = hlslensOK, -- Requires hlslens to be loaded, will run require('scrollbar.handlers.search').setup() for you
		},
	}
end

return M
