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

	menu = { selectBG = '#012867' },

	selection = color.darkOrange,
}

for k, v in pairs(functionsColors) do color[k] = v end

return color
