vim.api.nvim_create_user_command('OpenGithub', function()
	local text = vim.fn.expand('<cfile>')
	vim.fn.OpenBrowser('https://github.com/' .. text)
end, { desc = 'Open github url in browser' })
