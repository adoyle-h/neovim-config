local M = {
	'rcarriga/nvim-notify',
	desc = 'An awesome notify library!',

	commands = {
		{
			'Notify',
			function(opts)
				local args = opts.fargs
				vim.notify(args[1], args[2] or 'info')
			end,
			{
				nargs = '+',
				desc = 'Send message to notification window. Usage: :Notify <message> [info|warn|error]',
			},
		},
	},
}

local config = require('adoyle-neovim-config.config').config
local symbolMap = config.symbolMap

M.defaultConfig = {
	'notify',
	{
		background_colour = config.colors.black,
		fps = 30,
		icons = {
			ERROR = symbolMap.ERROR,
			WARN = symbolMap.WARN,
			INFO = symbolMap.INFO,
			DEBUG = symbolMap.DEBUG,
			TRACE = symbolMap.TRACE,
		},
		level = 2,
		minimum_width = 50,
		render = 'default',
		stages = 'fade_in_slide_out',
		timeout = 2000,
		top_down = true,
	},
}

function M.config()
	vim.notify = require('notify')
	vim.notify.setup(config.notify)
end

return M
