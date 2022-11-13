return {
	prefer_git = false,

	-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
	ensure_installed = { -- A list of parser names, or "all",
		-- LuaFormatter off
		'bash', 'beancount', 'bibtex', 'blueprint', 'c', 'clojure', 'cmake', 'comment', 'commonlisp',
		'cpp', 'css', 'cuda', 'dart', 'diff', 'dockerfile', 'dot', 'eex', 'elixir', 'elm', 'elvish',
		'erlang', 'fennel', 'fish', 'git_rebase', 'gitattributes', 'gitignore', 'glsl', 'go',
		'godot_resource', 'gomod', 'gowork', 'graphql', 'haskell', 'hcl', 'help', 'hjson', 'hlsl',
		'html', 'http', 'java', 'javascript', 'jsdoc', 'json', 'json5', 'jsonnet', 'julia', 'kotlin',
		'latex', 'llvm', 'lua', 'make', 'markdown', 'markdown_inline', 'perl', 'pioasm', 'proto',
		'python', 'racket', 'regex', 'rst', 'rust', 'scheme', 'scss', 'solidity', 'sparql', 'sql',
		'svelte', 'swift', 'teal', 'toml', 'tsx', 'twig', 'typescript', 'verilog', 'vim', 'vue',
		'wgsl', 'yaml',
		-- LuaFormatter on
	},

	ignore_install = { -- List of parsers to ignore installing (for "all")
		-- LuaFormatter off
		'agda', 'astro', 'c_sharp', 'cooklang', 'd', 'devicetree', 'embedded_template', 'jsonc',
		'foam', 'fortran', 'fusion', 'gdscript', 'gleam', 'glimmer', 'hack', 'heex', 'hocon',
		'lalrpop', 'ledger', 'm68k', 'menhir', 'meson', 'nickel', 'ninja', 'nix', 'ocaml',
		'ocaml_interface', 'ocamllex', 'pascal', 'php', 'phpdoc', 'prisma', 'pug', 'ql', 'qmljs',
		'r', 'rasi', 'rego', 'rnoweb', 'ruby', 'slint', 'supercollider', 'surface', 'sxhkdrc',
		'tiger', 'tlaplus', 'todotxt', 'turtle', 'v', 'vala', 'yang', 'zig'
		-- LuaFormatter on
	},
}
