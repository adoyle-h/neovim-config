local globals = require('adoyle-neovim-config.vim-plug.globals')

local function getId(repo)
	if type(repo) == 'string' then
		if #repo == 0 then error('Invalid value of repo. Cannot be empty string.') end
		return repo
	elseif repo == nil then
		return globals.count
	else
		error('Invalid value of repo. Only nil or "string" can be repo name.')
	end
end

local function getRepo(repo)
	if repo then
		if repo:match('/') then
			return repo
		else
			return nil
		end
	else
		return nil
	end
end

local function normalizeOpts(repo, opts)
	local t = type(repo)

	if not opts then
		if t == 'string' then
			opts = { id = repo, repo = repo }
		elseif t == 'table' then
			opts = repo
			repo = table.remove(opts, 1)
			opts.id = getId(repo)
			opts.repo = getRepo(repo)
		else
			error(string.format('Invalid Plug Type: %s', t))
		end
	else
		opts.id = getId(repo)
		opts.repo = getRepo(repo)
	end

	return opts
end

return normalizeOpts
