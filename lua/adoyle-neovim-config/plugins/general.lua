local M = { nil, desc = 'General functions and commands' }

local CM = require('adoyle-neovim-config.config')
local api = vim.api

local function createConfigWindow(bufName)
	vim.cmd.vsplit()
	local win = api.nvim_get_current_win()
	local buf = api.nvim_create_buf(true, true)

	api.nvim_buf_set_name(buf, bufName)
	api.nvim_buf_set_option(buf, 'filetype', 'lua')
	api.nvim_buf_set_option(buf, 'sw', 2)
	api.nvim_buf_set_option(buf, 'ts', 2)

	api.nvim_win_set_option(win, 'foldmethod', 'indent')
	api.nvim_win_set_option(win, 'foldlevel', 1)
	api.nvim_win_set_option(win, 'cc', '')

	api.nvim_win_set_buf(win, buf)
	vim.cmd 'vertical resize 80'

	local row = 0
	local write = function(content)
		api.nvim_buf_set_lines(buf, row, row, true, { content })
		row = row + 1
	end

	local write2 = function(content)
		local text = vim.split(vim.inspect(content), '\n')
		api.nvim_buf_set_lines(buf, row, row, true, text)
		row = row + #text
	end

	write('-- The content generated by :ShowConfig')

	return write, write2, win
end

M.commands = {
	{ 'Q', ':q!', { desc = 'quit current buffer without saving' } },
	{ 'Qa', ':qa!', { desc = 'quit all buffers without saving' } },
	{ 'CD', ':lcd %:p:h', { desc = 'Change PWD in current buffer' } },

	{
		'Cheatsheet',
		function()
			local lang = table.unpack(vim.split(string.lower(vim.v.lang), '.', { plain = true }))
			local url = 'https://vim.rtorr.com/lang/' .. lang
			vim.fn['openbrowser#open'](url)
		end,
		{ desc = 'Open vim cheatsheet in browser' },
	},

	{
		'GetWinConfig',
		function()
			vim.notify(vim.inspect(vim.api.nvim_win_get_config(0)))
		end,
		{ desc = 'Print current window config' },
	},

	{
		'FixLineBreak',
		function()
			vim.cmd [[
				e ++ff=dos
				set ff=unix
				w
			]]
		end,
		{},
	},

	{
		'ProfileStart',
		function()
			vim.cmd [[
				profile start profile.log
				profile func *
				profile file *
			]]
		end,
		{ desc = 'ProfileStart/ProfileEnd' },
	},

	{
		'ProfileEnd',
		function()
			vim.cmd ':profile pause'
		end,
		{ desc = 'ProfileStart/ProfileEnd' },
	},

	{
		'OpenGithub',
		function()
			local text = vim.fn.expand('<cfile>')
			vim.fn.OpenBrowser('https://github.com/' .. text)
		end,
		{ desc = 'Open github url in browser' },
	},

	{
		'ShowConfig',
		function()
			local write, writeVal, win = createConfigWindow('[ADoyle-Neovim-Configs]')
			write('-- config --')

			local config = vim.tbl_extend('keep', CM.config, {})
			writeVal(config)

			api.nvim_win_set_cursor(win, { 1, 0 })
		end,
		{ desc = 'Show the merged config of adoyle-neovim-config' },
	},

	{
		'ShowPlugins',
		function()
			local write, writeVal, win = createConfigWindow('[ADoyle-Neovim-Plugins]')
			local P = require('adoyle-neovim-config.vim-plug')
			write('-- plugins --')
			writeVal(P.plugs)

			api.nvim_win_set_cursor(win, { 1, 0 })

			-- local write1, writeVal1, win1 = createConfigWindow()
			-- write1('-- userSetup --')
			-- writeVal1(CM.userSetup)
			-- api.nvim_win_set_cursor(win1, { 1, 0 })
		end,
		{ desc = 'Show plugins of adoyle-neovim-config' },
	},

	{
		'DetachLspClientFromBuffer',
		function()
			local buf = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_active_clients({ bufnr = buf })

			local Menu = require('nui.menu')

			local lines = {}
			for _, client in pairs(clients) do
				table.insert(lines, Menu.item(client.name, { clientId = client.id })) --
			end

			local menu = Menu({
				position = '50%',
				size = { width = 25, height = 5 },
				border = { style = 'single', text = { top = '[Attached LSP Clients]', top_align = 'center' } },
				win_options = { winhighlight = 'Normal:Normal,FloatBorder:Normal' },
			}, {
				lines = lines,
				max_width = 20,

				keymap = {
					focus_next = { 'j', '<Down>', '<Tab>' },
					focus_prev = { 'k', '<Up>', '<S-Tab>' },
					close = { '<Esc>', 'q' },
					submit = { '<CR>' },
				},

				on_submit = function(item)
					vim.lsp.buf_detach_client(buf, item.clientId)
				end,
			})

			-- mount the component
			menu:mount()
		end,
		{ desc = '' },
	},
}

return M
