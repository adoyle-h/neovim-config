# ADoyle-Style Neovim Configuration

用 Lua 编写的 Neovim 一体化配置。易配置，可扩展。

Click [./README.md](./README.md) to read English documents.

## TOC

<!-- MarkdownTOC GFM -->

- [特性](#特性)
- [截图](#截图)
    - [Dashboard](#dashboard)
    - [Finder](#finder)
    - [UI](#ui)
    - [Outline](#outline)
    - [Diagnostic Window](#diagnostic-window)
    - [Completion](#completion)
    - [Snippet](#snippet)
- [依赖](#依赖)
- [安装](#安装)
- [API](#api)
    - [setup(opts)](#setupopts)
- [配置](#配置)
    - [用户配置](#用户配置)
    - [默认配置](#默认配置)
    - [查看配置](#查看配置)
- [注意](#注意)
- [使用](#使用)
    - [快捷键](#快捷键)
    - [LSP](#lsp)
    - [格代化码式](#格代化码式)
- [启动时间](#启动时间)
- [插件](#插件)
    - [创建插件](#创建插件)
    - [使用插件](#使用插件)
- [项目文件结构](#项目文件结构)
- [建议，Bug，做贡献](#建议bug做贡献)
- [版权声明](#版权声明)

<!-- /MarkdownTOC -->

## 特性

- 用 Lua 管理所有配置。配置可覆盖。
- 充分使用 Neovim 特性：Native LSP、Float Window、Winbar。
- 基于 [vim-plug][] 的 Lua 插件管理框架。支持按需加载插件。
- 集成了 110 多个 Vim/Nvim 插件。
- 帅气的界面和配色。暗黑模式。支持真彩色、滚动条、Dashboard。
- 可配置，详见[默认配置][default-config]。
- 支持配置 github 代理，在中国大陆可加快插件下载速度。

## 截图

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

## 依赖

- NVIM v0.8 (最新的 commit 版本)
- python3、pip3
- nvim python provider
  - `pip3 install --upgrade --user pynvim`
  - `pip2 install --upgrade --user pynvim` (这是可选的)
- [Nerd Font 字体][Nerd Font]。推荐 [DejaVuSansMonoForPowerline Nerd Font][font]。然后修改你的终端的字体设置。
- 支持 Linux 和 MacOS，不支持 Windows

## 安装

1. 你可以直接使用本项目。也可以插件的形式加载本项目，定制你的功能。

  a. 直接使用

    ```sh
    # 设置你的 nvim 配置目录
    NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
    git clone --depth 1 https://github.com/adoyle-h/neovim-config.git "$NVIM_HOME"
    ```

  b. 加载插件

    ```sh
    # 设置你的 nvim 目录
    NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
    NVIM_DATA=${XDG_CONFIG_HOME:-$HOME/.local/share}/nvim
    mkdir -p "$NVIM_HOME"/{temp,snippets,spell}
    mkdir -p "$NVIM_DATA"/plugins
    git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_DATA"/plugins/adoyle-neovim-config

    # 创建 init.lua 文件
    cat <<EOF > "$NVIM_HOME"/init.lua
    vim.opt.rtp:prepend { vim.fn.stdpath('data') .. '/plugins/adoyle-neovim-config' }

    require('adoyle-neovim-config').setup {}
    EOF
    ```

  c. 开箱即用

    ```sh
    docker run -it <TODO>
    ```

2. 初始化
  - `:PlugInstall` 安装 vim 插件。
    - 插件默认安装在 `~/.local/share/nvim/plugins`。你可以修改插件目录。查看[默认配置][default-config]里的 `pluginDir` 选项。
    - 下载插件可能会比较慢，请耐心等待。如果你在中国大陆，可以使用镜像代理加速，详见配置项 `config.proxy.github`。
  - `:TSInstall all` 默认未安装 Treesitter Parser。执行此命令，一键安装所有。
3. 执行 `nvim` 开始。

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

没写文档，直接看[代码](./lua/adoyle-neovim-config/init.lua)

## 配置

### 用户配置

当以插件加载时，你可以传入自定义配置。

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

当 `plugins` 里的插件名与已有的插件匹配时，你定义的配置项会覆盖插件的默认配置。当没有匹配的已有插件，会作为新的插件加载。

已有的插件见 [./lua/adoyle-neovim-config/plugins.lua](./lua/adoyle-neovim-config/plugins.lua)

默认配置详见 [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua)。

用户配置可参考 [./init.lua](./init.lua)。

### 默认配置

部分默认配置写在 [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua)，部分写在插件的 `defaultConfig` 里。

部分默认颜色配置写在 [./lua/adoyle-neovim-config/config/color.lua](./lua/adoyle-neovim-config/config/color.lua) 与 [./lua/adoyle-neovim-config/config/highlights.lua](./lua/adoyle-neovim-config/config/highlights.lua)，另一部分写在插件的 `highlights` 里。

### 查看配置

`:ShowConfig` 查看最终合并的配置。
`:ShowPlugin` 查看加载的插件。

因为使用了 [inspect.lua](https://github.com/kikito/inspect.lua) 打印配置，
会有例如 `<table id>` 这样的标记。这是为了避免重复，对于 `<table 28>` 搜索文件内对应的 `<28>{` 即可找到相应的值。

> inspect can handle tables with loops inside them. It will print <id> right before the table is printed out the first time, and replace the whole table with <table id> from then on, preventing infinite loops.

`<table>`, `<function>`, `<metatable>` 等标记，详见 [inspect.lua](https://github.com/kikito/inspect.lua#examples-of-use)。

## 注意

`$VIMRUNTIME/filetype.vim` 不会被调用，文件类型设置请见 [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua)。

## 使用

### 快捷键

基本快捷键的查阅 [./doc/keymaps.md](./doc/keymaps.md)。（纯英文，懒得翻译了）

详细快捷键按 `<space>k` 查阅。

### LSP

本项目使用 [nvim-lspconfig][] 和 [null-ls][] 来配置 LSP，管理 LSP 与 Nvim 的连接。
使用 [mason.nvim][] 来安装与管理 lsp，dap 和 null-ls 的第三方包。

- 执行 `:Mason` 或者按 `<Alt-m>` 查看 LSP 安装情况。
- 执行 `:LspInfo` 查看当前文件使用的 LSP。
- 执行 `:NullLsInfo` 查看当前文件使用的 LSP。

[nvim-lspconfig][] 封装了一系列 LSP 客户端配置，能够开箱即用。它提供灵活的配置项便于用户自定义，详见[官方文档](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)。

[null-ls][] 是一个虚拟 LSP 客户端，可以将 eslint、prettier 这类非 LSP 的普通命令行转化为 LSP。
它提供统一灵活的配置项便于用户自定义，详见 [null-ls 官方配置文档](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md)。

本项目框架配置默认只安装了 Lua LSP 和 Formatter。本项目配置安装了一系列 LSP。用户可以参考 [config/lsp](./lua/adoyle-neovim-config/config/lsp.lua) 和 [init.lua](./init.lua) 来定制自己的。

### 格代化码式

本项目基于 LSP 来格式化代码。
使用 `lsp-format` 代替 nvim 内置的 `vim.lsp.buf.format`，提供更灵活的自定义配置。详见 [lsp-format 选项](https://github.com/lukas-reineke/lsp-format.nvim#special-format-options)。

你可以指定多个 Formatter 同时格式化代码。你也可以根据 filetype 调整 Formatter 的调用顺序。

Formatter 配置在 `lsp.format` 与 `nullLS.sources`。
默认先使用定义在 `nullLS.sources` 的 Formatter，后使用定义在 `lsp.format` 的 Formatter。Formatter 执行顺序按定义顺序.

## 启动时间

```lua
require('adoyle-neovim-config').setup {
	plugins = {
		{ 'profiling', disable = true },
  }
}
```

启动插件 [plugins/profiling](./lua/plugins/profiling.lua)，nvim 启动后调用 `:StartupTime`。你将会看到以下结果。

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

## 插件

### 创建插件

举个例子，创建文件 `lua/my-plugin.lua`。

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

	config = function(config)
    require('name').setup {config.PluginName}
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
    { 'CleanPreviews', function require('goto-preview').close_all_win end, {} },
  },
  -- or function
	commands = function(config)
		return {
			{ 'CleanPreviews', require('goto-preview').close_all_win, {} },
		}
	end,

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

## 项目文件结构

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

## 建议，Bug，做贡献

欢迎提供任何建议或者意见。请开 [issue][] 与我联系。

如何为本项目贡献，请见 [./doc/contribution.md](./doc/contribution.md)

## 版权声明

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
