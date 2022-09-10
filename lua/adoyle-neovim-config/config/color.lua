local color = {
	white = '#BEC0C4',
	black = '#101012',
	grey1 = '#18191B',
	grey2 = '#242629',
	grey3 = '#34373B',
	grey = '#6C6F7F',
	green = '#75C44E',
	orange = '#D75F00',
	blue = '#689AFD',
	cyan = '#ACCBE1',
	-- purple = '#574AB2',
	purple = '#765ADA',
	-- yellow = '#E3D888',
	-- #FFE787
	-- #D1D0A3
	yellow = '#C3B11A',
	red = '#BF3100',

	lightYellow = '#FFFFED',
	lightGreen = '#C4D697',
	lightGrey = '#818387',

	darkBlue = '#181928',
	darkCyan = '#0c1820',
	-- darkRed = '#340009',
	darkRed = '#1F0909',
	darkYellow = '#212100',
	darkOrange = '#371B00',
	darkPurple = '#180225',

	blueBG = '#7D8CA3',
	yellowBG = '#F7B538',
	bg_d = '#1B1C1E',
}

local functionsColors = {
	diffAddBG = '#13230c',
	diffDeleteBG = '#290005',
	diffChangeBG = color.darkYellow,
	diffText = '#363537',

	menu = {
		selectBG = '#012867',
	},

	selection = color.darkOrange,

	cursorLineBG = color.darkBlue,
	cursorLineNrFG = color.blue,
	scrollbarBG = color.grey2,
	contextBG = color.darkCyan,

	outline = {
		lineBG = '#3f1f00',
	},

	bufferline = {
		bufferBG = '#12151a',
		selectedBG = '#1b2430',
	},

	statusline = {
		black    = color.black,
		white    = '#d9d7ce',
		sec_y_bg = '#272d38',
		grey     = '#282b2e',
		green    = '#bbe67e',
		blue     = '#689afd',
		red      = color.red,
		sec_c_fg = '#607080',
		sec_c_bg = '#12151a',
		orange   = '#D75F00',
		purple   = '#765ADA',
		yellow   = '#C7B000',
		cyan     = '#9ac3de',
	},

	-- Use :TSCaptureUnderCursor to get highlight group of text
	-- Color schema references:
	-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
	-- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
	treesitter = {
		-- Query ":h nvim_set_hl" for function arguments
		{ 'TSVariable', { fg = color.white } },
		{ 'TSParameter', { fg = color.white } },
		{ 'TSProperty', { fg = '#5098A3' } },
		{ 'TSKeyword', { fg = '#9ED817' } },
		{ 'TSFunction', { fg = '#3D84FF' } }, -- #4083F8
		{ 'TSKeywordFunction', { fg = '#1197DC' } },
		{ 'TSField', { fg = '#B1B16B' } },
		{ 'TSKeywordReturn', { fg = '#3C9B2F' } },
		{ 'TSConditional', { fg = '#916E99' } },
		{ 'TSType', { fg = '#C9853E' } },
		{ 'TSBoolean', { fg = '#AD3838' } },
		{ 'TSConstant', { fg = '#CBB708' } },
		{ 'TSInclude', { fg = '#A486E1' } },
		{ 'TSNamespace', { fg = '#8255FF' } },
	},

	highlightWords = {
		gui = {
			'#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF', '#C9853E', '#4083F8',
			'#5F9B2F', '#8255FF', '#D25B9F', '#406661', '#95956E', '#284184', '#6C7B95', '#835858',
		},
		cterm = {},
	},
}

for k, v in pairs(functionsColors) do color[k] = v end

return color
