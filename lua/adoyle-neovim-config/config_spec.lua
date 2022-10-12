local CM = require('adoyle-neovim-config.config')

describe('CM.config', function()
	it('CM.setup()', function()
		CM.setup({
			colorcolumn = { 80, 100 },

			proxy = { github = 'https://ghproxy.com/' },

			lsp = {
				ensureInstalled = { 'css-lsp', 'yamlfmt' },

				nullLS = {
					sources = function(builtins)
						local code_actions = builtins.code_actions
						local diagnostics = builtins.diagnostics
						local formatting = builtins.formatting

						return {
							code_actions.eslint_d,
							diagnostics.eslint_d,
							formatting.eslint_d,
							formatting.prettierd,
						}
					end,
				},
			},
		})

		local config = CM.config

		assert.are.same(config.proxy, { github = 'https://ghproxy.com/' })
		assert.are.same(config.lsp.ensureInstalled, { 'css-lsp', 'yamlfmt' })

		local null_ls = require('null-ls')
		local builtins = null_ls.builtins
		local sources = config.lsp.nullLS.sources(builtins) or {}

		local code_actions = builtins.code_actions
		local diagnostics = builtins.diagnostics
		local formatting = builtins.formatting

		assert.are.same(sources, {
			code_actions.eslint_d,
			diagnostics.eslint_d,
			formatting.eslint_d,
			formatting.prettierd,
		})
	end)
end)
