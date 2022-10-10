return {
	'olimorris/persisted.nvim',

	keymaps = { { 'n', '<space>s', ':Telescope persisted<CR>', { silent = true } } },

	config = function(config)
		local opts = config.persisted

		opts.should_autosave = function()
			return not vim.tbl_contains(opts.ignored_filetypes, vim.bo.filetype)
		end

		require('persisted').setup(opts)

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

			ignored_filetypes = { 'alpha' },

			before_save = function() -- function to run before the session is saved to disk
				pcall(vim.cmd, 'NeoTreeClose')
				pcall(vim.cmd, 'AerialClose')
				pcall(vim.cmd, 'MundoHide')
			end,

			after_save = nil, -- function to run after the session is saved to disk

			after_source = nil, -- function to run after the session is sourced

			telescope = { -- options for the telescope extension
				-- function to run before the session is sourced via telescope
				before_source = function()
					vim.api.nvim_input('<ESC>:%bd<CR>') -- Close all open buffers
					vim.lsp.stop_client(vim.lsp.get_active_clients())
				end,

				-- function to run after the session is sourced via telescope
				after_source = function(session)
					print('Loaded session: ' .. session.name)
				end,
			},
		},
	},
}
