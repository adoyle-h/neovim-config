return {
	query = {
		desc = 'Simple way to view command output',

		command = function()
			local input = vim.fn.input(':')
			local output = vim.api.nvim_exec(input, true):gmatch('[^\r\n]+')
			return vim.split(output, '\n')
		end,
	},

	['ts-parsers'] = {
		desc = 'List nvim-treesitter loaded parsers',

		command = function()
			-- TODO: list_modules is not implemented
			local mods = require('nvim-treesitter.configs').list_modules()
			local list = {}

			for i, mod in pairs(mods) do list[i] = { text = mod.name } end

			return list
		end,
	},

	scriptnames = {
		command = function()
			local output = vim.api.nvim_exec('scriptnames', true)
			return vim.split(output, '\n')
		end,
	},

	plugins = {
		desc = 'List adoyle-neovim-config plugins',

		command = function()
			local a = require('adoyle-neovim-config')
			local list = {}

			for i, plug in pairs(a.PM.plugs) do
				local id = tostring(plug.id)
				list[#list + 1] = { text = string.format('%3d: %s', i, id), entry = { ordinal = id } }
			end

			return list
		end,
	},

	rtp = {
		command = function()
			return vim.split(vim.o.rtp, ',')
		end,
	},

	packpath = {
		command = function()
			return vim.split(vim.o.packpath, ',')
		end,
	},

	message = {
		command = 'messages',
		picker = { --
			sorting_strategy = 'ascending',
			default_selection_index = -1,
		},
	},

	time = {
		command = function()
			return { os.date(), '' .. os.time() }
		end,
	},

	changes = {
		command = function()
			local items = {}
			for change in vim.api.nvim_exec('changes', true):gmatch('[^\r\n]+') do
				items[#items + 1] = change
			end
			return items
		end,

		onSubmit = function(item)
			local _, _, str = string.find(item.text, '^%s+%d+%s+(%d+)')
			vim.api.nvim_win_set_cursor(0, { tonumber(str), 0 })
		end,
	},

	colors = {
		command = function()
			local items = {}

			for key, value in pairs(vim.api.nvim_get_color_map()) do
				table.insert(items, {
					text = string.format('%s = %s', key, value),
					entry = { ordinal = key .. '=' .. value },
				})
			end

			return items
		end,
	},

	env = {
		highlights = { --
			tel_ext_envs_1 = { fg = '#C3B11A' },
			tel_ext_envs_2 = { fg = '#34373B' },
		},

		format = { --
			separator = ' ',
			items = { {}, {}, {} },
		},

		command = function()
			local items = {}

			for key, value in pairs(vim.fn.environ()) do
				table.insert(items, {
					text = { { key, 'tel_ext_envs_1' }, { '=', 'tel_ext_envs_2' }, value },
					entry = { --
						ordinal = key .. '=' .. value,
					},
					key = key,
					value = value,
				})
			end

			return items
		end,
	},
}
