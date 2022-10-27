-- Use :TSCaptureUnderCursor to get highlight group of text
-- Color schema references:
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
-- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
return function(config)
	local colors = config.colors

	return {
		TSVariable = { fg = colors.white },
		TSParameter = { fg = colors.white },
		TSProperty = { fg = '#5098A3' },
		TSKeyword = { fg = '#9ED817' },
		TSFunction = { fg = '#3D84FF' }, -- #4083F8
		TSKeywordFunction = { fg = '#1197DC' },
		TSField = { fg = '#B1B16B' },
		TSKeywordReturn = { fg = '#3C9B2F' },
		TSConditional = { fg = '#916E99' },
		TSType = { fg = '#C9853E' },
		TSBoolean = { fg = '#AD3838' },
		TSConstant = { fg = '#CBB708' },
		TSInclude = { fg = '#A486E1' },
		TSNamespace = { fg = '#8255FF' },

		TreesitterContext = { bg = colors.darkCyan, italic = true, bold = true },
		TreesitterContextLineNumber = { bg = colors.darkCyan, italic = true, bold = true },
	}
end
