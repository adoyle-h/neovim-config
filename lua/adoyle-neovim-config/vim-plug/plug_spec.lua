local M = require('adoyle-neovim-config.vim-plug.plug')

describe('mergePlugConfig()', function()
	local mergePlugConfig = M.mergePlugConfig

	it('"a"', function()
		local plugDefaultConfig = { defaultConfig = { 'a', { hello = 'world' } } }
		local src = {}
		mergePlugConfig(src, plugDefaultConfig)
		assert.are.same({ a = { hello = 'world' } }, src)
	end)

	it('{"a"}', function()
		local plugDefaultConfig = { defaultConfig = { { 'a' }, { hello = 'world' } } }
		local src = {}
		mergePlugConfig(src, plugDefaultConfig)
		assert.are.same({ a = { hello = 'world' } }, src)
	end)

	it('{"a", "b"}', function()
		local plugDefaultConfig = { defaultConfig = { { 'a', 'b' }, { hello = 'world' } } }
		local src = {}
		mergePlugConfig(src, plugDefaultConfig)
		assert.are.same({ a = { b = { hello = 'world' } } }, src)
	end)
end)

describe('usePlug()', function()
	local usePlug = M.usePlug
	local plugs = {}
	local plugMap = {}
	local userPlugins = {}
	local g = { count = 0, plugs = plugs, plugMap = plugMap, userPlugins = userPlugins }

	usePlug(g, 'g/a')
	usePlug(g, 'g/b', { desc = 'b' })
	usePlug(g, { 'g/c', desc = 'c' })
	usePlug(g, { desc = 'd' })
	usePlug(g, { 'e', desc = 'e' })
	usePlug(g, { 'g/f', requires = {} })
	usePlug(g, { 'g/g', requires = { 'g/g1', { 'g/g2' } } })
	usePlug(g, { 'g/h', requires = { 'g/h1', { 'g/h2', disable = true } } })

	it('plugMap', function()
		assert.are.same({
			id = 'g/a',
			repo = 'g/a',
			disable = true,
			uninstalled = true,
			reason = 'uninstalled',
		}, plugMap['g/a'])
	end)

	it('plugs', function()
		assert.are.same(12, #plugs)
		assert.are.same('g/a', plugs[1].repo)
		assert.are.same('g/b', plugs[2].repo)
		assert.are.same('g/c', plugs[3].repo)
		assert.are.same(nil, plugs[4].repo)
		assert.are.same(nil, plugs[5].repo)
		assert.are.same('g/f', plugs[6].repo)

		assert.are.same('g/g1', plugs[7].repo)
		assert.are.same('g/g2', plugs[8].repo)
		assert.are.same('g/g', plugs[9].repo)

		assert.are.same({
			id = 'g/h1',
			repo = 'g/h1',
			reason = 'uninstalled',
			disable = true,
			uninstalled = true,
		}, plugs[10])

		assert.are.same({ id = 'g/h2', repo = 'g/h2', disable = true }, plugs[11])

		assert.are.same({
			id = 'g/h',
			repo = 'g/h',
			disable = true,
			reason = 'its required plug "g/h2" is disabled',
			requires = {
				{ id = 'g/h1', repo = 'g/h1', reason = 'uninstalled', disable = true, uninstalled = true },
				{ id = 'g/h2', repo = 'g/h2', disable = true },
			},
		}, plugs[12])

	end)
end)
