local CM = require('adoyle-neovim-config.config')

describe('CM.config', function()
	CM.setup({
		config = {
			colorcolumn = { 80, 100 },

			proxy = { github = 'https://ghproxy.com/' },

			pluginOpts = { ['plugins.profiling'] = { disable = false } },

			plugins = {},

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

		},
	})

	local config = CM.config

	it('config.proxy', function()
		assert.are.same(config.proxy, { github = 'https://ghproxy.com/' })
	end)

	it('config.lsp.ensureInstalled', function()
		assert.are.same(config.lsp.ensureInstalled, { 'css-lsp', 'yamlfmt' })
	end)

	it('config.lsp.nullLS.sources', function()
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
