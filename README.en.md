# ADoyle-Style Neovim Configuration

Share for learning and reference.

## TOC

<!-- MarkdownTOC GFM -->

- [Features](#features)
- [Screenshots](#screenshots)
    - [Dashboard](#dashboard)
    - [Finder](#finder)
    - [UI](#ui)
    - [Diagnostic Window](#diagnostic-window)
    - [Completion](#completion)
    - [Snippet](#snippet)
- [Dependency](#dependency)
- [Installation](#installation)
    - [LSP](#lsp)
- [Files Structure](#files-structure)
- [NOTE](#note)
- [Suggestion, Bug Reporting, Contributing](#suggestion-bug-reporting-contributing)
- [Copyright and License](#copyright-and-license)

<!-- /MarkdownTOC -->

## Features

- Support `.lua` and `.vim` files for configuration
- Support Neovim Native LSP
- Manage plugin based on [vim-plug][] and Lua
- 100+ Vim plugins
- Awesome UI and color schema. Dark Mode. True Color. Show Scrollbar.
- Set proxy for fasting git download in China
  - If you don't need it, set `vim.config.proxy.github = false` in [./config.lua](./config.lua)

## Screenshots

### Dashboard

![dashboard.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/dashboard.png)

### Finder

![finder.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/finder.png)

### UI

![UI.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/UI.png)

### Diagnostic Window

![diagnostic.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/diagnostic.png)

### Completion

![completion.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/completion.png)

![completion-function-args.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/completion-function-args.png)

### Snippet

![snippet.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/snippet.png)


## Dependency

- NVIM v0.7 and higher
- Vim Plugin Manager: https://github.com/junegunn/vim-plug
- python3、pip3
- nvim python provider
  - `pip3 install --upgrade --user pynvim`
  - `pip2 install --upgrade --user pynvim` (it is optional)
- [Nerd Font][]. Recommend [DejaVuSansMonoForPowerline Nerd Font][font]. And change your terminal font setting.

## Installation

```sh
# Set your nvim config directory
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
git clone --depth 1 https://github.com/adoyle-h/neovim-config.git "$NVIM_HOME"

# Invoke `nvim` to get started.
# It is slow started at first time because it installs plugin manager and plugins automatically. Please be patient.
nvim
```

### LSP

There no any LSP installed by default. Invoke `:LspInstallInfo` to choose LSPs which you need.

## Files Structure

```
.
├── README.md
├── autoload/
│   └── plug.vim       // vim-plug
├── basic.vim          // neovim/vim basic settings
├── init.vim           // <= neovim configuration entry point
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

## NOTE

`$VIMRUNTIME/filetype.vim` will not run, please put filetype detection in [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua).

## Suggestion, Bug Reporting, Contributing

Any comments and suggestions are always welcome. Please open an [issue][] to contact with me.

## Copyright and License

Copyright 2016-2022 ADoyle (adoyle.h@gmail.com) All Rights Reserved. The project is licensed under the **BSD 3-clause License**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.


<!-- links -->

[issue]: https://github.com/adoyle-h/neovim-config/issues
[LICENSE]: ./LICENSE
[font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DejaVuSansMono
[Nerd Font]: https://github.com/ryanoasis/nerd-fonts
[vim-plug]: https://github.com/junegunn/vim-plug
