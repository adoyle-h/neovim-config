return {
	'LinArcX/telescope-env.nvim',

	-- keymaps
	-- <cr>	  append environment name to buffer
	-- <c-a>	append environment value to buffer
	-- <c-e>	edit environment value(for the current session)

	config = function()
		require('telescope').load_extension('env')
	end,
}
