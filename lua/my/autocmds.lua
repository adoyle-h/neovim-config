return {
	VimLeave = {
		pattern = '*',
		callback = function()
			-- when nvim exit, reset the cursor shape to blinking bar
			vim.opt.guicursor = 'a:ver20'
		end,
	},
}
