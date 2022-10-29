local M = { 'akinsho/bufferline.nvim', tag = 'v2.*', requires = { 'tiagovla/scope.nvim' } }

local opts = { silent = true }

M.keymaps = {
	{ 'n', '[b', ':BufferLineCyclePrev<CR>', opts },
	{ 'n', ']b', ':BufferLineCycleNext<CR>', opts },
	{ 'n', '<M-[>', ':BufferLineCyclePrev<CR>', opts },
	{ 'n', '<M-]>', ':BufferLineCycleNext<CR>', opts },
	{ 'n', '<C-T>j', ':BufferLineCyclePrev<CR>', opts },
	{ 'n', '<C-T>k', ':BufferLineCycleNext<CR>', opts },
	{ 'n', '<C-T>l', ':BufferLineMoveNext<CR>', opts },
	{ 'n', '<C-T>h', ':BufferLineMovePrev<CR>', opts },
	{ 'n', '<C-T>n', ':tabnew<CR>', opts },
	{ 'n', '<C-T>x', ':tabclose<CR>', opts },
	{ 'n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', opts },
	{ 'n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', opts },
	{ 'n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', opts },
	{ 'n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', opts },
	{ 'n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', opts },
	{ 'n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', opts },
	{ 'n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', opts },
	{ 'n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', opts },
	{ 'n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', opts },
	{ 'n', '<leader>0', ':BufferLineGoToBuffer -1<CR>', opts },
}

M.defaultConfig = function()
	local config = require('adoyle-neovim-config.config').config
	local colors = config.colors
	local selectedBG = '#1b2430'
	local bufferBG = '#12151a'
	local white = colors.white
	local grey = colors.grey
	local blue = colors.blue
	local yellow = colors.yellow

	return {
		'bufferline',
		{
			options = {
				mode = 'tabs', -- 'tabs' or 'buffers'
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
				max_name_length = 30,
				truncate_names = true,

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

				diagnostics = false, -- false | 'nvim_lsp' | 'coc',

				-- custom_areas = { -- BUG: highlights are out-of-order
				--   right = function()
				--     local result = {}
				--     local seve = vim.diagnostic.severity
				--     local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
				--     local warn = #vim.diagnostic.get(0, { severity = seve.WARN })
				--     local info = #vim.diagnostic.get(0, { severity = seve.INFO })
				--     local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

				--     local config = require('adoyle-neovim-config.config').config
				--     local color = config.colors
				--     local symbolMap = config.symbolMap
				--     local printf = vim.fn.printf

				--     if error ~= 0 then
				--       table.insert(result, { text = printf('%s %s ', symbolMap.ERROR, error), fg = color.red })
				--     end

				--     if warn ~= 0 then
				--       table.insert(result, { text = printf('%s %s ', symbolMap.WARN, warn), fg = color.yellow })
				--     end

				--     if hint ~= 0 then
				--       table.insert(result, { text = printf('%s %s ', symbolMap.HINT, hint), fg = color.cyan })
				--     end

				--     if info ~= 0 then
				--       table.insert(result, { text = printf('%s %s ', symbolMap.INFO, info), fg = color.blue })
				--     end
				--     return result
				--   end,
				-- },

			},

			highlights = {
				fill = { -- It's background
					fg = grey,
					bg = colors.black,
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
		},
	}
end

function M.config(config)
	local conf = config.bufferline

	if conf.options.mode == 'buffers' then
		-- Temp Fix: buffers per tab
		-- see https://github.com/akinsho/bufferline.nvim#how-do-i-see-only-buffers-per-tab
		require('scope').setup()
	end

	require('bufferline').setup(conf)
end

return M
