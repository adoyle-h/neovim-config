# ADoyle-Style Neovim Configuration

Lua 编写的 Neovim 一体化配置。可作为 Lua 包加载。易配置，可扩展。

Click [./README.en.md](./README.en.md) to read English documents.

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
- [用户配置](#用户配置)
- [默认配置](#默认配置)
- [目录结构](#目录结构)
- [注意](#注意)
- [LSP](#lsp)
- [代码格式化](#代码格式化)
- [启动时间](#启动时间)
- [建议，Bug，做贡献](#建议bug做贡献)
- [版权声明](#版权声明)

<!-- /MarkdownTOC -->

## 特性

- 用 Lua 管理所有配置。
- 充分使用 Neovim 特性：Native LSP、Float Window、Winbar。
- 基于 [vim-plug][] 的 Lua 插件管理框架。支持按需加载。
- 集成了 106 个 Vim/Nvim 插件。
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

- NVIM v0.8 (最新提交的版本)
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

  b. 插件加载

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

    require('adoyle-neovim-config').setup {
      config = {
        proxy = {
          -- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/').
          -- Otherwise, remove this option.
          github = 'https://ghproxy.com/', -- emptry string or proxy url
        }
      },
    }
    EOF
    ```

2. 初始化
  - `:PlugInstall` 安装 vim 插件。可能会比较慢，请耐心等待。
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

## 用户配置

当以插件加载时，你可以传入自定义配置。

```lua
require('adoyle-neovim-config').setup {
  config = {
		proxy = {
			-- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/').
			-- Otherwise, remove this option.
			github = 'https://ghproxy.com/',
		},

    pluginOpts = { -- 覆盖插件默认配置
      ['plugins.profiling'] = {
        disable = false, -- 设置成 false 来启动默认禁用的插件
      },

      ['psliwka/vim-smoothie'] = {
        disable = false,
      },
    },

    plugins = {
      function(A)
        -- A.Plug 'github/repo'
      end,
    },
  },

}
```

用户配置可参考 [./init.lua](./init.lua)

插件列表见 [./lua/adoyle-neovim-config/plugins.lua](./lua/adoyle-neovim-config/plugins.lua)

## 默认配置

默认配置详见 [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua)

默认颜色配置详见 [./lua/adoyle-neovim-config/config/color.lua](./lua/adoyle-neovim-config/config/color.lua)

## 目录结构

```
.
├── README.md
├── autoload/
│   └── plug.vim       // vim-plug source code
├── init.lua           // Neovim configuration entry point (directly use way)
├── lsp-settings       // Global LSP settings
├── lua
│   └── adoyle-neovim-config
│       ├── config/          // Keymaps
│       │   ├── color.lua    // Default color config
│       │   └── default.lua  // Default config
│       ├── config.lua       // Config loader
│       ├── fix-lua.lua
│       ├── init.lua         // The lua required entry point (plugin way)
│       ├── plugins.lua      // Plugin loading list
│       ├── util.lua         // utility functions
│       ├── util_spec.lua    // unit test for util.lua
│       ├── vim-options.lua
│       ├── extend.lua       // General user functions and commands
│       ├── vim-plug.lua     // Plugin manage framework based on vim-plug
│       ├── keymap/          // Keymaps
│       ├── plugins/         // Available plugins written in lua
│       └── themes/          // color schemas
├── snippets/          // Code Snippets
├── spell/             // Spell check data (git ignored)
│   └── en.utf-8.add
├── test/              // Unit tests
└── temp/              // temporary files
    ├── session        // xolox/vim-session plugin
    ├── session_lock   // xolox/vim-session plugin
    └── undodir        // mbbill/undotree plugin
```

插件默认安装在 `~/.local/share/nvim/plugins`。你可以修改插件目录。查看[默认配置][default-config]里的 `pluginDir` 选项。

## 注意

`$VIMRUNTIME/filetype.vim` 不会被调用，文件类型设置请见 [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua)。

## LSP

- 执行 `:Mason` 或者按 `<space>M` 查看 LSP 安装情况。
- 执行 `:LspInfo` 查看当前文件使用的 LSP。
- 执行 `:NullLsInfo` 查看当前文件使用的 LSP。

## 代码格式化

基于 LSP 实现代码格式化，`nvim-lspconfig` 和 `null-ls` 提供 LSP 与文件 buffer 的关联。

使用 `lsp-format` 代替 `vim.lsp.buf.format`，提供更灵活的自定义配置。详见 [lsp-format 选项](https://github.com/lukas-reineke/lsp-format.nvim#special-format-options)。

同一个文件可以使用多个 Formatter 格式化代码，并指定 Formatter 调用顺序。
按默认配置 (`lsp.format` 与 `lsp.nullLS.sources`)，先使用 null-ls 指定顺序的 Formatter，后使用 lsp-format 指定顺序的 Formatter。

## 启动时间

启动插件 [plugins/profiling](./lua/plugins/profiling.lua) 并调用 `:StartupTime`.

```
startup: 339.8
event                  time percent plot
init.lua             129.06   37.98 ██████████████████████████
loading rtp plugins   46.32   13.63 █████████▍
opening buffers       42.66   12.56 ████████▋
NERD_tree.vim         14.90    4.38 ███
first screen update    6.91    2.03 █▍
VimEnter autocommand   6.56    1.93 █▍
syntax.vim             4.67    1.37 █
done waiting for UI    4.39    1.29 ▉
loading after plugin   4.38    1.29 ▉
reading ShaDa          3.68    1.08 ▊
```

## 建议，Bug，做贡献

欢迎提供任何建议或者意见。请开 [issue][] 与我联系。

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
