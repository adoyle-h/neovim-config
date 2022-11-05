-- Use :TSCaptureUnderCursor to get highlight group of text
-- Color schema references:
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
-- https://github.com/rockerBOO/awesome-neovim#tree-sitter-supported-colorscheme
return function(config)
	local c = config.colors

	return {
		['@variable'] = { link = 'Identifier' },
		['@variable.builtin'] = { fg = c.yellow }, -- Variable names that are defined by the languages, like `this` or `self`.
		['@field'] = { fg = '#A39D80' }, -- #96C726 #90852F '#C75D14'
		['@parameter'] = { fg = '#B63636' }, -- #BC3596
		['@parameter.reference'] = { fg = '#B63636' }, -- For references to parameters of a function.
		['@property'] = { fg = '#5098A3' },
		['@keyword'] = { link = 'Keyword' },
		['@keyword.return'] = { fg = '#75902F' }, -- ADCC61
		['@keyword.function'] = { fg = '#3D84FF' },
		['@function'] = { link = 'Function' },
		['@function.call'] = { link = 'Function' }, -- #4083F8
		['@function.builtin'] = { fg = '#124FF2' }, -- For builtin functions: `table.insert` in Lua.
		['@function.macro'] = { link = 'Macro' }, -- For macro defined functions (calls and definitions): each `macro_rules` in Rust.
		['@conditional'] = { link = 'Conditional' },
		['@repeat'] = { link = 'Repeat' }, -- For keywords related to loops.
		['@type'] = { link = 'Type' },
		['@type.builtin'] = { fg = c.yellow }, -- For builtin types (you guessed it, right ?).
		['@boolean'] = { link = 'Boolean' },
		['@constant'] = { link = 'Constant' },
		['@constant.builtin'] = { fg = c.purple }, -- For constant that are built in the language: `nil` in Lua.
		['@constant.macro'] = { link = 'Constant' }, -- For constants that are defined by macros: `NULL` in theme.config.
		['@include'] = { link = 'Include' },
		['@namespace'] = { fg = '#8255FF' },
		['@annotation'] = { fg = c.cyan }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
		['@attribute'] = { fg = c.purple }, -- (unstable)
		['@character'] = { link = 'Character' }, -- For characters.
		['@comment'] = { link = 'Comment' }, -- For comment blocks.
		['@constructor'] = { fg = c.yellow }, -- For constructor calls and definitions: `{}` in Lua, and Java constructors.
		['@error'] = { link = 'Error' }, -- For syntax/parser errors.
		['@exception'] = { link = 'Exception' }, -- For exception related keywords.
		['@float'] = { link = 'Float' }, -- For floats.
		['@keyword.operator'] = { fg = c.purple, italic = true }, -- For operators that are English words, e.g. `and`, `as`, `or`.
		['@label'] = { fg = c.purple, italic = true }, -- For labels: `label:` in C and `:label:` in Lua.
		['@method'] = { fg = c.blue }, -- For method calls and definitions.
		['@number'] = { link = 'Number' }, -- For integers.
		['@operator'] = { link = 'Operator' }, -- For any operator: `+`, but also `->` and `*` in theme.config.
		['@punctuation.delimiter'] = { link = 'Delimiter' }, -- For delimiters ie: `.`
		['@punctuation.bracket'] = { fg = c.white }, -- For brackets and parens.
		['@punctuation.special'] = { fg = c.white }, -- For special punctutation that does not fall in the categories before.
		['@string'] = { link = 'String' }, -- For strings.
		['@string.regex'] = { fg = '#47A169' }, -- For regexes.
		['@string.escape'] = { fg = c.cyan }, -- For escape characters within a string.
		['@string.special'] = { link = 'Special' }, -- For strings with special meaning that don't fit into the above categories.
		['@symbol'] = { fg = c.red }, -- For identifiers referring to symbols or atoms.
		['@tag'] = { fg = c.red }, -- Tags like html tag names.
		['@tag.attribute'] = { link = 'TSProperty' }, -- For html tag attributes.
		['@tag.delimiter'] = { link = 'Delimiter' }, -- Tag delimiter like `<` `>` `/`
		['@strong'] = { fg = c.white, bold = true }, -- For text to be represented with strong.
		['@emphasis'] = { fg = c.white, bold = true }, -- For text to be represented with emphasis.
		['@underline'] = { fg = c.white, underline = true }, -- For text to be represented with an underline.
		['@strike'] = { fg = c.white }, -- For strikethrough text.
		['@title'] = { fg = c.white }, -- Text that is part of a title.
		['@literal'] = { fg = c.white }, -- Literal text.
		['@uri'] = { fg = c.blue }, -- Any URI like a link or email.
		['@math'] = { fg = c.white }, -- For LaTex-like math environments.
		['@text'] = { fg = c.white }, -- For strings considered text in a markup language.
		['@text.reference'] = { link = '@text' }, -- For footnotes, text references, citations.
		['@text.underline'] = { link = 'Underlined' },
		['@environment'] = { link = 'Macro' }, -- For text environments of markup languages.
		['@environment.name'] = { link = 'Type' }, -- For the name/the string indicating the type of text environment.
		['@note'] = { fg = c.cyan }, -- Text representation of an informational note.
		['@warning'] = { link = 'Warn' }, -- Text representation of a warning note.
		['@danger'] = { link = 'Error' }, -- Text representation of a danger note.
	}
end
