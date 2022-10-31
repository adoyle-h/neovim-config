local M = { 'kyazdani42/nvim-tree.lua' }

local consts = require('adoyle-neovim-config.consts')

M.keymaps = {
	{ 'n', '<leader>nm', ':NvimTreeToggle<CR>', { silent = true } },
	{ 'n', '<leader>nf', ':NvimTreeFindFile<CR>', { silent = true } },
	{ 'n', '<space>m', ':NvimTreeToggle<CR>' },
}

-- Temp Fix: too many notifications.
-- https://github.com/kyazdani42/nvim-tree.lua/issues/1502
local function fixNotify(levelMap)
	local function notify_level(level)
		return function(msg)
			vim.schedule(function()
				if level < vim.log.levels.WARN then return end
				print(string.format('[%s][%s] %s', levelMap[level] or level or 'INFO', 'NvimTree', msg))
			end)
		end
	end

	local utils = require('nvim-tree.utils')
	local levels = vim.log.levels
	utils.notify.warn = notify_level(levels.WARN)
	utils.notify.error = notify_level(levels.ERROR)
	utils.notify.info = notify_level(levels.INFO)
	utils.notify.debug = notify_level(levels.DEBUG)
end

function M.config()
	fixNotify(consts.log.levelMap)

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

			float = { enable = false },
		},

		renderer = {
			group_empty = true,

			icons = {
				symlink_arrow = ' ➜ ',

				glyphs = {
					git = {
						unstaged = '',
						staged = '',
						unmerged = '',
						renamed = '➜',
						untracked = '',
						deleted = '',
						ignored = '◌',
					},
				},
			},

		},

		filters = { dotfiles = true },

		actions = { use_system_clipboard = true },

	})

	vim.cmd.hi { 'NvimTreeNormal', 'guibg=#18191' }
end

return M
