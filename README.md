# ADoyle-Style Neovim Configuration

All-in-one neovim configuration implemented with Lua. It is high flexible to be customized and extended.

中文文档 [./README.zh.md](./README.zh.md)

## TOC
## Features
<!-- MarkdownTOC GFM -->

- [Screenshots](#screenshots)
    - [Dashboard](#dashboard)
    - [Finder](#finder)
    - [UI](#ui)
    - [Outline](#outline)
    - [Diagnostic Window](#diagnostic-window)
    - [Completion](#completion)
    - [Snippet](#snippet)
- [Dependency](#dependency)
- [Installation](#installation)
- [API](#api)
    - [setup(opts)](#setupopts)
- [Configuration](#configuration)
    - [User Config](#user-config)
    - [Default Config](#default-config)
    - [View Config](#view-config)
- [NOTE](#note)
- [Usage](#usage)
    - [Keymaps](#keymaps)
    - [LSP](#lsp)
    - [Code Format](#code-format)
- [Startup Time](#startup-time)
- [Plugin](#plugin)
    - [Create Plugin](#create-plugin)
    - [Using Plugin](#using-plugin)
- [Project File Structure](#project-file-structure)
- [Suggestion, Bug Reporting, Contributing](#suggestion-bug-reporting-contributing)
- [Copyright and License](#copyright-and-license)

<!-- /MarkdownTOC -->

- All in Lua. All configs can be overrided.
- Use many Neovim features: Native LSP, Float Window, Winbar.
- Lua-wrapped plugin manage framework based on [vim-plug][]. Support on-demand loading plugins.
- Integrated 110+ powerful Vim/Nvim plugins.
- Awesome UI and color schema. Dark Mode. Support True-Color, Scrollbar, Dashboard.
- Configurable. See [./lua/config.lua](./lua/config.lua)
- Configurable proxy for fast git download in China Mainland

## Screenshots

### Dashboard

![dashboard.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/dashboard.png)

### Finder

![finder.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/finder.png)

### UI

![UI.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/UI.png)

### Outline

![outline.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/outline.png)

### Diagnostic Window

![diagnostic.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/diagnostic.png)

### Completion

![completion.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/completion.png)

![completion-function-args.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/completion-function-args.png)

### Snippet

![snippet.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/snippet.png)


## Dependency

- NVIM v0.8 (latest commit)
- Vim Plugin Manager: https://github.com/junegunn/vim-plug
- python3、pip3
- nvim python provider
  - `pip3 install --upgrade --user pynvim`
  - `pip2 install --upgrade --user pynvim` (it is optional)
- [Nerd Font][]. Recommend [DejaVuSansMonoForPowerline Nerd Font][font]. And change your terminal font setting.
- Linux and MacOS are supported. Windows not.

## Installation

1. You have two ways to use the project. Use the project directly, or load the project as an plugin for more customizations.

  a. Directly use

    ```sh
    # Set your nvim config directory
    NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
    git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_HOME"
    ```

  b. Load as plugin

    ```sh
    # Set your nvim config directory
    NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
    NVIM_DATA=${XDG_CONFIG_HOME:-$HOME/.local/share}/nvim
    mkdir -p "$NVIM_HOME"/{temp,snippets,spell}
    mkdir -p "$NVIM_DATA"/plugins
    git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_DATA"/plugins/adoyle-neovim-config

    # Create init.lua file
    cat <<EOF > "$NVIM_HOME"/init.lua
    vim.opt.rtp:prepend { vim.fn.stdpath('data') .. '/plugins/adoyle-neovim-config' }

    require('adoyle-neovim-config').setup {}
    EOF
    ```

  c. Out of the box

    ```sh
    docker run -it <TODO>
    ```

2. Initialization
  - `:PlugInstall`.
    - All plugines installed in `~/.local/share/nvim/plugins`. You can modify the plugin directory with the `pluginDir` option in [default config][default-config].
    - It maybe slow, please be patient. you can set proxy via `config.proxy.github`.
  - There no any Treesitter Parer installed by default. Invoke `:TSInstall all` to install them.
3. `nvim` to get started.

## API

### setup(opts)

```lua
local A = require('adoyle-neovim-config')

A.setup {
  config = {},
}

-- or
-- A.setup()
```

No more document. Just see [codes](./lua/adoyle-neovim-config/init.lua)

## Configuration

### User Config

You can pass config when load as plugin.

```lua
require('adoyle-neovim-config').setup {
  config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/').
			-- Otherwise, remove this option.
			github = 'https://ghproxy.com/',
		},
  },

	-- Add your plugins or override plugin default options.
  -- More examples in ./lua/adoyle-neovim-config/plugins.lua
  plugins = {
    -- { 'plugins.profiling', disable = false },
    -- { 'psliwka/vim-smoothie', disable = false },
  },

	pluginConfigs = function()
    return {
			nullLS = {
        lsp = {
          ensureInstalled = {
            'bash-language-server',
          }
        }
      }
    }
  end,
}
```

When repo name in `plugins` matches existed plugin, your defined options will override the default options of plugin. When no matches, it will be loaded as new plugins.

Existed plugins list in [./lua/adoyle-neovim-config/plugins.lua](./lua/adoyle-neovim-config/plugins.lua)
See [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua) for details.

User config can refer to [./init.lua](./init.lua).

### Default Config

Parts of default config written in [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua), and other parts written in `defaultConfig` of each plugin.

Parts of default highlights written in [./lua/adoyle-neovim-config/config/color.lua](./lua/adoyle-neovim-config/config/color.lua) and [./lua/adoyle-neovim-config/config/highlights.lua](./lua/adoyle-neovim-config/config/highlights.lua), and other parts written in `highlights` of each plugin.

### View Config

`:ShowConfig` to view final merged config.
`:ShowPlugin` to view loaded plugins.

Because using [inspect.lua](https://github.com/kikito/inspect.lua) to print configuration,
you may see tags such as `<table id>`. It is for preventing infinite loops.
You can search `<28>{` to view its value for `<table 28>` in same buffer content.

> inspect can handle tables with loops inside them. It will print <id> right before the table is printed out the first time, and replace the whole table with <table id> from then on, preventing infinite loops.

For `<table>`, `<function>`, `<metatable>` tags, see [inspect.lua](https://github.com/kikito/inspect.lua#examples-of-use).

## NOTE

`$VIMRUNTIME/filetype.vim` will not run, please put filetype detection in [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua).

## Usage

### Keymaps

For basic intro, see [./doc/keymaps.md](./doc/keymaps.md).

Press `<space>k` to see all keymaps in nvim.

### LSP

Using [nvim-lspconfig][] and [null-ls][] to manage LSP. And using [mason.nvim][] to manege lsp, dap and null-ls packages.

- Call `:Mason` or press `<Alt-m>` to view LSP installations.
- Call `:LspInfo` to show LSP for current file.
- Call `:NullLsInfo` to show LSP for current file.

### Code Format

The code formatting is based on LSP. Using `lsp-format` instead of nvim builtin `vim.lsp.buf.format` to provide more flexible configurations. See [lsp-format options](https://github.com/lukas-reineke/lsp-format.nvim#special-format-options).

You can set multi formatters to format codes at the same time. And you can also change the order of formatters by filetype.

The configs of formatter are at `lsp.format` and `nullLS.sources`.
Default to use the formatters defined in `nullLS.sources`, and then formatters defined in `lsp.format`.

## Startup Time

```lua
require('adoyle-neovim-config').setup {
	plugins = {
		{ 'profiling', disable = true },
  }
}
```

Enable [plugins/profiling](./lua/plugins/profiling.lua) and invoke `:StartupTime` in nvim. It will print below results,

```
       startup: 382.3
event                  time percent plot
init.lua             290.79   76.06 ██████████████████████████
adoyle-neovim-config  44.18   11.55 ████
loading rtp plugins   22.58    5.91 ██
pears                 15.91    4.16 █▍
neo-tree              14.76    3.86 █▍
pears.config          12.48    3.27 █▏
cmp                   12.11    3.17 █▏
cmp.core              11.07    2.90 █
telescope._extension  10.87    2.84 █
```

## Plugin

### Create Plugin

For example, create a file `lua/my-plugin.lua`.

```lua
return {
  'repo/name', -- string or nil or omit. It must be first
	desc = 'Plugin Description', -- string or nil.
	disable = false, -- boolean or nil. If true, this Plugin will not be loaded
  tag = '', -- string or nil. tag of the repository to use
  branch = '', -- string or nil. branch of the repository to use
  commit = '', -- string or nil. commit of the repository to use
  rtp = '', -- string or nil. Subdirectory that contains Vim plugin
  on = {'command'} -- string[] or nil. On-demand loading: Commands or <Plug>-mappings
  for = {'lua'} -- string[] or nil. On-demand loading: File types
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
    { 'PluginHighlightGroup', { fg = 'white', bg = 'none' } },
  }
  -- or function
  highlights = function(config)
    return {
      { 'PluginHighlightGroup', { fg = 'white', bg = 'none' } },
    },
  end

  -- Parameters refer to ":h nvim_set_keymap"
  keymaps = {
    { 'n', '<leader>k', ':echo hello<CR>' },
  },
  -- or function
  keymaps = function(config)
    return {
      { 'n', '<leader>k', ':echo hello<CR>' },
    },
  end

  -- Parameters refer to ":h nvim_create_user_command"
  commands = {
    { 'ClearPreviews', function require('goto-preview').close_all_win end, {} },
  },
  -- or function
	commands = function(config)
		return {
			{ 'ClearPreviews', require('goto-preview').close_all_win, {} },
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

## Project File Structure

```
.
├── README.md
├── autoload/
│   └── plug.vim             // vim-plug source code
├── init.lua                 // Neovim configuration entry point (user config put here)
├── lsp-settings             // Global LSP settings
├── lua
│   └── adoyle-neovim-config
│       ├── config/          // Keymaps
│       │   ├── color.lua    // Default color config
│       │   └── default.lua  // Default config
│       ├── config.lua       // Config loader
│       ├── fix-lua.lua
│       ├── init.lua         // The lua required entry point (plugin way)
│       ├── plugins.lua      // Plugin loading list
│       ├── util.lua         // Utility functions
│       ├── util_spec.lua    // Unit test for util.lua
│       ├── vim-plug/        // Plugin framework based on vim-plug
│       ├── keymap/          // Keymaps
│       ├── plugins/         // Available plugins written in lua
│       └── themes/          // Color schemas
├── snippets/                // Code Snippets
└── spell/                   // Spell check data (git ignored)
    └── en.utf-8.add
```

## Suggestion, Bug Reporting, Contributing

Any comments and suggestions are always welcome. Please open an [issue][] to contact with me.

Please read [./doc/contribution.md](./doc/contribution.md) how to contribute.

## Copyright and License

Copyright 2016-2022 ADoyle (adoyle.h@gmail.com) All Rights Reserved. The project is licensed under the **BSD 3-clause License**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.


<!-- links -->

[issue]: https://github.com/adoyle-h/neovim-config/issues
[LICENSE]: ./LICENSE
[font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DejaVuSansMono
[Nerd Font]: https://github.com/ryanoasis/nerd-fonts
[vim-plug]: https://github.com/junegunn/vim-plug
[default-config]: ./lua/adoyle-neovim-config/config/default.lua
[mason.nvim]: https://github.com/williamboman/mason.nvim
[null-ls]: https://github.com/jose-elias-alvarez/null-ls.nvim
[nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig
