return {
	'olimorris/persisted.nvim',

	config = function(config)
		require('persisted').setup(config.persisted)

		if pcall(require, 'telescope') then
			require('telescope').load_extension('persisted') -- To load the telescope extension
		end
	end,

	defaultConfig = {
		'persisted',
		{
			save_dir = vim.fn.stdpath('data') .. '/sessions/', -- directory where session files are saved
			command = 'VimLeavePre', -- the autocommand for which the session is saved
			silent = false, -- silent nvim message when sourcing session file
			use_git_branch = false, -- create session files based on the branch of the git enabled repository
			branch_separator = '_', -- string used to separate session directory name from branch name
			autosave = true, -- automatically save session files when exiting Neovim
			autoload = false, -- automatically load the session for the cwd on Neovim startup
			on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
			allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
			ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
			before_save = function() -- function to run before the session is saved to disk
				pcall(vim.cmd, 'NeoTreeClose')
			end,
			after_save = nil, -- function to run after the session is saved to disk
			after_source = nil, -- function to run after the session is sourced
			telescope = { -- options for the telescope extension
				before_source = nil, -- function to run before the session is sourced via telescope
				after_source = nil, -- function to run after the session is sourced via telescope
			},
		},
	},
}
