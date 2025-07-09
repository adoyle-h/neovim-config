local M = {}

M.plugins = {
	deps = {
		{ 'yetone/avante.nvim', build = 'with-proxy build', disable = true },
	},
}

M.config = {
	avante = {
		provider = 'openai',
		providers = {
			openai = {
				endpoint = 'https://api.vveai.com/v1',
				model = 'gpt-4o-mini', -- your desired model (or use gpt-4o, etc.)
				extra_request_body = {
					timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
					temperature = 0,
					max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
					--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
				},
			},
		},

		-- https://github.com/yetone/avante.nvim#web-search-engines
		web_search_engine = {
			provider = 'brave', -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
			proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
		},
	},

	codecompanion = {
		strategies = {
			chat = {
				adapter = 'vapi',
				model = 'gpt-4o-mini',
			},
			inline = {
				adapter = 'vapi',
				model = 'gpt-4o-mini',
			},
			cmd = {
				adapter = 'vapi',
				model = 'gpt-4o-mini',
			},
		},

		adapters = {
			-- openai = function()
			-- 	return require('codecompanion.adapters').extend('openai', {
			-- 		schema = {
			-- 			model = {
			-- 				default = 'gpt-4.1',
			-- 			},
			-- 		},
			-- 	})
			-- end,

			['vapi'] = function()
				return require('codecompanion.adapters').extend('openai_compatible', {
					env = {
						url = 'https://api.vveai.com',
						api_key = os.getenv('AVANTE_OPENAI_API_KEY'),
						chat_url = '/v1/chat/completions',
					},

					schema = {
						model = {
							default = 'gpt-4o-mini',
						},
					},
				})
			end,

			ollama = function()
				return require('codecompanion.adapters').extend('ollama', {
					name = 'ollama', -- Give this adapter a different name to differentiate it from the default ollama adapter
					schema = {
						model = {
							default = 'mistral:7b',
						},
					},
				})
			end,
		},

	},
}

return M;
