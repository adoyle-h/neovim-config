local util = {}

local fn = vim.fn
local tbl_islist = vim.tbl_islist

---Merge two tables recursively. The later override the previous
util.merge = function(v1, v2)
	local v1IsArray = tbl_islist(v1)
	local v2IsArray = tbl_islist(v2)

	if v1IsArray and v2IsArray then
		local tbl = {}

		for k, v in pairs(v1) do
			tbl[k] = v
		end

		for _, v in pairs(v2) do
			table.insert(tbl, v)
		end

		return tbl
	end

	local v1IsTable = type(v1) == 'table'
	local v2IsTable = type(v2) == 'table'

	if v1IsTable and v2IsTable then
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
