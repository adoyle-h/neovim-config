local M = {}

local printf = string.format

M.config = function(config)
	local ok = pcall(require, 'lualine')
	if not ok then
		return
	end

	-- local c = config.colors

	-- vim.list_extend(config.statusline.lualine.sections.lualine_x, { winNumber })

	return {
		-- lualine = {
		-- 	sections = {
		-- 		lualine_x = x,
		-- 		-- lualine_x = { my_sections({ progress, location, spaces, bufferNumber, winNumber }), 'filesize' },
		-- 	},
		-- },
	}
end

return M
