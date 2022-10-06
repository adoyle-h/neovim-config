local M = { 'nathom/filetype.nvim', desc = 'filetype detection' }

M.defaultConfig = {
	'filetype',
	{
		-- Use lua filetype detection instead of vim filetype detection
		-- If true, neither the default `$VIMRUNTIME/filetype.lua` nor the legacy `$VIMRUNTIME/filetype.vim` will run.
		disableNvimBuiltin = true,

		callbacks = {
			js = function()
				-- vim.cmd 'set isk-=.'
				vim.opt_local.isk:remove{ '.' }
			end,

			jsx = function()
				-- vim.cmd 'set isk-=.'
				vim.opt_local.isk:remove{ '.' }
			end,

			crontab = function()
				vim.opt_local.backup = false
				vim.opt_local.writebackup = false
			end,

			['null-ls-info'] = function()
				vim.api.nvim_win_set_config(0, { border = 'rounded', height = 30 })
			end,

		},

		overrides = {

			-- Set the filetype based on file extension
			extensions = {
				-- *.cocoascript files set filetype javascript
				cocoascript = 'javascript',
			},

			-- Set the filetype based on filename
			literal = { bash_profile = 'sh', profile = 'sh' },

			complex = {
				-- Set the filetype of any full filename matching the regex to gitconfig
				['.*git/config'] = 'gitconfig', -- Included in the plugin
			},

			-- shebang = {
			--   -- Set the filetype of files with a dash shebang to sh
			--   dash = "sh",
			-- },

			-- The same as the ones above except the keys map to functions
			-- function_extensions = {
			--   cpp = function()
			--     vim.bo.filetype = "cpp"
			--     -- Remove annoying indent jumping
			--     vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
			--   end,

			--   jsx = function()
			--     vim.bo.filetype = "pdf"
			--     -- Open in PDF viewer (Skim.app) automatically
			--     vim.fn.jobstart(
			--       "open -a skim " .. '"' .. vim.fn.expand("%") .. '"'
			--     )
			--   end,
			-- },

			-- function_literal = {
			--   Brewfile = function()
			--     vim.cmd("syntax off")
			--   end,
			-- },

			-- function_complex = {
			--   ["*.math_notes/%w+"] = function()
			--     vim.cmd("iabbrev $ $$")
			--   end,
			-- },
		},

	},
}

function M.config(config)
	local conf = config.filetype

	vim.g.did_load_filetypes = conf.disableNvimBuiltin

	require('filetype').setup({ overrides = conf.overrides })

	local callbacks = config.filetype.callbacks
	vim.api.nvim_create_autocmd('FileType', {
		callback = function(args)
			local fn = callbacks[args.match]
			if fn then fn() end
		end,
	})
end

return M
