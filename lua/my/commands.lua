return {
	RegisterToClipboard = function()
		local val = vim.fn.getreg('"')
		vim.fn.setreg('*', val)
	end,
}
