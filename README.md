# ADoyle-Style Neovim Configuration

学习交流用，仅供参考。

Click [./README.en.md](./README.en.md) to read English documents.

## TOC

<!-- MarkdownTOC GFM -->

- [特性](#特性)
- [截图](#截图)
- [依赖](#依赖)
- [安装](#安装)
    - [LSP](#lsp)
- [目录结构](#目录结构)
- [注意](#注意)
- [建议，Bug，做贡献](#建议bug做贡献)
- [版权声明](#版权声明)

<!-- /MarkdownTOC -->

## 特性

- 支持 `.lua` 与 `.vim` 文件配置
- 使用 Neovim Native LSP
- 基于 [vim-plug][] 和 Lua 的插件管理
- 100+ Vim 插件
- 帅气的界面和配色。使用真彩色。显示滚动条。
- 配置了 github 的中国区代理镜像，加快插件下载速度
  - 如果需要禁用，[./config.lua](./config.lua) 里设置 `vim.config.proxy.github = false`

## 截图

## 依赖

- NVIM v0.7 及以上版本
- python3、pip3
- nvim python provider
  - `pip3 install --upgrade --user pynvim`
  - `pip2 install --upgrade --user pynvim` (这是可选的)
- [Nerd Font 字体][Nerd Font]。推荐 [DejaVuSansMonoForPowerline Nerd Font][font]。然后修改你的终端的字体设置。

## 安装

```sh
# 设置你的 nvim 配置目录
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
git clone --depth 1 https://github.com/adoyle-h/neovim-config.git "$NVIM_HOME"

# 执行 `nvim` 开始。
# 初次执行 `nvim` 会自动安装插件管理器和插件，会比较慢，请耐心等待。
nvim
```

### LSP

默认为安装任何 LSP，执行 `:LspInstallInfo` 安装你需要的 LSP。

## 目录结构

```
.
├── README.md
├── autoload/
│   └── plug.vim       // vim-plug
├── basic.vim          // neovim/vim basic settings
├── functions.vim      // commands and functions
├── init.vim           // <= neovim configuration entry point
├── keys.vim           // keyboard maps
├── lua/
│   └── plugins/       // Available plugins written in lua
├── plugged/           // plugins (installed by vim-plug)
├── plugins.lua        // required plugins
├── spell/             // spell check
└── temp/              // temporary files
    ├── session        // xolox/vim-session plugin
    ├── session_lock   // xolox/vim-session plugin
    └── undodir        // mbbill/undotree plugin
```

## 注意

`$VIMRUNTIME/filetype.vim` 不会被调用，文件类型设置请见 [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua)。

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
