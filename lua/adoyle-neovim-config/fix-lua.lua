-- Fix undefined table.unpack
-- :lua print(_VERSION) returns "Lua 5.1"
-- See https://github.com/neovim/neovim/blob/v0.7.0/runtime/lua/vim/compat.lua
table.unpack = unpack
