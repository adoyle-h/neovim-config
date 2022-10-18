local colors = {
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
	cursorLineNrBG = colors.darkBlue,
}

for k, v in pairs(functionsColors) do colors[k] = v end

return colors
