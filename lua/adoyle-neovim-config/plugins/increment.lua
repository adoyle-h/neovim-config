local M = {
	'nishigori/increment-activator',
	on = { '<Plug>(increment-activator-increment)', '<Plug>(increment-activator-decrement)' },
	desc = '自增/自减',
	disable = false,
	requires = {},
}

function M.config()
	vim.g.increment_activator_no_default_key_mappings = 1
	vim.g.increment_activator_filetype_candidates = {
		['_'] = {
			-- LuaFormatter off
			{
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
				'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
			},
			{
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
				'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
			},
			{'一', '二', '三', '四', '五', '六', '七', '八', '九', '十'},
			{'none', 'debug', 'info', 'warn', 'error'},
			{'NONE', 'DEBUG', 'INFO', 'WARN', 'ERROR'},
			{'Todo', 'Done'},
			{'TODO', 'DONE'},
			{'todo', 'done'},
			{'low', 'normal', 'high'},
			{'LOW', 'NORMAL', 'HIGH'},
			-- LuaFormatter on
		},
	}

	vim.cmd [[
		nmap <leader>ii <Plug>(increment-activator-increment)<leader>i
		nmap <leader>id <Plug>(increment-activator-decrement)<leader>i
	]]
end

return M
