local M = {}

M.config = function()
	local has_nullLS, nullLS = pcall(require, 'null-ls')
	if not has_nullLS then return {} end

	local builtins = nullLS.builtins

	return {
		-- Available null-ls sources list
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		-- How to config null-ls sources:
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		sources = {
			builtins.completion.spell,

			-- eslint_d is a daemon so that it will cache eslint and eslint-plugins.
			-- You may need to run "eslint_d restart" or kill eslint_d process to update cache while in trouble.
			-- See https://github.com/mantoni/eslint_d.js#what-if-eslint-or-a-plugin-is-updated
			-- The eslint_d filepath is ~/.local/share/nvim/mason/bin/eslint_d

			require('none-ls.code_actions.eslint_d').with {
				prefer_local = 'node_modules/.bin',
			},

			require('none-ls.diagnostics.eslint_d').with {
				prefer_local = 'node_modules/.bin',
			},

			-- Formatters run in the order in which you register them.
			require('none-ls.formatting.eslint_d').with {
				prefer_local = 'node_modules/.bin',
			},

			-- require('none-ls-external-sources.code_actions.shellcheck'),
			-- https://github.com/gbprod/none-ls-shellcheck.nvim
			require('none-ls-shellcheck.code_actions'),
			-- require('none-ls-shellcheck.diagnostics'), -- It is duplicated with bashls, so no need to use it

			-- Using `with` to change builtin configuration
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#configuration
			builtins.diagnostics.editorconfig_checker.with { disabled_filetypes = { 'gitcommit' } },

			-- formatting.prettierd.with {
			--     disabled_filetypes = { 'markdown' },
			--     prefer_local = 'node_modules/.bin',
			-- },
		},
	}
end

M.plugins = {
	deps = {
		'gbprod/none-ls-shellcheck.nvim',
		-- 'zeioth/none-ls-external-sources.nvim',
	},
}

return M
