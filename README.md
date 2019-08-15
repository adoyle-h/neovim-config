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

- Vim 包管理器: https://github.com/junegunn/vim-plug

## 安装

```sh
git clone https://github.com/adoyle-h/neovim-config.git
cd neovim-config
./install

# export `NVIM_HOME` in your `.bashrc` file.
echo 'export NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim' >> ~/.bashrc
```

执行 `nvim` 打开 neovim 然后执行 `:PlugInstall` 安装 vim 插件.

## 目录结构

```
.
├── README.md
├── UltiSnips/         // snippets
│   └── all.snippets   // snippets for all files
├── abbreviations.vim
├── autocmds.vim
├── autoload/          // vim-plug
├── color.vim          // color setting
├── colors/            // color themes
├── filetype.vim
├── functions.vim      // commands and functions
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
