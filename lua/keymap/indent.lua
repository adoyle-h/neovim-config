local M = {
	nil,
	desc = 'Indent Keymap',
	disable = false,
}

local function indentLevel(lnum)
	return vim.fn.indent(lnum) / vim.bo.shiftwidth
end

function M.config()
	local keymap = vim.keymap.set

	keymap('n', '<', '<<', { noremap = true, silent = true, desc = 'unindent line' })
	keymap('n', '>', '>>', { noremap = true, silent = true, desc = 'indent line' })
	keymap('v', '<', '<gv', { noremap = true, silent = true, desc = 'unindent line while keep visual selected' })
	keymap('v', '>', '>gv', { noremap = true, silent = true, desc = 'indent line while keep visual selected' })

	keymap('n', '<Tab>', 'za', {
		noremap = true, silent = true,
		desc = 'When cursor on a closed fold: open it. When cursor on an open fold, close it.',
	})

	keymap('n', '<M-Tab>', function()
		local l = indentLevel(vim.fn.line('.')) - 1
		if vim.wo.fdl == l then
			vim.wo.fdl = 99
		else
			vim.wo.fdl = l
		end
	end, {
		noremap = true, silent = true,
		desc = 'Similar to <Tab>, but effect all paragraphs in same fold level.'
	})

end

return M
