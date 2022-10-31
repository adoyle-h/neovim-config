local colors = { -- basic colors
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
	purple = '#765ADA', -- '#574AB2',
	yellow = '#C3B11A', -- '#E3D888' '#FFE787' '#D1D0A3'
	red = '#BF3100',

	lightYellow = '#FFFFED',
	lightGreen = '#C4D697',
	lightGrey = '#818387',

	darkGreen = '#13230c',
	darkBlue = '#181928',
	darkCyan = '#0c1820',
	darkRed = '#1F0909', -- '#340009'
	darkYellow = '#212100',
	darkOrange = '#371B00',
	darkPurple = '#180225',
}

local functionsColors = { --
	cursorLine = colors.darkBlue,
	cursorLineNrFG = colors.blue,
	cursorLineNrBG = colors.darkBlue,

	scrollbarBG = '#0E2851',

	match = { fg = colors.orange },

	diff = {
		add = { bg = colors.darkGreen },
		delete = { fg = colors.red, bg = colors.darkRed },
		change = { bg = colors.darkYellow },
		text = { bg = '#353513' },
	},
}

for k, v in pairs(functionsColors) do colors[k] = v end

return colors