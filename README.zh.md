# ADoyle-Style Neovim Configuration

用 Lua 编写的 Neovim 一体化配置。易配置，可扩展。

Click [./README.md](./README.md) to read English documents.

## 特性

- 用 Lua 管理 nvim 配置。所有配置项都可覆盖。
- 充分使用 Neovim 功能：Native LSP、Float Window、Winbar。
- 基于 [vim-plug][] 的 Lua 插件管理框架。支持按需加载插件。
- 帅气的界面和配色。暗黑模式。支持真彩色、平滑滚动、滚动条、Dashboard。你可以修改配色，详见 [doc/colors.md](doc/colors.md)。
- 可配置，详见[配置章节](#配置)。
- 支持配置 github 代理，在中国大陆可加快插件下载速度。详见[代理](#代理)。
- 集成了 120 多个 Vim/Nvim 插件。增强插件的使用体验，并且修复了一些插件的缺点。

  <details close>
  <summary>点击展开/折叠</summary>

  - 面板: [alpha.nvim](lua/adoyle-neovim-config/plugins/dashboard.lua)
  - 大纲: [aerial](lua/adoyle-neovim-config/plugins/aerial.lua) (默认) 或 [majutsushi/tagbar](lua/adoyle-neovim-config/plugins/tagbar.lua)
  - 文件浏览器: [neo-tree](lua/adoyle-neovim-config/plugins/neo-tree.lua) (默认) 或 [nerdtree](lua/adoyle-neovim-config/plugins/nerdtree.lua) 或 [nvim-tree](lua/adoyle-neovim-config/plugins/nvim-tree.lua)
  - 状态栏: [lualine](lua/adoyle-neovim-config/plugins/lualine.lua) (默认) 或 [airline](lua/adoyle-neovim-config/plugins/airline.lua)
  - Buffer 栏: [bufferline](lua/adoyle-neovim-config/plugins/bufferline.lua)
  - 滚动条: [nvim-scrollbar](lua/adoyle-neovim-config/plugins/scrollbar.lua)
  - 平滑滚动: [neoscroll.nvim](lua/adoyle-neovim-config/plugins/scroll.lua)
  - 会话: [persisted](lua/adoyle-neovim-config/plugins/session/persisted.lua) (默认) 或 [possession](lua/adoyle-neovim-config/plugins/session/possession.lua) 或 [xolox/vim-session](lua/adoyle-neovim-config/plugins/session/vim-session.lua) 或 [rmagatti/auto-session](lua/adoyle-neovim-config/plugins/session/auto-session.lua)
  - 模糊查找: [telescope](lua/adoyle-neovim-config/plugins/telescope/main.lua) 与 [ctrlsf](lua/adoyle-neovim-config/plugins/search/ctrlsf.lua)
  - Diagnostics 窗口: [trouble](lua/adoyle-neovim-config/plugins/trouble.lua)
  - 撤销: [vim-mundo](lua/adoyle-neovim-config/plugins/undotree.lua)
  - 语法高亮: [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) 与 [nvim-ts-rainbow](lua/adoyle-neovim-config/plugins/treesitter/rainbow.lua) 与 [nvim-treesitter-pairs](lua/adoyle-neovim-config/plugins/treesitter/pairs.lua)
  - 单词高亮: [vim-interestingwords](lua/adoyle-neovim-config/plugins/highlight-words.lua)
  - 注释代码: [Comment.nvim](lua/adoyle-neovim-config/plugins/comment.lua) (默认) 或 [nerdcommenter](lua/adoyle-neovim-config/plugins/comment_nerd.lua)
  - LSP: [nvim-lspconfig](lua/adoyle-neovim-config/plugins/lsp/main.lua) 与 [treesitter](lua/adoyle-neovim-config/plugins/treesitter/init.lua) 与 [null-ls](lua/adoyle-neovim-config/plugins/lsp/null-ls.lua) 与 [nlsp](lua/adoyle-neovim-config/plugins/lsp/nlsp.lua) 与 [goto-preview](lua/adoyle-neovim-config/plugins/lsp/preview.lua) 与 [lsp-toggle](https://github.com/adoyle-h/lsp-toggle.nvim)
  - DAP: [nvim-dap](lua/adoyle-neovim-config/plugins/dap/init.lua)
  - 格式化: [lsp-format](lua/adoyle-neovim-config/plugins/lsp/format.lua) 与 [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)
  - Formatter, Linter, LSP, DAP 管理器: [mason](lua/adoyle-neovim-config/plugins/lsp/mason.lua) 与 [mason-installer](lua/adoyle-neovim-config/plugins/lsp/mason-installer.lua)
  - 补全: [nvim-cmp](lua/adoyle-neovim-config/plugins/completion/init.lua)
  - Snippets: [nvim-snippy](lua/adoyle-neovim-config/plugins/completion/snippet.lua)
  - Markdown: [plasticboy/vim-markdown](lua/adoyle-neovim-config/plugins/markdown/main.lua) 与 [markdown-preview](lua/adoyle-neovim-config/plugins/markdown/preview.lua) 与 [headlines.nvim](lua/adoyle-neovim-config/plugins/markdown/headlines.lua) 与 [vim-MarkdownTOC](lua/adoyle-neovim-config/plugins/markdown/toc.lua)
  - 括号配对: [nvim-surround](lua/adoyle-neovim-config/plugins/match/surround.lua) 与 [nvim-autopairs](lua/adoyle-neovim-config/plugins/match/autopairs.lua) 与 [nvim-ts-autotag](lua/adoyle-neovim-config/plugins/match/ts-autotag.lua) 与 [vim-matchup](lua/adoyle-neovim-config/plugins/match/matchup.lua)
  - Git: [gitsigns](lua/adoyle-neovim-config/plugins/git/sign.lua) 与 [lazygit](lua/adoyle-neovim-config/plugins/git/lazygit.lua) 与 [diffview.nvim](https://github.com/sindrets/diffview.nvim)
  - 缩进基准线: [indent-blankline](lua/adoyle-neovim-config/plugins/indent-line.lua)
  - 光标移动: [hop.nvim](lua/adoyle-neovim-config/plugins/move/jump.lua) 与 [accelerated-jk](lua/adoyle-neovim-config/plugins/move/accelerated.lua)
  - 窗口选择: [nvim-window-picker](lua/adoyle-neovim-config/plugins/move/window-picker.lua) (默认) 或 [yorickpeterse/nvim-window](lua/adoyle-neovim-config/plugins/move/window-selector.lua) 或 [vim-choosewin](lua/adoyle-neovim-config/plugins/move/choose-window.lua)
  - 窗口大小调整: [simeji/winresizer](lua/adoyle-neovim-config/plugins/window/resize.lua) 与 [windows.nvim](lua/adoyle-neovim-config/plugins/window/maximize.lua)
  - Context: [aerial](lua/adoyle-neovim-config/plugins/aerial.lua) (默认) 或 [navic](lua/adoyle-neovim-config/plugins/navic.lua) 与 [nvim-treesitter-context](lua/adoyle-neovim-config/plugins/treesitter/context.lua)
  - 文本对齐: [vim-easy-align](lua/adoyle-neovim-config/plugins/align.lua)
  - 书签: [vim-bookmarks](lua/adoyle-neovim-config/plugins/bookmark.lua)
  - 标记: [marks.nvim](lua/adoyle-neovim-config/plugins/mark.lua)
  - 日历: [mattn/calendar-vim](lua/adoyle-neovim-config/plugins/calendar.lua)
  - Curl: [rest.nvim](lua/adoyle-neovim-config/plugins/curl.lua)
  - Icons: [devicons](lua/adoyle-neovim-config/plugins/devicons.lua) 与 [icon-picker](lua/adoyle-neovim-config/plugins/icon-picker.lua)
  - UI 增强: [dressing](lua/adoyle-neovim-config/plugins/dressing.lua) 和 [noice](lua/adoyle-neovim-config/plugins/notify/noice.lua)
  - 跳出输出模式的快捷键: [better-escape.nvim](lua/adoyle-neovim-config/plugins/escape.lua)
  - Increment: [increment-activator](lua/adoyle-neovim-config/plugins/increment.lua)
  - Filetype: [filetype.nvim](lua/adoyle-neovim-config/plugins/filetype.lua)
  - Latex: [nabla](lua/adoyle-neovim-config/plugins/latex.lua)
  - 通知: [notify](lua/adoyle-neovim-config/plugins/notify.lua) (默认) 或 [notifier](lua/adoyle-neovim-config/plugins/notifier.lua)
  - 性能调优: [vim-startuptime](lua/adoyle-neovim-config/plugins/profiling.lua)
  - Text-Objects: [wildfire](lua/adoyle-neovim-config/plugins/select.lua) 与 [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  - 表格: [vim-table-mode](lua/adoyle-neovim-config/plugins/table.lua)
  - 终端: [neoterm](lua/adoyle-neovim-config/plugins/terminal/neoterm.lua)
  - 测试: [nvim-test](lua/adoyle-neovim-config/plugins/test.lua)
  - TODO 注释: [todo-comments](lua/adoyle-neovim-config/plugins/todo.lua)
  - 尾空格: [whitespace](lua/adoyle-neovim-config/plugins/trailing.lua)
  - 复制粘贴: [yanky](lua/adoyle-neovim-config/plugins/yank.lua)
  - 禅模式: [twilight 与 zen-mode](lua/adoyle-neovim-config/plugins/zen.lua)
  - 笔记本: [zk](lua/adoyle-neovim-config/plugins/zk.lua)
  - 实时命令: [live-command](https://github.com/smjonas/live-command.nvim)
  - [游戏](lua/adoyle-neovim-config/plugins/funny.lua)

  </details>


## 截图

<details close>
<summary>点击展开/折叠</summary>

### Dashboard

![dashboard.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/dashboard.png)

### UI

![UI.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/UI.png)

### Outline

![outline.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/outline.png)

### Finder

![finder.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/finder.png)

### Keymaps

![keymaps.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/keymaps.png)

### Diagnostic

![diagnostic.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/diagnostic.png)

### Completion

![completion.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/completion.png)

函数签名补全

![completion-function-args.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/completion-function-args.png)

### Float Cmdline

![cmdline.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/cmdline.png)

</details>

## 依赖

- [NVIM v0.8][] 及以上版本
- python3、pip3
- nvim python provider
  - `pip3 install --upgrade --user pynvim`
  - `pip2 install --upgrade --user pynvim` (这是可选的)
- Git
- C 编译器与 libstdc++。([treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements) 需要)
- [Nerd Font 字体][Nerd Font]。推荐 [DejaVuSansMonoForPowerline Nerd Font][font]。记得修改你的终端的字体设置。
- [ripgrep(rg)](https://github.com/BurntSushi/ripgrep)
- 支持 Linux 和 MacOS，不支持 Windows

## 安装

你有三种方式安装本项目。

1. 以插件的形式加载。
2. 使用容器，开箱即用。
3. 直接 Git clone 本项目。

### 插件形式加载

```sh
# 设置你的 nvim 目录
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
NVIM_DATA=${XDG_CONFIG_HOME:-$HOME/.local/share}/nvim
mkdir -p "$NVIM_DATA"/plugins
git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_DATA"/plugins/adoyle-neovim-config

# 创建 init.lua 文件
cat <<EOF > "$NVIM_HOME"/init.lua
vim.opt.rtp:prepend { vim.fn.stdpath('data') .. '/plugins/adoyle-neovim-config' }

require('adoyle-neovim-config').setup {}
EOF
```

[初始化](#初始化)后，执行 `nvim` 启动。

### 开箱即用

```sh
# 在主机上缓存 nvim 数据
docker volume create nvim-data
# 建议把这行 alias 加到 ~/.bashrc
alias nvim='docker run --rm -it --platform linux/amd64 -v "nvim-data:/root/.local/share/nvim" -v "$PWD:/workspace" adoyle/neovim:v0.8.0'
```

[初始化](#初始化)后，执行 `nvim` 启动。

### 直接 git clone

```sh
# 设置你的 nvim 配置目录
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
git clone --depth 1 https://github.com/adoyle-h/neovim-config.git "$NVIM_HOME"
```
[初始化](#初始化)后，执行 `nvim` 启动。

### 初始化

- `nvim --headless -c PlugInstall -c qa`，或者进入 nvim 执行 `:PlugInstall`，安装 vim 插件。
  - 插件默认安装在 `~/.local/share/nvim/plugins`。你可以修改插件目录。查看[默认配置][default-config]里的 `pluginDir` 选项。
  - 下载插件可能会比较慢，请耐心等待。如果你在中国大陆，可以使用镜像代理加速，详见[用户配置](#用户配置)里的 `config.proxy.github`。
- `nvim --headless -c 'TSInstall all' -c qa`，或者进入 nvim 执行 `:TSInstall all`。默认未安装 Treesitter Parser。执行此命令，一键安装所有。
- `nvim --headless -c 'MasonToolsInstall' -c qa`，或者进入 nvim 执行 `:MasonToolsInstall`，安装 LSP。

## 配置

### 用户配置

你可以传入自定义配置来覆盖默认配置。

```lua
require('adoyle-neovim-config').setup {
  config = {
    colors = { -- basic colors
      white = '#BEC0C4', -- frontground
      black = '#15181D', -- background
      cursorLine = '#252931',
    },

    ['mason-installer'] = {
      ensureInstalled = {
        'lua-language-server',
        'luaformatter',
        'bash-language-server',
      }
    }
  },

  -- Add your plugins or override plugin default options.
  -- More examples in ./lua/adoyle-neovim-config/plugins.lua
  plugins = {
    -- { 'profiling', disable = false },
    -- { 'psliwka/vim-smoothie', disable = false },
  },
}
```

当 `plugins` 里的插件名与已有的插件匹配时，你定义的配置项会覆盖插件的默认配置。当没有匹配的已有插件，会作为新的插件加载。

已有的插件见 [./lua/adoyle-neovim-config/plugins.lua](./lua/adoyle-neovim-config/plugins.lua)

你可参考 [./init.lua](./init.lua) 来编写你的配置。

### 默认配置

部分默认配置写在 [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua)，部分写在插件的 `defaultConfig` 里。

部分默认颜色配置写在 [./lua/adoyle-neovim-config/config/color.lua](./lua/adoyle-neovim-config/config/color.lua) 与 [./lua/adoyle-neovim-config/themes/onedarkpro.lua](./lua/adoyle-neovim-config/themes/onedarkpro.lua)，另一部分写在插件的 `highlights` 参数里。

### configFn(config)

有些插件配置需要用到对应的模块。例如 `null-ls` 的 `sources` 配置项。你必须定义在 `configFn(config)` 函数。
函数的返回值必须是一个 table，它会被合并到 `config` 变量。

```lua
require('adoyle-neovim-config').setup {
  configFn = function(config)
    local builtins = require('null-ls').builtins
    local codeActions = builtins.code_actions
    local diagnostics = builtins.diagnostics
    local formatting = builtins.formatting

    -- Do not return config, only return the overrided parts
    return {
      nullLS = {
        sources = {
          codeActions.eslint_d,
          codeActions.shellcheck,
          diagnostics.eslint_d,
          formatting.eslint_d.with {
            prefer_local = 'node_modules/.bin',
          },
          formatting.lua_format,
        },
      },
    }
  end,
}
```

### 覆盖插件参数

通过 `require('adoyle-neovim-config').setup {plugins = {}}`，你可以覆盖任何[插件参数](./doc/plugin.zh.md#插件参数)。你可以覆盖配色和快捷键设置。

### 查看配置

你可以通过编写 lua 脚本访问 `require('adoyle-neovim-config.config').config` 或 `a.CM.config` 获取配置信息.

同时，这里提供了两个命令来查看配置：
`:ShowConfig` 查看最终合并的配置。
`:ShowPlugins` 查看加载的和未加载的插件。

因为使用了 [inspect.lua](https://github.com/kikito/inspect.lua) 打印配置，
会有例如 `<table id>` 这样的标记。这是为了避免重复，对于 `<table 28>` 搜索文件内对应的 `--[[<table 28>--]]` 即可找到相应的值。
`<table id>`, `<function id>`, `<metatable>` 等标记的解释详见 [inspect.lua](https://github.com/kikito/inspect.lua#examples-of-use)。
### [颜色和高亮](./doc/colors.md)

### 代理

```lua
require('adoyle-neovim-config').setup {
  config = {
    proxy = {
      -- 如果你在中国大陆，推荐使用 'https://ghproxy.com/' (注意别遗漏末尾的 '/').
      -- 否则，不要设置该配置项。
      github = 'https://ghproxy.com/',
    },
  },
}
```

有些插件使用了 git submodule，代理无法起作用。建议你执行 `git config --global http.https://github.com.proxy https://ghproxy.com` 设置全局代理。

## 注意

`$VIMRUNTIME/filetype.vim` 不会被调用，文件类型设置请见 [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua)。

## 使用

### 快捷键

[./doc/keymaps.md](./doc/keymaps.md) 文档记录了常用的快捷键。

在 nvim 按下 `<space>k` 查询所有快捷键。

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

## [插件](./doc/plugin.zh.md)

## API

直接看[代码](./lua/adoyle-neovim-config/init.lua)。

## 项目文件结构

```
.
├── README.md
├── autoload/
│   └── plug.vim             // vim-plug source code
├── init.lua                 // Neovim configuration entry point (user config put here)
├── lsp-settings             // Global LSP settings
├── lua
│   └── adoyle-neovim-config
│       ├── config/          // Keymaps
│       │   ├── color.lua    // Default color config
│       │   └── default.lua  // Default config
│       ├── config.lua       // Config loader
│       ├── filetype.lua     // FileType autocmd
│       ├── fix-lua.lua
│       ├── framework.lua    // The framework singleton
│       ├── init.lua         // The lua required entry point (plugin way)
│       ├── plugins.lua      // Plugin loading list
│       ├── util.lua         // Utility functions
│       ├── util_spec.lua    // Unit test for util.lua
│       ├── vim-plug/        // Plugin framework based on vim-plug
│       ├── keymap/          // Keymaps
│       ├── plugins/         // Available plugins written in lua
│       ├── telescope/       // Utilities for telescope
│       └── themes/          // Color schemas
└── snippets/                // Code Snippets
```

## 启动时间

```lua
require('adoyle-neovim-config').setup {
  plugins = {
    { 'profiling', disable = false }, -- 该插件默认禁用
  }
}
```

启动 [profiling](./lua/plugins/profiling.lua) 插件，nvim 启动后调用 `:StartupTime`。将会输出启动阶段的用时。

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
[NVIM v0.8]: https://github.com/neovim/neovim/releases/tag/v0.8.0
