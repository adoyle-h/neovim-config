local util = require('adoyle-neovim-config.util')

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	print "Installing packer.nvim ..."
	PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- Only required if you have packer configured as `opt`
vim.cmd('packadd packer.nvim')

local packer = require('packer')
local packerUtil = require('packer.util')
local compile_path = packerUtil.join_paths(vim.fn.stdpath('config'), 'lua', 'packer_compiled.lua')

packer.startup({
	function()
		require('adoyle-neovim-config.plugins.setup').setup(packer.use)

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PACKER_BOOTSTRAP then
			packer.sync()
		end
	end,

	config = {
		compile_path = compile_path,

		max_jobs = 16,

		git = {
			subcommands = { -- Format strings for git subcommands
				install = 'clone --depth %i --single-branch --progress',
			},
			default_url_format = util.proxyGithub 'https://github.com/%s',
			clone_timeout = 30, -- Timeout, in seconds, for git clones
		},

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

if fn.empty(fn.glob(compile_path)) == 0 then
	require('packer_compiled')
end
