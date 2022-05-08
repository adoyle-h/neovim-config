local M = {
	'petertriho/nvim-scrollbar',
	disable = false,
}

function M.config()
	require('scrollbar').setup {
		excluded_buftypes = {
			-- 'terminal',
		},
		excluded_filetypes = {
			-- 'prompt',
			-- 'TelescopePrompt',
		},
		handle = {
			color = vim.config.color.grey2,
		},
		marks = {
			Search = {
				priority = 0,
				color = vim.config.color.yellowBG,
			},
		},
    handlers = {
        diagnostic = true,
        search = true, -- Requires hlslens to be loaded, will run require('scrollbar.handlers.search').setup() for you
    },
	}
end

return M
