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
