local util = {}

local api = vim.api
local fn = vim.fn
local tbl_islist = vim.tbl_islist
local set_hl = api.nvim_set_hl

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

local buffers = {}
function util.newWindow(opts)
	opts = opts or {}
	local title = opts.title

	vim.cmd.vsplit()
	local win = api.nvim_get_current_win()
	local buf = api.nvim_create_buf(true, true)

	if title then
		local ok = pcall(api.nvim_buf_set_name, buf, title)
		if not ok then api.nvim_buf_delete(buffers[title], { force = true }) end
		pcall(api.nvim_buf_set_name, buf, title)
		buffers[title] = buf
	end

	api.nvim_buf_set_option(buf, 'filetype', opts.ft or 'text')
	api.nvim_buf_set_option(buf, 'sw', opts.sw or 2)
	api.nvim_buf_set_option(buf, 'ts', opts.ts or 2)

	api.nvim_win_set_option(win, 'foldmethod', 'indent')
	api.nvim_win_set_option(win, 'foldlevel', opts.foldlevel or 1)
	api.nvim_win_set_option(win, 'cc', '')

	api.nvim_win_set_buf(win, buf)
	vim.cmd 'vertical resize 80'

	local row = 0
	local write = function(content)
		api.nvim_buf_set_lines(buf, row, row, true, { content })
		row = row + 1
	end

	local writeVal = function(content)
		local text = vim.split(vim.inspect(content), '\n')
		api.nvim_buf_set_lines(buf, row, row, true, text)
		row = row + #text
	end

	return {
		write = write,
		writeVal = writeVal,
		win = win,
		resetCursor = function()
			api.nvim_win_set_cursor(win, { 1, 0 })
		end,
	}
end

util.bind = function(func, ...)
	local rest = { ... }
	return function(...)
		local args = {}

		for i = 1, #rest do args[i] = rest[i] end

		for i = 1, select('#', ...) do table.insert(args, select(i, ...)) end

		return func(table.unpack(args))
	end
end

util.bindAfter = function(func, ...)
	local rest = { ... }
	return function(...)
		local args = {}

		for i = 1, select('#', ...) do table.insert(args, select(i, ...)) end

		for i = 1, #rest do args[i] = rest[i] end

		return func(table.unpack(args))
	end
end

return util
