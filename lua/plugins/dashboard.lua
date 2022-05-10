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
		dashboard.button('e', '  New File', ':ene <BAR> <CR>'),
		dashboard.button('<SPACE>f', '  Search File', ':Telescope find_files hidden=true<CR>'),
		dashboard.button('<SPACE>m', '  File Explorer', ':NERDTreeMirrorToggle<CR>'),
		dashboard.button('<SPACE>k', '  Search Keymaps', ':Telescope keymaps<CR>'),
		dashboard.button('<SPACE>p', 'גּ  Run Command', ':Telescope commands<CR>'),
		dashboard.button('<SPACE>P', '  Plugin List', ':PlugStatus<CR>'),
		dashboard.button('<SPACE>h', 'ﲉ  Find Help', ':Telescope help_tags<CR>'),
		dashboard.button('q', '  Quit', ':qa<CR>'),
	}

	-- What is the fortune?
	-- local handle = io.popen('fortune')
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- dashboard.section.footer.val = fortune

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

	vim.cmd [[
		autocmd User AlphaReady set cursorline
		autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
	]]
end

return M
