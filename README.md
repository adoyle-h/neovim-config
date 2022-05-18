# ADoyle-Style Neovim Configuration

Neovim 一体化配置。可作为插件使用。有足够的自由度去定制和扩展它。

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
- [配置](#配置)
- [目录结构](#目录结构)
- [注意](#注意)
- [启动时间](#启动时间)
- [建议，Bug，做贡献](#建议bug做贡献)
- [版权声明](#版权声明)

<!-- /MarkdownTOC -->

## 特性

- 所有配置都用 Lua 管理
- 使用 Neovim Native LSP
- 基于 [vim-plug][] 和 Lua 的插件管理框架。支持按需加载。
- 集成众多强大的 Vim 插件
- 帅气的界面和配色。暗黑模式。真彩色。滚动条。
- 可配置，详见[默认配置][default-config]
- 可配置 github 的代理镜像，在中国大陆可加快插件下载速度

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

- NVIM v0.7 及以上版本
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
  - `:LspInstallInfo` 默认未安装任何 LSP。执行此命令，选择你需要的 LSP，并按回车安装。
3. 执行 `nvim` 开始。

## API

```lua
local A = require('adoyle-neovim-config')
print(vim.inspect(A))

A.setup()
```

没写文档，直接看[代码](./lua/adoyle-neovim-config/init.lua)

## 配置

当以插件加载时，你可以传入自定义配置。

```lua
require('adoyle-neovim-config').setup {
  config = {
    plugins = { -- 覆盖插件默认配置
      ['plugins.profiling'] = {
        disable = false, -- 设置成 false 来启动默认禁用的插件
      },

      ['psliwka/vim-smoothie'] = {
        disable = false,
      },
    },
  },
  plugins = function(A)
    -- A.Plug 'github/repo'
  end
}
```

详见 [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua)

插件列表见 [./lua/adoyle-neovim-config/plugins.lua](./lua/adoyle-neovim-config/plugins.lua)

## 目录结构

```
.
├── README.md
├── autoload/
│   └── plug.vim       // vim-plug
├── init.lua           // neovim configuration entry point (directly use way)
├── lua
│   └── adoyle-neovim-config
│       ├── basic.lua        // Basic Settings. Some options may be overrided by plugin
│       ├── config/          // Keymaps
│       │   └── default.lua  // default config
│       ├── config.lua       // config loader
│       ├── fix-lua.lua
│       ├── init.lua         // The lua required entry point (plugin way)
│       ├── plugins.lua      // Plugin loading list
│       ├── util.lua         // utility functions
│       ├── vim-plug.lua     // Plugin manage framework based on vim-plug
│       ├── keymap/          // Keymaps
│       ├── plugins/         // Available plugins written in lua
│       └── themes/          // color schemas
├── snippets/          // code snippets
├── spell/             // spell check data
├── test/              // Unit tests
└── temp/              // temporary files
    ├── session        // xolox/vim-session plugin
    ├── session_lock   // xolox/vim-session plugin
    └── undodir        // mbbill/undotree plugin
```

插件默认安装在 `~/.local/share/nvim/plugins`。你可以修改插件目录。查看[默认配置][default-config]里的 `pluginDir` 选项。

## 注意

`$VIMRUNTIME/filetype.vim` 不会被调用，文件类型设置请见 [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua)。

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
