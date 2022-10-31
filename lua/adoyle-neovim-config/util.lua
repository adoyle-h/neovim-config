local util = {}

local api = vim.api
local fn = vim.fn
local tbl_islist = vim.tbl_islist

function util.proxyGithub(url)
	return url
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

	api.nvim_win_set_option(win, 'nu', true)
	api.nvim_win_set_option(win, 'rnu', true)
	api.nvim_win_set_option(win, 'cursorline', true)

	local row = 0
	local write = function(content)
		if type(content) == 'string' then content = { content } end
		api.nvim_buf_set_lines(buf, row, row, true, content)
		row = row + #content
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

function util.bind(func, ...)
	local rest = { ... }
	return function(...)
		local args = {}

		for i = 1, #rest do args[i] = rest[i] end

		for i = 1, select('#', ...) do table.insert(args, select(i, ...)) end

		return func(table.unpack(args))
	end
end

function util.bindAfter(func, ...)
	local rest = { ... }
	return function(...)
		local args = {}

		for i = 1, select('#', ...) do table.insert(args, select(i, ...)) end

		for i = 1, #rest do args[i] = rest[i] end

		return func(table.unpack(args))
	end
end

function util.tbl_concat(t1, t2)
	for i = 1, #t2 do t1[#t1 + 1] = t2[i] end
	return t1
end

function util.input(func, prompt)
	vim.ui.input({ prompt = prompt or 'Enter value: ' }, func)
end

function util.select(func, list, format, prompt)
	vim.ui.select(list, { prompt = prompt or 'Select Item', format_item = format }, function(item, idx)
		if idx then func(item, idx) end
	end)
end

function util.isFile(path)
	local f = io.open(path, 'r')
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local function gotoDefinition(target)
	-- vim.notify(vim.inspect(target))
	if vim.fn.expand('%:p') ~= target.filename then vim.cmd.edit(target.filename) end
	vim.api.nvim_win_set_cursor(0, { target.lnum, target.col - 1 })
end

function util.gotoDef()
	vim.lsp.buf.definition {
		reuse_win = true,
		on_list = function(options)
			-- title, context.method context.
			local items = options.items

			if #items > 1 then
				local pwd = vim.fn.getcwd()

				vim.ui.select(items, {
					prompt = options.title,
					format_item = function(item)
						return string.format('%s [%s,%s] | %s', item.filename:gsub(pwd, '.'), item.lnum, item.col,
							vim.trim(item.text))
					end,
				}, function(_, idx)
					if idx then gotoDefinition(items[idx]) end
				end)
			else
				gotoDefinition(items[1])
			end
		end,
	}
end

function util.clearKeymaps(prefix, buffer)
	local keys = vim.fn.getcompletion(prefix, 'mapping')
	for _, key in pairs(keys) do vim.keymap.del('n', key, { buffer = buffer or 0 }) end
end

return util