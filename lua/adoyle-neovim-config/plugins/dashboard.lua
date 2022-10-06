local M = { 'goolord/alpha-nvim', desc = 'Dashboard' }

function M.config(config)
	require('alpha').setup(config.dashboard)

	vim.api.nvim_create_autocmd('User', {
		pattern = { 'AlphaReady' },
		callback = function()
			vim.opt.cursorline = true
			vim.opt.showtabline = 0
		end,
	})

	vim.api.nvim_create_autocmd('User', {
		pattern = { 'AlphaClosed' },
		callback = function()
			vim.opt.showtabline = 2
		end,
	})
end

M.defaultConfig = function()
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
		dashboard.button('<SPACE>r', '  Recently Opened Files', ':Telescope oldfiles<CR>'),
		dashboard.button('<SPACE>f', '  Search File', ':Telescope find_files<CR>'),
		dashboard.button('<SPACE>/', '  Search Contents', ':Telescope live_grep<CR>'),
		dashboard.button('<SPACE>k', '  Search Keymaps', ':Telescope keymaps<CR>'),
		dashboard.button('<SPACE>p', 'גּ  Run Command', ':Telescope commands<CR>'),
		dashboard.button('<SPACE>P', '  List Plugin Status', ':PlugStatus<CR>'),
		dashboard.button('<SPACE>v', '  List Vim Options', ':Telescope vim_options<CR>'),
		dashboard.button('<SPACE>n', '  List Notifications', ':Telescope notify<CR>'),
		dashboard.button('<SPACE>h', 'ﲉ  Find Help', ':Telescope help_tags<CR>'),
		dashboard.button('q', '  Quit', ':qa<CR>'),
	}

	local keymap = vim.api.nvim_get_keymap('n');
	for _, key in pairs(keymap) do
		if key.lhs == ' m' then
			table.insert(section.buttons.val, 1, dashboard.button('<SPACE>m', '  File Explorer', key.rhs))
			break
		end
	end

	local marginTopPercent = 0.12
	local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

	config.layout = {
		{ type = 'padding', val = headerPadding },
		section.header,
		{ type = 'padding', val = 2 },
		section.buttons,
		section.footer,
	}

	return { 'dashboard', config }
end

return M
