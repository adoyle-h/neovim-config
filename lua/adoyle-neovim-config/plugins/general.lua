local M = { nil, desc = 'General functions and commands', disable = false }

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
			local CM = require('adoyle-neovim-config.config')
			vim.notify('userSetup=' .. vim.inspect(CM.userSetup))
			vim.notify('config=' .. vim.inspect(CM.config))
		end,
		{ desc = 'Show the config of adoyle-neovim-config' },
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
