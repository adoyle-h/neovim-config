local P = {}
local previewers = require 'telescope.previewers'

function P.cat(opts)
	return previewers.vim_buffer_cat.new(opts or {})
end

function P.gitFileDiff(opts)
	return previewers.git_file_diff.new(opts or {})
end

return P
