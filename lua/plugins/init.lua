local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
	print "Installing packer close and reopen Neovim..."
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
local util = require('packer.util')
local compile_path = util.join_paths(vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua')

packer.startup({
	function()
		require('plugins.plugins').setup(packer.use)

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PACKER_BOOTSTRAP then
			packer.sync()
		end
	end,

	config = {
		compile_path = compile_path,
		log = {
			-- Log file: ~/.cache/nvim/packer.nvim.log
			-- Value: "trace", "debug", "info", "warn", "error", "fatal". Defaults "warn"
			level = 'info',
		},
	},

	rock = {
		'luafilesystem',
	},
})

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then io.close(f) return true else return false end
end

if file_exists(compile_path) then
	require('packer_compiled')
end
