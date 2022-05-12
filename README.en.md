# ADoyle-Style Neovim Configuration

Share for learning and reference.

## TOC

<!-- MarkdownTOC GFM -->

- [Features](#features)
- [Screenshots](#screenshots)
    - [Dashboard](#dashboard)
    - [Finder](#finder)
    - [UI](#ui)
    - [Outline](#outline)
    - [Diagnostic Window](#diagnostic-window)
    - [Completion](#completion)
    - [Snippet](#snippet)
- [Dependency](#dependency)
- [Installation](#installation)
    - [LSP](#lsp)
- [Files Structure](#files-structure)
- [NOTE](#note)
- [Startup Time](#startup-time)
- [Suggestion, Bug Reporting, Contributing](#suggestion-bug-reporting-contributing)
- [Copyright and License](#copyright-and-license)

<!-- /MarkdownTOC -->

## Features

- All in Lua
- Support Neovim Native LSP
- Plugin manage framework based on [vim-plug][] and Lua. Support on-demand loading plugin.
- 100+ Vim plugins。
- Awesome UI and color schema. Dark Mode. True Color. Show Scrollbar.
- Configurable. See [./lua/config.lua](./lua/config.lua)
- Set proxy for fasting git download in China
  - If you don't need it, set `vim.config.proxy.github = false` in config file.

## Screenshots

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
```

Invoke `nvim` to get started. It is slow started at first time because it installs plugin manager and plugins automatically. Please be patient.

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
├── lua
│   ├── basic.lua      // Basic Settings. Some options may be overrided by plugin
│   ├── config.lua     // Project config
│   ├── fix-lua.lua
│   ├── plugins.lua    // required plugins
│   ├── keymap/
│   ├── plugins/       // Available plugins written in lua
│   └── themes/        // color schemas
├── plugged/           // plugins installed by vim-plug
├── spell/             // Store spell check data
└── temp/              // temporary files
    ├── session        // xolox/vim-session plugin
    ├── session_lock   // xolox/vim-session plugin
    └── undodir        // mbbill/undotree plugin
```

## NOTE

`$VIMRUNTIME/filetype.vim` will not run, please put filetype detection in [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua).

## Startup Time

Enable [plugins/profiling](./lua/plugins/profiling.lua) and invoke `:StartupTime`.

```
startup: 278.8
event                  time percent plot
init.lua             139.55   50.06 ██████████████████████████
opening buffers       32.68   11.72 ██████▏
loading rtp plugins   30.12   10.80 █████▋
NERD_tree.vim         13.66    4.90 ██▌
VimEnter autocommand   5.81    2.08 █▏
first screen update    5.73    2.05 █▏
syntax.vim             4.57    1.64 ▉
```

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
