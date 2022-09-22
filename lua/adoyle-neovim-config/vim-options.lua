-- Set default options for vim/nvim. Use :help 'option' to see the documentation for the given option.
local config = require('adoyle-neovim-config.config').config

local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

for key, value in pairs(config.vim.g) do g[key] = value end
for key, value in pairs(config.vim.opt) do opt[key] = value end
for _, value in pairs(config.vim.cmd) do cmd(value) end
