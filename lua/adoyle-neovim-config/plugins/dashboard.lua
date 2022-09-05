local M = {
	'goolord/alpha-nvim',
	desc = 'Dashboard',
	disable = false,
	-- requires = {},
}

function M.config()
	local alpha = require('alpha')
	local dashboard = require('alpha.themes.dashboard')
	local section = dashboard.section
	local fn = vim.fn

	local config = dashboard.config
	config.opts.noautocmd = true

	section.header.val = {
		[[                               __                ]],
		[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
		[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
		[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}

	section.buttons.val = {
		dashboard.button('<SPACE>m', '  File Explorer', ':NvimTreeToggle<CR>'),
		dashboard.button('e', '  New File', ':ene <BAR> <CR>'),
		dashboard.button('r', '  Recently Opened Files', ':Telescope oldfiles<CR>'),
		dashboard.button('<SPACE>f', '  Search File', ':Telescope find_files<CR>'),
		dashboard.button('<SPACE>k', '  Search Keymaps', ':Telescope keymaps<CR>'),
		dashboard.button('<SPACE>p', 'גּ  Run Command', ':Telescope commands<CR>'),
		dashboard.button('<SPACE>P', '  List Plugin Status', ':PlugStatus<CR>'),
		dashboard.button('<SPACE>h', 'ﲉ  Find Help', ':Telescope help_tags<CR>'),
		dashboard.button('q', '  Quit', ':qa<CR>'),
	}

	local marginTopPercent = 0.2
	local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

	config.layout = {
		{ type = 'padding', val = headerPadding },
		section.header,
		{ type = 'padding', val = 2 },
		section.buttons,
		section.footer,
	}

	alpha.setup(config)

	vim.cmd 'autocmd User AlphaReady set cursorline'
	-- vim.cmd 'autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2'
end

return M
