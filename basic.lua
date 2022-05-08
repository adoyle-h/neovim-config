-- NOTE: Current Lua version is 5.1 util neovim 0.7
-- Learn nvim-lua: https://github.com/nanotee/nvim-lua-guide


-- Fix undefined table.unpack
-- :lua print(_VERSION) returns "Lua 5.1"
-- See https://github.com/neovim/neovim/blob/v0.7.0/runtime/lua/vim/compat.lua
table.unpack = unpack

if vim.config.proxy.github then
	vim.proxyGithub = function(url) return 'https://ghproxy.com/' .. url end
else
	vim.proxyGithub = function(url) return url end
end
