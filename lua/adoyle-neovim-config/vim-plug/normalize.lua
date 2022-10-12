local globals = require('adoyle-neovim-config.vim-plug.globals')

local function normalizeOpts(repo, opts)
	local t = type(repo)
	local count = globals.count

	if not opts then
		if t == 'string' then
			opts = { id = count, repo = repo }
		elseif t == 'table' then
			opts = repo
			repo = table.remove(opts, 1)

			if type(repo) == 'string' then
				if #repo == 0 then error('Invalid value of repo. Cannot be empty string.') end
				if repo:match('/') then
					opts.id = repo
					opts.repo = repo
				else
					opts.id = repo
					opts.repo = nil
				end
			elseif repo == nil then
				opts.id = count
				opts.repo = repo
			else
				error('Invalid value of repo. Only nil or "string" can be repo name.')
			end

		else
			error(vim.fn.printf('Invalid Plug Type: %s', t))
		end
	else
		opts.repo = repo
	end

	return opts
end

return normalizeOpts
