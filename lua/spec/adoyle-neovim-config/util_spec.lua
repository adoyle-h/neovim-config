local util = require('adoyle-neovim-config.util')

describe('util.merge', function()
	it('(object, number)', function()
		local r = util.merge({ a = 1, c = 3 }, 2)
		assert.equals(2, r)
	end)

	it('(object, object)', function()
		local r = util.merge({ a = 1, c = 3 }, { b = 2, a = '4' })
		assert.equals({ a = '4', b = 2, c = 3 }, r)
	end)

	it('nested object', function()
		local r = util.merge({ a = { b = 2, c = { d = 4 } } }, { a = { b = 5 } })
		assert.equals({ a = { b = 5, c = { d = 4 } } }, r)
	end)
end)
