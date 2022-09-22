local create_command = vim.api.nvim_create_user_command

create_command('OpenGithub', function()
	local text = vim.fn.expand('<cfile>')
	vim.fn.OpenBrowser('https://github.com/' .. text)
end, { desc = 'Open github url in browser' })

create_command('ShowConfig', function()
	local CM = require('adoyle-neovim-config.config')
	vim.notify('userSetup=' .. vim.inspect(CM.userSetup))
	vim.notify('config=' .. vim.inspect(CM.config))
end, { desc = 'Show the config of adoyle-neovim-config' })

create_command('DetachLspClientFromBuffer', function()
	local buf = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients({ bufnr = buf })

	local Menu = require('nui.menu')
	local event = require('nui.utils.autocmd').event

	local lines = {}
	for _, client in pairs(clients) do
		table.insert(lines, Menu.item(client.name)) --
	end

	local menu = Menu({
		position = '50%',
		size = { width = 25, height = 5 },
		border = { style = 'single', text = { top = '[Choose-an-Element]', top_align = 'center' } },
		win_options = { winhighlight = 'Normal:Normal,FloatBorder:Normal' },
	}, {
		lines = {
			Menu.item('Hydrogen (H)'),
			Menu.item('Carbon (C)'),
			Menu.item('Nitrogen (N)'),
			Menu.separator('Noble-Gases', { char = '-', text_align = 'right' }),
			Menu.item('Helium (He)'),
			Menu.item('Neon (Ne)'),
			Menu.item('Argon (Ar)'),
		},
		max_width = 20,
		keymap = {
			focus_next = { 'j', '<Down>', '<Tab>' },
			focus_prev = { 'k', '<Up>', '<S-Tab>' },
			close = { '<Esc>', '<C-c>' },
			submit = { '<CR>', '<Space>' },
		},
		on_close = function()
			print('Menu Closed!')
		end,
		on_submit = function(item)
			print('Menu Submitted: ', item.text)
			vim.lsp.buf_detach_client(buf, clientId)
		end,
	})

	-- mount the component
	menu:mount()
end, { desc = '' })
