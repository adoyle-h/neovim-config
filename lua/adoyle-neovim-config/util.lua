local util = {}

local tbl_islist = vim.tbl_islist
local tbl_isempty = vim.tbl_isempty
local NIL = vim.NIL

util.none = NIL

---Merge two tables recursively
---@generic T
---@param v1 T
---@param v2 T
---@return T
util.merge = function(v1, v2)
	local merge1 = type(v1) == 'table' and (not tbl_islist(v1) or tbl_isempty(v1))

	local merge2 = type(v2) == 'table' and (not tbl_islist(v2) or tbl_isempty(v2))

	if merge1 and merge2 then
		local new_tbl = {}
		for k, v in pairs(v2) do
			new_tbl[k] = util.merge(v1[k], v)
		end
		for k, v in pairs(v1) do
			if v2[k] == nil and v ~= NIL then
				new_tbl[k] = v
			end
		end
		return new_tbl
	end

	if v1 == NIL then
		return nil
	end

	if v1 == nil then
		if v2 == NIL then
			return nil
		else
			return v2
		end
	end

	if v1 == true then
		if merge2 then
			return v2
		end
		return {}
	end

	return v1
end

return util
