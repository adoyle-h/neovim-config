local PM = require('adoyle-neovim-config.plugin-manager')

describe('Plug()', function()
	before_each(function()
		PM.clean()
	end)

	it('Plug("github/repo")', function()
		PM.Plug({ 'github/repo', desc = 'repo' })

		assert.are.same({ --
			id = 'github/repo',
			repo = 'github/repo',
			desc = 'repo',
			disable = true,
			uninstalled = true,
			reason = 'uninstalled',
		}, PM.plugMap['github/repo'])
	end)

	it('Plug({ desc = "no repo" })', function()
		PM.Plug({ desc = 'no repo' })

		assert.are.same({ id = 1, desc = 'no repo' }, PM.plugMap[1])
	end)

	it('Plug("p")', function()
		PM.Plug({
			'p',
			desc = 'P',
			disable = true,
			requires = {
				{ --
					'p2',
				},
			},
		})

		assert.are.same({
			id = 'p',
			desc = 'P',
			disable = true,
			requires = {
				{ -- no parse requires when parent plugin is disabled
					'p2',
				},
			},
		}, PM.plugMap['p'])
	end)
end)
