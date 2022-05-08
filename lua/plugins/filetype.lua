local M = {
	'nathom/filetype.nvim',
	desc = 'filetype detection',
	disable = false,
	requires = {},
}

function M.config()
	-- use lua filetype detection instead of vim filetype detection
	vim.g.do_filetype_lua = true
	vim.g.did_load_filetypes = true

	require('filetype').setup({
		overrides = {

			-- Set the filetype based on file extension
			extensions = {
				-- *.cocoascript files set filetype javascript
				cocoascript = 'javascript',
			},

			-- Set the filetype based on filename
			literal = {
				bash_profile = 'sh',
				profile = 'sh',
			},

			complex = {
				-- Set the filetype of any full filename matching the regex to gitconfig
				[".*git/config"] = "gitconfig", -- Included in the plugin
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
	})
end

return M
