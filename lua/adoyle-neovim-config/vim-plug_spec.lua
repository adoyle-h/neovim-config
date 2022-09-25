local P = require('adoyle-neovim-config.vim-plug')

describe('P.mergeConfig()', function()
	local mergeConfig = P.mergeConfig

	it('"a"', function()
		local plugDefaultConfig = { 'a', { hello = 'world' } }
		local src = {}
		mergeConfig(src, plugDefaultConfig)
		assert.are.same({ a = { hello = 'world' } }, src)
	end)

	it('{"a"}', function()
		local plugDefaultConfig = { { 'a' }, { hello = 'world' } }
		local src = {}
		mergeConfig(src, plugDefaultConfig)
		assert.are.same({ a = { hello = 'world' } }, src)
	end)

	it('{"a", "b"}', function()
		local plugDefaultConfig = { { 'a', 'b' }, { hello = 'world' } }
		local src = {}
		mergeConfig(src, plugDefaultConfig)
		assert.are.same({ a = { b = { hello = 'world' } } }, src)
	end)
end)
