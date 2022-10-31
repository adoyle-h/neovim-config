-- Use :TSCaptureUnderCursor to get highlight group of text
-- Color schema references:
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
-- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
return function(config)
	local c = config.colors

	return {
		TSVariable = { fg = c.white },
		TSParameter = { fg = '#3B8658' },
		TSProperty = { fg = '#5098A3' },
		TSKeyword = { fg = '#BD3838' },
		TSFunction = { fg = '#3D84FF' }, -- #4083F8
		TSKeywordFunction = { fg = '#0560FF' },
		TSKeywordReturn = { fg = '#9ED817' },
		TSField = { fg = '#A4A479' },
		TSConditional = { fg = '#7B59E2' },
		TSType = { fg = '#C9853E' },
		TSBoolean = { fg = '#C94898' },
		TSConstant = { fg = '#B1A222' },
		TSInclude = { fg = '#A486E1' },
		TSNamespace = { fg = '#8255FF' },

		-- TSNone = {},
		TSAnnotation = { fg = c.red }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
		TSAttribute = { fg = c.purple }, -- (unstable)
		TSCharacter = { link = 'Character' }, -- For characters.
		TSComment = { link = 'Comment' }, -- For comment blocks.
		TSConstBuiltin = { fg = c.purple }, -- For constant that are built in the language: `nil` in Lua.
		TSConstMacro = { link = 'Constant' }, -- For constants that are defined by macros: `NULL` in theme.config.
		TSConstructor = { fg = c.yellow }, -- For constructor calls and definitions: `{}` in Lua, and Java constructors.
		TSError = { link = 'Error' }, -- For syntax/parser errors.
		TSException = { link = 'Exception' }, -- For exception related keywords.
		TSFloat = { link = 'Float' }, -- For floats.
		TSFuncBuiltin = { fg = c.yellow }, -- For builtin functions: `table.insert` in Lua.
		TSFuncMacro = { fg = c.blue }, -- For macro defined functions (calls and definitions): each `macro_rules` in Rust.
		TSKeywordOperator = { fg = c.purple, italic = true }, -- For operators that are English words, e.g. `and`, `as`, `or`.
		TSLabel = { fg = c.purple, italic = true }, -- For labels: `label:` in C and `:label:` in Lua.
		TSMethod = { fg = c.blue }, -- For method calls and definitions.
		TSNumber = { link = 'Number' }, -- For integers.
		TSOperator = { link = 'Operator' }, -- For any operator: `+`, but also `->` and `*` in theme.config.
		TSParameterReference = { fg = c.red }, -- For references to parameters of a function.
		TSPunctDelimiter = { link = 'Delimiter' }, -- For delimiters ie: `.`
		TSPunctBracket = { fg = c.white }, -- For brackets and parens.
		TSPunctSpecial = { fg = c.white }, -- For special punctutation that does not fall in the categories before.
		TSRepeat = { fg = c.purple }, -- For keywords related to loops.
		TSString = { fg = c.green }, -- For strings.
		TSStringRegex = { fg = c.green }, -- For regexes.
		TSStringEscape = { fg = c.cyan }, -- For escape characters within a string.
		TSStringSpecial = { link = 'Special' }, -- For strings with special meaning that don't fit into the above categories.
		TSSymbol = { fg = c.red }, -- For identifiers referring to symbols or atoms.
		TSTag = { fg = c.red }, -- Tags like html tag names.
		TSTagAttribute = { link = 'TSProperty' }, -- For html tag attributes.
		TSTagDelimiter = { link = 'Delimiter' }, -- Tag delimiter like `<` `>` `/`
		TSText = { fg = c.white }, -- For strings considered text in a markup language.
		TSStrong = { fg = c.white, bold = true }, -- For text to be represented with strong.
		TSEmphasis = { fg = c.white, bold = true }, -- For text to be represented with emphasis.
		TSUnderline = { fg = c.white, underline = true }, -- For text to be represented with an underline.
		TSStrike = { fg = c.white }, -- For strikethrough text.
		TSTitle = { fg = c.white }, -- Text that is part of a title.
		TSLiteral = { fg = c.white }, -- Literal text.
		TSURI = { fg = c.blue }, -- Any URI like a link or email.
		TSMath = { fg = c.white }, -- For LaTex-like math environments.
		TSTextReference = { link = 'TSText' }, -- For footnotes, text references, citations.
		TSEnvironment = { link = 'Macro' }, -- For text environments of markup languages.
		TSEnvironmentName = { link = 'Type' }, -- For the name/the string indicating the type of text environment.
		TSNote = { fg = c.white }, -- Text representation of an informational note.
		TSWarning = { fg = c.yellow }, -- Text representation of a warning note.
		TSDanger = { fg = c.red }, -- Text representation of a danger note.
		TSTypeBuiltin = { fg = c.yellow }, -- For builtin types (you guessed it, right ?).
		TSVariableBuiltin = { fg = c.yellow }, -- Variable names that are defined by the languages, like `this` or `self`.

		TreesitterContext = { bg = c.darkCyan, italic = true, bold = true },
		TreesitterContextLineNumber = { bg = c.darkCyan, italic = true, bold = true },
	}
end
