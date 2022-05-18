# ADoyle-Style Neovim Configuration

Neovim all-in-one configuration. It can be loaded as a plugin. It is enough flexible to customize and extend it.

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
- [API](#api)
- [Configuration](#configuration)
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
- Integrated many powerful Vim plugins。
- Awesome UI and color schema. Dark Mode. True Color. Scrollbar.
- Configurable. See [./lua/config.lua](./lua/config.lua)
- Configurable proxy for fast git download in China Mainland

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
- Linux and MacOS are supported. Windows not.

## Installation

1. You have two ways to use the project. Use the project directly, or load the project as an plugin for more customizations.

  a. Directly Use

    ```sh
    # Set your nvim config directory
    NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
    git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_HOME"
    ```

  b. Load as Plugin

    ```sh
    # Set your nvim config directory
    NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
    NVIM_DATA=${XDG_CONFIG_HOME:-$HOME/.local/share}/nvim
    mkdir -p "$NVIM_HOME"/{temp,snippets,spell}
    mkdir -p "$NVIM_DATA"/plugins
    git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_DATA"/plugins/adoyle-neovim-config

    # Create init.lua file
    cat <<EOF > "$NVIM_HOME"/init.lua
    vim.opt.rtp:prepend { vim.fn.stdpath('data') .. '/plugins/adoyle-neovim-config' }
    require('adoyle-neovim-config').setup {
      config = {
        proxy = {
          -- If you are in China Mainland, it is suggested to set 'https://ghproxy.com/' (Do not missing the last '/').
          -- Otherwise, remove this option.
          github = 'https://ghproxy.com/', -- emptry string or proxy url
        },
      },
    }
    EOF
    ```

2. Initialization
  - `:PlugInstall`. It maybe slow. Please be patient.
  - There no any Treesitter Parer installed by default. Invoke `:TSInstall all` to install them.
  - There no any LSP installed by default. Invoke `:LspInstallInfo` to choose LSPs which you need.
3. `nvim` to get started.

## API

```lua
local A = require('adoyle-neovim-config')
print(vim.inspect(A))

A.setup()
```

No more document. Just see [codes](./lua/adoyle-neovim-config/init.lua)

## Configuration

You can pass config when load as plugin.

```lua
require('adoyle-neovim-config').setup {
  config = {
    plugins = { -- Override plugin default config
      ['plugins.profiling'] = {
        disable = false, -- Set false to enable the disabled plugin by default.
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

See [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua) for details.

Plugins list in [./lua/adoyle-neovim-config/plugins.lua](./lua/adoyle-neovim-config/plugins.lua)

## Files Structure

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

All plugines installed in `~/.local/share/nvim/plugins`. You can modify the plugin directory with the `pluginDir` option in [default config][default-config]。

## NOTE

`$VIMRUNTIME/filetype.vim` will not run, please put filetype detection in [./lua/plugins/filetype.lua](./lua/plugins/filetype.lua).

## Startup Time

Enable [plugins/profiling](./lua/plugins/profiling.lua) and invoke `:StartupTime`.

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
[default-config]: ./lua/adoyle-neovim-config/config/default.lua
