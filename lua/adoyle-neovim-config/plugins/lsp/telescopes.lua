local printf = vim.fn.printf

return {
	{
		name = 'DettachLSP',
		-- The dettached LSP will reattach after refresh file,

		command = function()
			local buf = vim.api.nvim_get_current_buf()
			local clients = vim.lsp.get_active_clients({ bufnr = buf })

			return vim.tbl_map(function(client)
				return { text = client.name, client = client }
			end, clients)
		end,

		onSubmit = function(selection)
			vim.lsp.buf_detach_client(0, selection.client.id)
		end,
	},

	{
		name = 'ToggleNullLSP',

		command = function()
			local nullLS = require('null-ls')
			local sources = nullLS.get_sources()
			local ft = vim.o.ft
			local results = {}

			-- source structure
			-- {
			-- 	name = "lua_format"
			-- 	id = 5,
			-- 	filetypes = {
			-- 		lua = true
			-- 	},
			-- 	generator = {
			-- 		async = true,
			-- 		opts = {
			-- 			args = { "-i" },
			-- 			command = "lua-format",
			-- 			ignore_stderr = true,
			-- 			name = "lua_format",
			-- 			to_stdin = true
			-- 		},
			-- 		source_id = 5  [n 7/8]
			-- 	},
			-- 	methods = {
			-- 		NULL_LS_FORMATTING = true
			-- 	},
			-- }
			for _, src in pairs(sources) do
				if src.filetypes[ft] then
					local methods = vim.fn.join(vim.tbl_keys(src.methods), ',')
					table.insert(results, { text = printf('%s (%s)', src.name, methods), src = src, ft = ft })
				end
			end

			return results
		end,

		onSubmit = function(item)
			local nullLS = require('null-ls')
			local src = item.src
			local S = require('null-ls.sources')

			if S.is_available(src, item.ft) then
				nullLS.disable({ id = src.id })
				vim.schedule(function()
					print(printf('NullLS "%s" disabled', src.name))
				end)
			else
				nullLS.enable({ id = src.id })
				vim.schedule(function()
					print(printf('NullLS "%s" enabled', src.name))
				end)
			end
		end,

		sorting_strategy = 'ascending',

		-- layout_strategy = 'center',
		layout_config = {
			height = 16,
			width = 60,
			prompt_position = 'top', -- top or bottom
		},
	},
}
