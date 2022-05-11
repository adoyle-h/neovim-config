-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide


-- Fix undefined table.unpack
-- :lua print(_VERSION) returns "Lua 5.1"
-- See https://github.com/neovim/neovim/blob/v0.7.0/runtime/lua/vim/compat.lua
table.unpack = unpack

-- set a map <leader> for more key combos
vim.g.mapleader = vim.config.mapleader

local config = vim.config
local opt = vim.opt

if config.proxy.github then
	vim.proxyGithub = function(url) return 'https://ghproxy.com/' .. url end
else
	vim.proxyGithub = function(url) return url end
end

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	return string.gsub(text, '\n', '')
end

opt.history = config.history
opt.cmdheight = config.cmdheight
opt.cc = config.highlightColumn
opt.synmaxcol = config.synmaxcol
opt.updatetime = config.updatetime
opt.updatecount = config.updatecount
opt.foldenable = config.foldenable
opt.fillchars = config.fillchars
opt.listchars = config.listchars
opt.showbreak = config.linebreakChar
opt.iskeyword = opt.iskeyword - { '.' }
opt.langmenu = config.langmenu
opt.spell = config.spell.check
opt.spelllang = config.spell.lang
opt.spellsuggest = config.spell.suggest
opt.matchpairs = config.matchpairs

if config.linenumber then
	opt.number = true -- show line number
	opt.relativenumber = true -- show relative line number
end
