local util = {}

local fn = vim.fn

---Merge two tables recursively. The later override the previous
util.merge = function(v1, v2)
	local merge1 = type(v1) == 'table'
	local merge2 = type(v2) == 'table'

	if merge1 and merge2 then
		local tbl = {}

		for k, v in pairs(v1) do
			tbl[k] = v
		end

		for k, v in pairs(v2) do
			tbl[k] = util.merge(v1[k], v)
		end

		return tbl
	end

	if v2 == nil then
		return v1
	else
		return v2
	end
end

util.exist = function(path)
	return fn.empty(fn.glob(path)) == 0
end

return util
