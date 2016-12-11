# ADoyle-Style Neovim Configuration

学习交流用，仅供参考。

Share for learning and reference.

## 版本 (Version)

```
NVIM v0.2.0-97-gacbce46
Build type: RelWithDebInfo

Optional features included (+) or not (-): +acl   +iconv    +jemalloc +tui
```

## 依赖 (Dependencies)

1. Set environment variable in shell

    `export NVIM_HOME=~/.config/nvim`

2. Download my color theme

    `git clone --single-branch --depth 1 -b adoyle https://github.com/adoyle-h/vim-colors-solarized`

    `ln -s <vim-colors-solarized>/colors/solarized.vim colors/solarized.vim`

3. Install vim plug manager (vim-plug)

    https://github.com/junegunn/vim-plug


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
