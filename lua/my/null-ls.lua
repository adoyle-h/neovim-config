return function()
	local has_null, nullLS = pcall(require, 'null-ls')
	if not has_null then return {} end

	local builtins = nullLS.builtins
	local codeActions = builtins.code_actions
	local diagnostics = builtins.diagnostics
	local formatting = builtins.formatting

	return {
		-- Available null-ls sources list
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		-- How to config null-ls sources:
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		sources = {
			codeActions.eslint_d,
			codeActions.shellcheck,

			-- Using `with` to change builtin configuration
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#configuration
			diagnostics.editorconfig_checker.with {
				-- Fix: https://github.com/editorconfig-checker/editorconfig-checker/issues/232
				-- and  https://github.com/williamboman/mason.nvim/issues/870
				command = 'editorconfig-checker', -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/ef3d4a438f96865e3ae018e33ed30156a955ed00/doc/BUILTIN_CONFIG.md#using-local-executables
				disabled_filetypes = { 'gitcommit' },
			},

			diagnostics.eslint_d,
			-- diagnostics.shellcheck, -- It is duplicated with bashls

			-- Formatters run in the order in which you register them.
			formatting.eslint_d.with {
				-- eslint_d is a daemon so that it will cache eslint and eslint-plugins.
				-- You may need to run "eslint_d restart" or kill eslint_d process to update cache while in trouble.
				-- See https://github.com/mantoni/eslint_d.js#what-if-eslint-or-a-plugin-is-updated
				-- The eslint_d filepath is ~/.local/share/nvim/mason/bin/eslint_d
				prefer_local = 'node_modules/.bin',
			},

			-- formatting.prettierd.with {
			--     disabled_filetypes = { 'markdown' },
			--     prefer_local = 'node_modules/.bin',
			-- },

			-- formatting.shfmt, -- not good
			formatting.lua_format,
			formatting.zigfmt,
		},
	}
end
