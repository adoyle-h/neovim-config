# ADoyle-Style Neovim Configuration

学习交流用，仅供参考。

Click [./README.en.md](./README.en.md) to read English documents.

## TOC

<!-- MarkdownTOC GFM -->

- [版本](#版本)
- [依赖](#依赖)
- [安装](#安装)
- [目录结构](#目录结构)
- [建议，Bug，做贡献](#建议bug做贡献)
- [版权声明](#版权声明)

<!-- /MarkdownTOC -->

## 版本

NVIM v0.3 及以上版本。

## 依赖

- Vim 插件管理器: https://github.com/junegunn/vim-plug
- 100+ Vim 插件
- python3、pip3、python2、pip2
- nvim python provider
  - `pip2 install --upgrade --user pynvim`
  - `pip3 install --upgrade --user pynvim`
- Nerd Font 字体。推荐 [DejaVuSansMonoForPowerline Nerd Font][font]。然后修改你的终端的字体设置。

插件管理器和插件会自动安装，执行 `nvim` 即可。初次执行 `nvim` 会非常慢，因为在下载安装插件管理器和插件，请耐心等待。

## 安装

```sh
# 设置你的 nvim 配置目录
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
git clone --depth 1 https://github.com/adoyle-h/neovim-config.git $NVIM_HOME

# 在你的 .bashrc 文件中设置 `NVIM_HOME` 变量
echo "export NVIM_HOME=$NVIM_HOME" >> ~/.bashrc

# 重启终端

# 执行 `nvim` 开始。
nvim
```

## 目录结构

```
.
├── README.md
├── UltiSnips/         // snippets
│   └── all.snippets   // snippets for all files
├── abbreviations.vim
├── autocmds.vim
├── autoload/          // vim-plug
├── coc-settings.json  // coc.nvim configuration
├── color.vim          // color setting
├── colors/            // color themes
├── filetype.vim       // user-setting filetypes
├── functions.vim      // commands and functions
├── highlights.vim     // user-setting highlights
├── init.vim           // <= neovim configuration entry point
├── keys.vim           // keyboard maps
├── plugged/           // plugins
├── plugins-config.vim // plugin config
├── plugins.vim        // plugin list (vim-plug)
├── settings.vim       // neovim/vim settings
├── spell/             // spell check
└── temp/              // temporary files
    ├── session        // xolox/vim-session plugin
    ├── session_lock   // xolox/vim-session plugin
    └── undodir        // mbbill/undotree plugin
```

## 建议，Bug，做贡献

Any comments and suggestions are always welcome. Please open an [issue][] to contact with me.

## 版权声明

Copyright (c) 2016-2019 ADoyle. The project is licensed under the **BSD 3-clause License**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.


<!-- links -->

[issue]: https://github.com/adoyle-h/neovim-config/issues
[LICENSE]: ./LICENSE
[font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DejaVuSansMono
