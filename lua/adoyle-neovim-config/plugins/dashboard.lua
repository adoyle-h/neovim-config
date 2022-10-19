local M = {
	--	'goolord/alpha-nvim'
	'adoyle-h/alpha-nvim',
	desc = 'Dashboard',
}

local printf = string.format

local function getTitle(val)
	return {
		type = 'text',
		val = val,
		opts = { position = 'center', cursor = 5, width = 100, hl = 'Title' },
	}
end

local function makePressFn(i)
	return function()
		local key = vim.api.nvim_replace_termcodes('' .. i .. '<Ignore>', true, false, true)
		vim.api.nvim_feedkeys(key, 't', false)
	end
end

local function makeKeymap(sess, load_session)
	return function()
		load_session(sess.path, nil, nil, true)
	end
end

local function formatSessions(sessions)
	local load_session = require('persisted.utils').load_session

	table.sort(sessions, function(prev, next)
		return #prev.val < #next.val
	end)

	local longest = #sessions[#sessions].val

	for i, sess in pairs(sessions) do --
		sess.val = sess.val .. string.rep(' ', longest - #sess.val)
		sess.on_press = makePressFn(i)

		sess.opts.shortcut = printf(' %s ', i)
		vim.keymap.set('n', '' .. i, makeKeymap(sess, load_session),
			{ buffer = 0, noremap = true, silent = true, nowait = true })
	end

	return longest
end

local function getSessions(conf)
	local pwd = vim.fn.getcwd()
	local sessionLimit = conf.sessionLimit

	local ok, persisted = pcall(require, 'persisted')
	if not ok then return {} end

	local sessions = {}

	local i = 1
	for _, session in pairs(persisted.list()) do
		local path = session.file_path
		local isContained = path:find(pwd:gsub('/', '%%'), 1, true)

		if i > sessionLimit then break end

		if isContained then
			local splits = vim.split(session.name, '_', { plain = true })
			local branch = table.remove(splits, #splits)
			local sessionName = vim.fn.join(splits, '_')

			table.insert(sessions, {
				type = 'button',
				val = printf('%s ( %s)', sessionName, branch),
				path = path,

				opts = {
					position = 'center',
					-- shortcut = printf(' %s ', i),
					cursor = 2,
					width = 50,
					align_shortcut = 'left',
					hl_shortcut = { { 'Keyword', 0, 2 } },
				},
			})

			i = i + 1
		end
	end

	if i == 1 then return { type = 'padding', val = 0 } end

	local longest = formatSessions(sessions)

	if i > sessionLimit then
		local text = '[More Sessions]'

		if longest > #text then text = text .. string.rep(' ', longest - #text - 2) end

		table.insert(sessions, {
			type = 'button',
			val = text,
			on_press = function()
				vim.api.nvim_feedkeys('0', 't', false)
			end,

			opts = {
				position = 'center',
				shortcut = ' 0 ',
				cursor = 2,
				width = 50,
				align_shortcut = 'left',
				hl_shortcut = { { 'Keyword', 0, 2 } },
			},
		})

		vim.keymap.set('n', '0', ':ListSessions<CR>',
			{ buffer = 0, noremap = true, silent = true, nowait = true })
	end

	table.insert(sessions, 1, getTitle('Sessions'))
	table.insert(sessions, { type = 'padding', val = 1 })

	return { type = 'group', val = sessions, opts = { spacing = 0 } }
end

-- Copy from https://github.com/goolord/alpha-nvim/blob/09e5374465810d71c33e9b097214adcdebeee49a/lua/alpha.lua#L512
local function should_skip_alpha()
	-- don't start when opening a file
	if vim.fn.argc() > 0 then return true end

	-- skip stdin
	if vim.fn.line2byte('$') ~= -1 then return true end

	-- Handle nvim -M
	if not vim.o.modifiable then return true end

	for _, arg in pairs(vim.v.argv) do
		-- whitelisted arguments
		-- always open
		if arg == '--startuptime' then return false end

		-- blacklisted arguments
		-- always skip
		if arg == '-b' -- commands, typically used for scripting
		or arg == '-c' or vim.startswith(arg, '+') or arg == '-S' then return true end
	end

	-- base case: don't skip
	return false
end

function M.config(config)
	if should_skip_alpha() then
		-- If not skip, the buf_set_keymap by alpha.nvim will affect current file buffer when nvim open a file directly.
		return
	end

	local conf = config.dashboard

	local layout = conf.layout
	local index
	for i = 1, #layout do
		if layout[i].val == 'Press j,k to move cursor' then
			index = i
			break
		end
	end

	table.insert(layout, index or 1, getSessions(conf))

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

local function getVersion()
	local info = vim.version()
	local val = printf('Version: %s.%s.%s', info.major, info.minor, info.patch)

	if info.prerelease then val = val .. ' (prerelease)' end
	return { type = 'text', val = val, opts = { position = 'center', hl = 'DashboardVersion' } }
end

local function getHeader()
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
		opts = { position = 'center', hl = 'DashboardLogo' },
	}

	return {
		type = 'group',
		val = { header, getVersion(), { type = 'padding', val = 1 } },
		opts = { spacing = 0 },
	}
end

M.defaultConfig = function()
	local dashboard = require('alpha.themes.dashboard')
	local button = dashboard.button

	local buttons = {
		type = 'group',
		val = {
			button('e', '  New File', ':ene <BAR> <CR>'),
			button('<SPACE>m', '  File Explorer', ':Neotree toggle<CR>'),
			button('<SPACE>r', '  Recently Opened Files', ':Telescope oldfiles<CR>'),
			button('<SPACE>f', '  Search File', ':Telescope find_files<CR>'),
			button('<SPACE>/', '  Search Contents', ':Telescope live_grep<CR>'),
			button('<SPACE>k', '  List Keymaps', ':Telescope keymaps<CR>'),
			button('<SPACE>s', '  List Sessions', ':ListSessions<CR>'),
			button('<SPACE>p', 'גּ  Run Command', ':Telescope commands<CR>'),
			button('<SPACE>P', '  List Plugin Status', ':PlugStatus<CR>'),
			button('<SPACE>v', '  List Vim Options', ':Telescope vim_options<CR>'),
			button('<SPACE>n', '  List Notifications', ':Telescope notify<CR>'),
			button('<SPACE>h', 'ﲉ  Find Help', ':Telescope help_tags<CR>'),
			button('q', '  Quit', ':qa<CR>'),
		},
		opts = { spacing = 0 },
	}

	local fn = vim.fn
	local marginTopPercent = 0.1
	local marginTop = fn.max({ 1, fn.floor(fn.winheight(0) * marginTopPercent) })

	return {
		'dashboard',
		{
			sessionLimit = 9,
			layout = {
				{ type = 'padding', val = marginTop },
				getHeader(),
				getTitle('Press j,k to move cursor'),
				buttons,
			},
			opts = { noautocmd = true },
		},
	}
end

M.highlights = function(config)
	local colors = config.colors
	return { DashboardVersion = { fg = '#333567' }, DashboardLogo = { fg = colors.blue } }
end

return M
