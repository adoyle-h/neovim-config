## Plugin

### Create Plugin

For example, create a file `lua/my-plugin.lua`.

### Plugin Options

```lua
return {
  'repo/name', -- string or nil or omit. It must be first
  desc = 'Plugin Description', -- string or nil.
  disable = false, -- boolean or nil. If true, this Plugin will not be loaded
  tag = '', -- string or nil. tag of the repository to use
  branch = '', -- string or nil. branch of the repository to use
  commit = '', -- string or nil. commit of the repository to use
  rtp = '', -- string or nil. Subdirectory that contains Vim plugin
  as = '', -- string or nil. Use different name for the plugin
  ['do'] = '' -- string or nil. Post-update hook (string or funcref)
  on = {'command'} -- string[] or nil. On-demand loading: Commands or <Plug>-mappings
  ['for'] = {'lua'} -- string[] or nil. On-demand loading: File types
  frozon = false, -- boolean or nil. Do not update unless explicitly specified

  config = function(config)
    require('name').setup {config.PluginName}
  end,

  -- Set default config for current plugin
  defaultConfig = {
    {'PluginName'}, -- config key
    {}, -- config value, must be a table
  },

  -- Set highlight groups. Parameters refer to ":h nvim_set_hl"
  highlights = {
    PluginHighlightGroup = { fg = 'white', bg = 'none' } ,
    HighlightName = false, -- false or nil. To cancel plugin default highlight
  },

  -- Set vim sign. Parameters refer to ":h sign_define"
  signs = {
    GitSignsAdd = { text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    SignName = false, -- false or nil. To cancel plugin default sign
  },

  -- Parameters refer to ":h nvim_set_keymap"
  keymaps = {
    { 'n', '<leader>k', ':echo hello<CR>' },
  },

  -- Parameters refer to ":h nvim_create_user_command"
  commands = {
    AerialTelescope = { ':Telescope aerial' },
    ClearPreviews = { function require('goto-preview').close_all_win end },
    TestLuaSpec = {
      function()
        require('plenary.test_harness').test_directory(vim.fn.expand('%:p'))
      end,
      { desc = 'Run unit test on current lua spec file' },
    },
    CommandName = false, -- false or nil. To cancel plugin default command
  },

  autocmds = {
    LspAttach = { -- Parameters refer to ":h nvim_create_autocmd"
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require('aerial').on_attach(client, args.buf)
      end,
    },

    VimEnter = false, -- false or nil. To cancel plugin default autocmd

    User = { -- User autocmds
      {
        pattern = { 'AlphaReady' },
        callback = function()
          vim.opt.cursorline = true
          vim.opt.showtabline = 0
        end,
      },
      {
        pattern = { 'AlphaClosed' },
        callback = function()
          vim.opt.showtabline = 2
        end,
      },
    },
  }

  filetypes = {
    ['null-ls-info'] = function(opts) -- Parameters refer to ":h nvim_create_autocmd" callback arguments
      vim.api.nvim_win_set_config(0, { border = 'rounded', height = 30 })
    end,

    lua = false, -- false or nil. To cancel plugin default filetype callback
  },

  completions = {
    today = { -- completion keyword
      callback = function() -- The returned value will be the completion text
        return os.date('%Y/%m/%d')
      end,
      cache = false, -- If true, callback returned value will be cached
    },

    today2 = false, -- false or nil. To cancel plugin default completion
  }

  -- Add telescope extensions
  telescopes = {
    ls = { -- extension name
      command = '!ls', -- vimscript or lua function
    },

    messages = false -- false or nil. To cancel plugin default telescope extension
  },
}
```

Below fields can receive a function. The function receives one parameter `config` and must return a table.

`defaultConfig`, `signs`, `keymaps` `commands`, `autocmds`, `filetypes`, `highlights`, `telescopes`, `completions`

For example,

```lua
{
  defaultConfig = function(config)
    return {
      {'PluginName'},
      {},
    }
  end,

  highlights = function(config)
    local colors = config.colors
    return {
      PluginHighlightGroup = { fg = colors.white, bg = 'none' } ,
    },
  end,

  commands = function(config)
    return {
      AerialTelescope = { ':Telescope aerial' },
      -- NOTE: require plugin must put in function
      ClearPreviews = { require('goto-preview').close_all_win },
    }
  end,
}
```


### Using Plugin

Edit your `init.lua` file.

```lua
require('adoyle-neovim-config').setup {
  config = {
    plugins = {
      require('my-plugin'),
    },
  },
}
```

When repo name in `plugins` matches existed plugin, your defined options will override the default options of plugin.
When no matches, they will be loaded as new plugins.

### Disable Default Plugin

```lua
require('adoyle-neovim-config').setup {
  config = {
    plugins = {
      {'keymap', disable = true} -- It will disable all keymaps defined in ./lua/adoyle-neovim-config/keymap/
      {'lukas-reineke/indent-blankline.nvim', disable = true} -- It will disable plugin ./lua/adoyle-neovim-config/plugins/indent-line.lua
    },
  },
}
```

### Override plugin configs

For example, change the layout of dashboard and hide nvim logo and version.

```lua
require('adoyle-neovim-config').setup {
  configFn = function(config)
    -- default layout = {
    --   { type = 'padding', val = marginTop },
    --   getHeader(),
    --   getTitle('Press j,k to move cursor'),
    --   buttons,
    -- }
    local layout = config.dashboard.layout
    layout[2] = { type = 'padding', val = 5 }

    -- Do not return config, only return the overrided parts
    return {
      dashboard = { layout = layout },
    }
  end
}
```