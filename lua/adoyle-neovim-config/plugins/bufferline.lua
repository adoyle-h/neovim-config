local M = {
	'akinsho/bufferline.nvim',
	tag = 'v2.*',
	disable = false,
	requires = { 'tiagovla/scope.nvim' },
}

local opts = { noremap = true, silent = true }

M.keymaps = {
	{ 'n', '[b', ':BufferLineCyclePrev<CR>', opts },
	{ 'n', ']b', ':BufferLineCycleNext<CR>', opts },
	{ 'n', '<C-T>j', ':BufferLineCyclePrev<CR>', opts },
	{ 'n', '<C-T>k', ':BufferLineCycleNext<CR>', opts },
	{ 'n', '<C-T>l', ':BufferLineMoveNext<CR>', opts },
	{ 'n', '<C-T>h', ':BufferLineMovePrev<CR>', opts },
	{ 'n', '<C-T>n', ':tabnew<CR>', opts },
	{ 'n', '<C-T>x', ':tabclose<CR>', opts },
	{ 'n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', opts },
	{ 'n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', opts },
	{ 'n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', opts },
	{ 'n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', opts },
	{ 'n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', opts },
	{ 'n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', opts },
	{ 'n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', opts },
	{ 'n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', opts },
	{ 'n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', opts },
	{ 'n', '<leader>0', '<Cmd>BufferLineGoToBuffer -1<CR>', opts },
}

function M.config()
	local color = require('adoyle-neovim-config.config').config.color
	local selectedBG = color.bufferline.selectedBG
	local bufferBG = color.bufferline.bufferBG
	local white = color.white
	local grey = color.grey
	local blue = color.blue
	local yellow = color.yellow

	local mode = 'tabs' -- 'tabs' or 'buffers'

	if mode == 'buffers' then
		-- Temp Fix: buffers per tab
		-- see https://github.com/akinsho/bufferline.nvim#how-do-i-see-only-buffers-per-tab
		require('scope').setup()
	end

	require('bufferline').setup {
		options = {
			mode = mode,
			numbers = 'none',

			indicator = {
				icon = '▎', -- this should be omitted if indicator style is not 'icon'
				style = 'icon', -- 'icon'| 'underline' | 'none',
			},
			show_buffer_icons = false, -- disable filetype icons for buffers
			show_buffer_close_icons = true,
			show_close_icon = false,
			buffer_close_icon = '',
			modified_icon = '*',
			close_icon = '',
			left_trunc_marker = '',
			right_trunc_marker = '',
			color_icons = true,
			separator_style = { '', '' }, -- 'slant' | 'thick' | 'thin' | { 'any', 'any' },

			diagnostics = false, -- false | 'nvim_lsp' | 'coc',

			offsets = {
				{
					filetype = 'neo-tree',
					text = '[File Explorer]',
					text_align = 'center', -- 'left' | 'center' | 'right'
					highlight = 'BufferLineInfoSelected',
					separator = true,
				},

				{
					filetype = 'NvimTree',
					text = '[File Explorer]',
					text_align = 'center', -- 'left' | 'center' | 'right'
					highlight = 'BufferLineInfoSelected',
					separator = true,
				},

				{
					filetype = 'aerial',
					text = '[Outline]',
					text_align = 'center', -- 'left' | 'center' | 'right'
					highlight = 'BufferLineInfoSelected',
					separator = true,
				},

			},

		},

		highlights = {
			fill = { -- It's background
				fg = grey,
				bg = color.black,
			},

			background = { -- unselected buffers
				fg = grey,
				bg = bufferBG,
			},

			tab = { fg = grey, bg = bufferBG },

			tab_selected = { fg = white, bg = selectedBG },

			tab_close = { fg = grey, bg = bufferBG },

			modified = { fg = yellow, bg = bufferBG },

			modified_visible = { fg = yellow, bg = selectedBG },

			modified_selected = { fg = yellow, bg = selectedBG },

			duplicate_selected = { fg = white, bg = selectedBG, italic = true },

			duplicate_visible = { fg = grey, bg = selectedBG, italic = true },

			duplicate = { fg = grey, bg = bufferBG, italic = true },

			buffer_selected = { fg = white, bg = selectedBG, bold = false, italic = false },

			numbers = { fg = grey, bg = bufferBG },

			numbers_selected = { fg = white, bg = selectedBG, bold = false, italic = false },

			indicator_selected = { fg = blue, bg = selectedBG },

			close_button = { bg = bufferBG },

			close_button_selected = { fg = blue, bg = selectedBG },

			close_button_visible = { fg = blue, bg = selectedBG },

			buffer_visible = { fg = white, bg = selectedBG },

			numbers_visible = { fg = white, bg = selectedBG },

		},
	}
end

return M
