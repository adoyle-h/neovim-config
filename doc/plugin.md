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

  -- Set default config for current plugin
  defaultConfig = {
    {'PluginName'}, -- config key
    {}, -- config value, must be a table
  },
  -- or
  defaultConfig = function(config)
    return {
      {'PluginName'},
      {},
    }
  end,

  -- Set highlight groups. Parameters refer to ":h nvim_set_hl"
  highlights = {
    PluginHighlightGroup = { fg = 'white', bg = 'none' } ,
  },
  -- or function
  highlights = function(config)
    local colors = config.colors
    return {
      PluginHighlightGroup = { fg = colors.white, bg = 'none' } ,
    },
  end,

  -- Set vim sign. Parameters refer to ":h sign_define"
  signs = {
    GitSignsAdd = { text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
  },
  -- or function
  signs = function(config)
    return {
      GitSignsAdd = { text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    },
  end,

  -- Parameters refer to ":h nvim_set_keymap"
  keymaps = {
    { 'n', '<leader>k', ':echo hello<CR>' },
  },
  -- or function
  keymaps = function(config)
    return {
      { 'n', '<leader>k', ':echo hello<CR>' },
    },
  end,

  -- Parameters refer to ":h nvim_create_user_command"
  commands = {
    { 'AerialTelescope', ':Telescope aerial' },
    { 'ClearPreviews', function require('goto-preview').close_all_win end },
  },
  -- or function
  commands = function(config)
    -- require plugin must put in function
    return {
      { 'ClearPreviews', require('goto-preview').close_all_win },
    }
  end,

  -- Add telescope extensions
  telescopes = {
    {
      name = 'ls', -- extension name
      command = '!ls', -- vimscript or lua function
    },
  },
  -- or function
  telescopes = function(config)
    return {
      {
        name = 'ls', -- extension name
        command = '!ls', -- vimscript or lua function
      },
    },
  end
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
