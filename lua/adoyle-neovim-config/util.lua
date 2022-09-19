local util = {}

local fn = vim.fn
local tbl_islist = vim.tbl_islist
local set_hl = vim.api.nvim_set_hl

function util.proxyGithub(url)
	return url
end

function util.set_hl(hls)
	for _, hl in pairs(hls) do set_hl(0, hl[1], hl[2]) end
end

---Merge two tables recursively. The later override the previous
function util.merge(v1, v2)
	local v1IsArray = tbl_islist(v1)
	local v2IsArray = tbl_islist(v2)

	if v1IsArray and v2IsArray then return v2 end

	local v1IsTable = type(v1) == 'table'
	local v2IsTable = type(v2) == 'table'

	if v1IsTable and v2IsTable then
		local tbl = {}

		for k, v in pairs(v1) do tbl[k] = v end

		for k, v in pairs(v2) do tbl[k] = util.merge(v1[k], v) end

		return tbl
	end

	if v2 == nil then
		return v1
	else
		return v2
	end
end

function util.exist(path)
	return fn.empty(fn.glob(path)) == 0
end

function util.getVisualSelection(return_raw)
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	if return_raw then
		return text
	else
		return string.gsub(text, '\n', '')
	end
end

return util
