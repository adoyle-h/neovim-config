# ADoyle-Style Neovim Configuration

学习交流用，仅供参考。

Share for learning and reference.

## TOC

<!-- MarkdownTOC GFM -->

- [版本 (Version)](#版本-version)
- [安装 (Installation)](#安装-installation)
- [目录结构 (Files Structure)](#目录结构-files-structure)
- [建议，Bug，做贡献 (Suggestion, Bug Reporting, Contributing)](#建议bug做贡献-suggestion-bug-reporting-contributing)
- [版权声明 (Copyright and License)](#版权声明-copyright-and-license)

<!-- /MarkdownTOC -->

## 版本 (Version)

```
NVIM v0.3.4
Build type: Release

Optional features included (+) or not (-): +acl   +iconv    +jemalloc +tui
```

## 安装 (Installation)

Invoke `./install`.

And export `NVIM_HOME` in your `.bashrc` file.

    ```sh
    echo 'export NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim' >> ~/.bashrc
    ```

Enter `neovim` and `:PlugInstall` to install vim plugins.

## 目录结构 (Files Structure)

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

## 建议，Bug，做贡献 (Suggestion, Bug Reporting, Contributing)

Any comments and suggestions are always welcome. Please open an [issue][] to contact with me.

## 版权声明 (Copyright and License)

Copyright (c) 2016-2019 ADoyle. The project is licensed under the **BSD 3-clause License**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.


<!-- links -->

[issue]: https://github.com/adoyle-h/neovim-config/issues
[LICENSE]: ./LICENSE
