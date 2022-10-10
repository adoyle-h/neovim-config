local M = { 'goolord/alpha-nvim', desc = 'Dashboard' }

local function Title(val)
	return {
		type = 'text',
		val = val,
		opts = { position = 'center', cursor = 5, width = 100, hl = 'Title' },
	}
end

local function getSessions(conf)
	local printf = vim.fn.printf
	local pwd = vim.fn.getcwd()
	local sessionLimit = conf.sessionLimit

	local ok, persisted = pcall(require, 'persisted')
	if not ok then return {} end

	local utils = require('persisted.utils')

	local sessions = { Title('Sessions') }

	local i = 0
	for _, session in pairs(persisted.list()) do
		local path = session.file_path
		local isContained = path:find(pwd:gsub('/', '%%'), 1, true)

		if i > sessionLimit then break end

		if isContained then
			i = i + 1

			local splits = vim.split(session.name, '_', { plain = true })
			local branch = table.remove(splits, #splits)
			local sessionName = vim.fn.join(splits, '_')

			table.insert(sessions, {
				type = 'button',
				val = printf('%s ( %s)', sessionName, branch),

				on_press = function()
					local key = vim.api.nvim_replace_termcodes('' .. i .. '<Ignore>', true, false, true)
					vim.api.nvim_feedkeys(key, 't', false)
				end,

				opts = {
					position = 'center',
					shortcut = printf(' %s ', i),
					cursor = 2,
					width = 50,
					align_shortcut = 'left',
					hl_shortcut = { { 'Keyword', 0, 2 } },
				},
			})

			vim.keymap.set('n', '' .. i, function()
				utils.load_session(path, nil, nil, true)
			end, { buffer = 0, noremap = true, silent = true, nowait = true })
		end
	end

	if i == 0 then return { type = 'padding', val = 0 } end

	table.insert(sessions, { type = 'padding', val = 1 })

	return { type = 'group', val = sessions, opts = { spacing = 0 } }
end

function M.config(config)
	local conf = config.dashboard

	table.insert(config.dashboard.layout, 4, getSessions(conf))

	require('alpha').setup { layout = conf.layout, opts = conf.opts }

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
	local fn = vim.fn
	local dashboard = require('alpha.themes.dashboard')
	local button = dashboard.button

	local header = {
		type = 'text',
		val = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		},
		opts = {
			position = 'center',
			hl = 'Type',
			-- wrap = "overflow";
		},
	}

	local buttons = {
		type = 'group',
		val = {
			button('e', '  New File', ':ene <BAR> <CR>'),
			button('<SPACE>m', '  File Explorer', ':Neotree toggle<CR>'),
			button('<SPACE>r', '  Recently Opened Files', ':Telescope oldfiles<CR>'),
			button('<SPACE>f', '  Search File', ':Telescope find_files<CR>'),
			button('<SPACE>/', '  Search Contents', ':Telescope live_grep<CR>'),
			button('<SPACE>s', '  List Sessions', ':Telescope persisted<CR>'),
			button('<SPACE>k', '  List Keymaps', ':Telescope keymaps<CR>'),
			button('<SPACE>p', 'גּ  Run Command', ':Telescope commands<CR>'),
			button('<SPACE>P', '  List Plugin Status', ':PlugStatus<CR>'),
			button('<SPACE>v', '  List Vim Options', ':Telescope vim_options<CR>'),
			button('<SPACE>n', '  List Notifications', ':Telescope notify<CR>'),
			button('<SPACE>h', 'ﲉ  Find Help', ':Telescope help_tags<CR>'),
			button('q', '  Quit', ':qa<CR>'),
		},
		opts = { spacing = 0 },
	}

	local marginTopPercent = 0.12
	local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

	return {
		'dashboard',
		{
			sessionLimit = 9,
			layout = {
				{ type = 'padding', val = headerPadding },
				header,
				{ type = 'padding', val = 2 },
				Title('Press j,k to move cursor'),
				buttons,
			},
			opts = { margin = 5, noautocmd = true },
		},
	}
end

return M
