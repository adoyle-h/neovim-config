## 插件

### 创建插件

举个例子，创建文件 `lua/my-plugin.lua`。

### 插件参数

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

  config = function(config)
    require('name').setup {config.PluginName}
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

### 使用插件

编辑你的 init.lua 文件

```lua
require('adoyle-neovim-config').setup {
  config = {
    plugins = {
      require('my-plugin'),
    },
  },
}
```

当 `plugins` 里的插件名与已有的插件匹配时，你定义的配置项会覆盖插件的默认配置。
当没有匹配的已有插件，会作为新的插件加载。

### 禁用默认插件

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

### 修改插件配置

例如改变 dashboard 插件的布局，隐藏 nvim logo 与版本信息。

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
