local M = {}

M.plugins = {
	-- deps = {
	-- 	{ 'yetone/avante.nvim', build = 'with-proxy build', disable = true },
	-- },
}

local system_prompt = function(opts)
	return string.format([[
You are a highly capable, honest, and helpful AI assistant.
Your goals are to provide accurate, relevant, and clearly structured responses in fluent, professional %s.

Follow these rules:

- Be concise, clear, respectful.
- Think step by step and show reasoning when helpful.
- Ask clarifying questions if the task is ambiguous.
- Never fabricate information. If uncertain, clearly say so and suggest how to verify or find more details or think outside the box.
- Always consider user’s intent. Offer useful answer rather than literal interpretation.
- Be terse and impersonal, especially if the user responds with context outside of your tasks.
- Response with Markdown format.

When discuss code:

- Start Markdown code blocks with the language name.
- No line numbers or wrapping text in code blocks.
- Output only code relevant to the task, and omit the code shared from user.

When given a task:

- Think step by step and describe the approach in pseudocode (unless told not to).
- Only one reply per turn.
]], opts.language)
end


M.config = {
	-- avante = {
	-- 	provider = 'openai',
	-- 	providers = {
	-- 		openai = {
	-- 			endpoint = 'https://api.vveai.com/v1',
	-- 			model = 'gpt-4o-mini', -- your desired model (or use gpt-4o, etc.)
	-- 			extra_request_body = {
	-- 				timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
	-- 				temperature = 0,
	-- 				max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
	-- 				--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
	-- 			},
	-- 		},
	-- 	},

	-- 	-- https://github.com/yetone/avante.nvim#web-search-engines
	-- 	web_search_engine = {
	-- 		provider = 'brave', -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
	-- 		proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
	-- 	},
	-- },

	codecompanion = {
		strategies = {
			chat = {
				adapter = 'gpt-4o-mini',
			},
			inline = {
				adapter = 'gpt-4o-mini',
			},
			cmd = {
				adapter = 'gpt-4o-mini',
			},
		},

		opts = {
			log_level = 'INFO',
			language = 'Chinese',
			system_prompt = system_prompt,
		},

		extensions = {
			history = {
				opts = {
					summary = {
						generation_opts = {
							adapter = 'mistral:7b',
						},
					},
				},
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
				})
			end,

			['gpt-4o-mini'] = function()
				return require('codecompanion.adapters').extend('vapi', {
					name = 'gpt-4o-mini',
					formatted_name = 'gpt-4o-mini',
					schema = {
						model = {
							default = 'gpt-4o-mini',
						},
					},
				})
			end,

			['gpt-4o'] = function()
				return require('codecompanion.adapters').extend('vapi', {
					name = 'gpt-4o',
					schema = {
						model = {
							default = 'gpt-4o',
						},
					},
				})
			end,

			['mistral:7b'] = function()
				return require('codecompanion.adapters').extend('ollama', {
					-- name = 'ollama', -- Give this adapter a different name to differentiate it from the default ollama adapter
					name = 'mistral:7b',
					schema = {
						model = {
							default = 'mistral:7b',
						},
					},
				})
			end,
		},

		prompt_library = {
			['简易对话'] = {
				strategy = 'chat',
				description = '一次性问答',
				prompts = {
					{
						role = 'system',
						content = [[
You are a highly capable, honest, and helpful AI assistant.
Your goals are to provide concise, clear, accurate, relevant responses in Chinese with Markdown formatting.
					]],
					},
				},
			},
		},
	},

}

return M;
