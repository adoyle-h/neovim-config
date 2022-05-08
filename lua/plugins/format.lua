local M = {
	nil,
	desc = 'Format Settings',
	disable = false,
}

local function configEasyAlign()
	vim.g.easy_align_delimiters = {
    ['>'] = {
      pattern = '>>|=>|>',
    },

    ['/'] = {
      pattern = '//+|/*|*/',
      delimiter_align = 'l',
      ignore_groups = {'!Comment'},
    },

    [']'] = {
      pattern = '[[]]',
      left_margin = 0,
      right_margin = 0,
      stick_to_left = 0,
    },

    [')'] = {
      pattern = '[()]',
      left_margin = 0,
      right_margin = 0,
      stick_to_left = 0,
    },

    ['d'] = {
      pattern = ' (S+s*[;=])@=',
      left_margin = 0,
      right_margin = 0,
    },
   }

	 vim.cmd [[
		nmap <leader>A <Plug>(EasyAlign)
		xmap <leader>A <Plug>(EasyAlign)
		nmap <leader>a <Plug>(LiveEasyAlign)
		xmap <leader>a <Plug>(LiveEasyAlign)
	 ]]
end

M.requires = {
	{'editorconfig/editorconfig-vim', desc = '.editorconfig support'},
	{
		'sbdchd/neoformat',
		config = function()
			vim.g.neoformat_enabled_javascript = {'prettier', 'prettydiff', 'prettiereslint'}
		end,
	},
	{'Chiel92/vim-autoformat', desc = '整理格式。并且自带的 RemoveTrailingSpaces 也可以去空格'},
	{'rhlobo/vim-super-retab', on = {'Space2Tab', 'Tab2Space'}},
	{'tpope/vim-sleuth', desc = '根据上下文自动调整 shiftwidth expandtab'},
	{'junegunn/vim-easy-align', on = {'<Plug>(EasyAlign)', 'EasyAlign'}, config = configEasyAlign },
}

return M
