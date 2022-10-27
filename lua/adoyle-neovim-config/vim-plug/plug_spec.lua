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
end)
