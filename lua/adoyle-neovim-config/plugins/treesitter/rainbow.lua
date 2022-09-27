return {
	'p00f/nvim-ts-rainbow',
	desc = 'Rainbow brackets',
	defaultConfig = {
		'tsRainbow',
		{
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			colors = { -- table of hex strings
				-- LuaFormatter off
				'#005f87', '#d75f00', '#12ff5f', '#0087ff', '#00aa87', '#b2ffaf', '#ff5f00',
				'#6F3080', '#ff00ff', '#8787ff', '#87875f',
				-- LuaFormatter on
			},

			termcolors = { -- table of colour name strings
			},
		},
	},
}
