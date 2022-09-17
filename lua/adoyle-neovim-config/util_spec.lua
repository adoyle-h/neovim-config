local util = require('adoyle-neovim-config.util')

describe('util.merge', function()
	it('(table, number)', function()
		local r = util.merge({ a = 1, c = 3 }, 2)
		assert.equals(2, r)
	end)

	it('(table, table)', function()
		local r = util.merge({ a = 1, c = 3 }, { b = 2, a = '4' })
		assert.are.same({ a = '4', b = 2, c = 3 }, r)
	end)

	it('(nil, table)', function()
		local r = util.merge(nil, { b = 2, a = '4' })
		assert.are.same({ a = '4', b = 2 }, r)
	end)

	it('(table, nil)', function()
		local r = util.merge({ a = 1, c = 3 }, nil)
		assert.are.same({ a = 1, c = 3 }, r)
	end)

	it('(array, array)', function()
		local r = util.merge({ 1, 3 }, { 2, '4' })
		assert.are.same({ 2, '4' }, r)
	end)

	it('(array, table)', function()
		local r = util.merge({ 1, 3 }, { b = 2, a = '4' })
		assert.are.same({ 1, 3, b = 2, a = '4' }, r)
	end)

	it('(PluginOpts, table)', function()
		local r = util.merge({ 'abc', a = 1, c = 3 }, { b = 2, a = '4' })
		assert.are.same({ 'abc', a = '4', b = 2, c = 3 }, r)
	end)

	it('(table, PluginOpts)', function()
		local r = util.merge({ a = 1, c = 3 }, { nil, b = 2, a = '4' })
		assert.are.same({ a = '4', b = 2, c = 3 }, r)
	end)

	it('nested tables', function()
		local r = util.merge({ a = { b = 2, c = { d = 4 } } }, { a = { b = 5 } })
		assert.are.same({ a = { b = 5, c = { d = 4 } } }, r)
	end)

	it('function override', function()
		local f1 = function() return 1 end
		local f2 = function() return 2 end
		local r = util.merge({ a = { b = { f = f1 } } }, { a = { b = { f = f2 } } })

		assert.equals(r.a.b.f, f2)
	end)
end)
