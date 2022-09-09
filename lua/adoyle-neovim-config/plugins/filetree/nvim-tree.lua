local M = {
	'kyazdani42/nvim-tree.lua',
	disable = false,
	on = {},
	requires = {}
}

local function configKeymaps()
	vim.cmd [[
		noremap <silent> <leader>nm :NvimTreeToggle<CR>
		noremap <silent> <leader>nf :NvimTreeFindFile<CR>
		noremap <space>m :NvimTreeToggle<CR>
	]]
end

-- Temp Fix: too many notifications.
-- https://github.com/kyazdani42/nvim-tree.lua/issues/1502
local function fixNotify()
	local utils = require('nvim-tree.utils')

	local has_notify, notify = pcall(require, 'notify')
	if has_notify then
		notify = notify.instance {
			level = vim.log.levels.WARN,
		}
	else
		notify = function(msg, level, title)
			vim.notify(vim.fn.printf('[%s] %s', title, msg), level)
		end
	end

	local function notify_level(level)
		return function(msg)
			vim.schedule(function()
				notify(msg, level, { title = 'NvimTree' })
			end)
		end
	end

	local levels = vim.log.levels
	utils.notify.warn = notify_level(levels.WARN)
	utils.notify.error = notify_level(levels.ERROR)
	utils.notify.info = notify_level(levels.INFO)
	utils.notify.debug = notify_level(levels.DEBUG)
end

function M.config()
	fixNotify()

	require('nvim-tree').setup({
		sort_by = 'case_sensitive',

		remove_keymaps = { 'bmv' },

		view = {
			width = 30,

			mappings = {
				list = {
					{ key = '?', action = 'toggle_help' },
					{ key = 'H', action = 'dir_up' },
					{ key = { 'L', '<C-]>', '<2-RightMouse>' }, action = 'cd' },
					{ key = 'v', action = 'vsplit' },
					{ key = 's', action = 'split' },
					{ key = 't', action = 'tabnew' },
					{ key = 'i', action = 'toggle_dotfiles' },
					{ key = 'p', action = 'parent_node' },
					{ key = 'P', action = 'paste' },
				},
			},

			float = {
				enable = false,
			},
		},

		renderer = {
			group_empty = true,

			icons = {
				symlink_arrow = " ➜ ",

				glyphs = {
					git = {
						unstaged = "",
						staged = "",
						unmerged = "",
						renamed = "➜",
						untracked = "",
						deleted = "",
						ignored = "◌",
					},
				},
			},

		},

		filters = {
			dotfiles = true,
		},

		actions = {
			use_system_clipboard = true,
		},

	})

	vim.cmd.hi { 'NvimTreeNormal', 'guibg=#18191' }

	configKeymaps()
end

return M
