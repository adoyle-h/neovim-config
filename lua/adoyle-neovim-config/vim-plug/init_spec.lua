local P = require('adoyle-neovim-config.vim-plug')

describe('setup()', function()
	it('user plugins', function()
		P.setup({ userPlugins = { { 'profiling', disable = false } } })

		P.Plug({
			'profiling',
			desc = 'Profiling tools',
			disable = true,
			requires = { --
				{ 'dstein64/vim-startuptime', desc = 'Launch vim-startuptime with :StartupTime' },
			},
		})

		local globals = require('adoyle-neovim-config.vim-plug.globals')
		local plugMap = globals.plugMap

		assert.are.same(plugMap['profiling'], {
			id = 'profiling',
			desc = 'Profiling tools',
			disable = false,
			requires = { --
				{
					id = 'dstein64/vim-startuptime',
					repo = 'dstein64/vim-startuptime',
					desc = 'Launch vim-startuptime with :StartupTime',
				},
			},
		})
	end)
end)
