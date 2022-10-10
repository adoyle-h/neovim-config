return {
	'p00f/nvim-ts-rainbow',
	desc = 'Rainbow brackets',

	config = function(config)
		require('nvim-treesitter.configs').setup { rainbow = config.rainbow }
	end,

	defaultConfig = {
		'rainbow',
		{
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			colors = { -- table of hex strings
				-- LuaFormatter off
				'#589CFF', '#d75f00', '#12cf5f', '#0087ff', '#00a887', '#b8afbf', '#ff5f00',
				'#6F0080', '#ff00ff', '#8787ff', '#82875f',
				-- LuaFormatter on
			},

			termcolors = { -- table of colour name strings
			},
		},
	},
}
