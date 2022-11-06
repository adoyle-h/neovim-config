# ADoyle-Style Neovim Configuration

All-in-one neovim configuration implemented with Lua. It is high flexible to be customized and extended.

中文文档 [./README.zh.md](./README.zh.md)

## Features

- All in Lua. All configs can be overrided.
- Use many Neovim features: Native LSP, Float Window, Winbar.
- Lua-wrapped plugin manager based on [vim-plug](https://github.com/junegunn/vim-plug) or [packer](https://github.com/wbthomason/packer.nvim) at your choice. See [Plugin Manager](#plugin-manager).
- Awesome UI and color schema. Dark Mode. Support True-Color, Smooth-Scroll, Scrollbar, Dashboard. You can change colors and highlights. See [doc/colors.md](doc/colors.md).
- [Configurable](#configuration).
- Configurable proxy for fast git download in China Mainland. See [Proxy](#proxy).
- Integrated 120+ powerful Vim/Nvim plugins. Enhancing the usage experience, and fixed some shortcomings of these plugins.

  <details close>
  <summary>Click to expend/collapse</summary>

  - Plugin Manager: [vim-plug](lua/adoyle-neovim-config/plugin-manager/vim-plug.lua) (default) or [packer](lua/adoyle-neovim-config/plugin-manager/packer.lua)
  - Dashboard: [alpha.nvim](lua/adoyle-neovim-config/plugins/alpha.lua)
  - Outline: [aerial](lua/adoyle-neovim-config/plugins/aerial.lua) (default) or [majutsushi/tagbar](lua/adoyle-neovim-config/plugins/tagbar.lua)
  - File Explorer: [neo-tree](lua/adoyle-neovim-config/plugins/neo-tree.lua) (default) or [nerdtree](lua/adoyle-neovim-config/plugins/nerdtree.lua) or [nvim-tree](lua/adoyle-neovim-config/plugins/nvim-tree.lua)
  - Statusline: [lualine](lua/adoyle-neovim-config/plugins/lualine.lua) (default) or [airline](lua/adoyle-neovim-config/plugins/airline.lua)
  - Bufferline: [bufferline](lua/adoyle-neovim-config/plugins/bufferline.lua)
  - Scrollbar: [nvim-scrollbar](lua/adoyle-neovim-config/plugins/scrollbar.lua)
  - Smooth-Scroll: [neoscroll.nvim](lua/adoyle-neovim-config/plugins/scroll.lua)
  - Session: [persisted](lua/adoyle-neovim-config/plugins/session/persisted.lua) (default) or [possession](lua/adoyle-neovim-config/plugins/session/possession.lua) or [xolox/vim-session](lua/adoyle-neovim-config/plugins/session/vim-session.lua) or [rmagatti/auto-session](lua/adoyle-neovim-config/plugins/session/auto-session.lua)
  - Fuzzy Finding: [telescope](lua/adoyle-neovim-config/plugins/telescope/main.lua) and [ctrlsf](lua/adoyle-neovim-config/plugins/search/ctrlsf.lua)
  - Diagnostics Window: [trouble](lua/adoyle-neovim-config/plugins/trouble.lua)
  - Undo: [vim-mundo](lua/adoyle-neovim-config/plugins/undotree.lua)
  - Syntax Highlight: [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) and [nvim-ts-rainbow](lua/adoyle-neovim-config/plugins/treesitter/rainbow.lua) and [nvim-treesitter-pairs](lua/adoyle-neovim-config/plugins/treesitter/pairs.lua)
  - Highlight Words: [vim-interestingwords](lua/adoyle-neovim-config/plugins/highlight-words.lua)
  - Code Comment: [Comment.nvim](lua/adoyle-neovim-config/plugins/comment.lua) (default) or [nerdcommenter](lua/adoyle-neovim-config/plugins/comment_nerd.lua)
  - LSP: [nvim-lspconfig](lua/adoyle-neovim-config/plugins/lsp/main.lua) and [treesitter](lua/adoyle-neovim-config/plugins/treesitter/init.lua) and [null-ls](lua/adoyle-neovim-config/plugins/lsp/null-ls.lua) and [nlsp](lua/adoyle-neovim-config/plugins/lsp/nlsp.lua) and [goto-preview](lua/adoyle-neovim-config/plugins/lsp/preview.lua) and [lsp-toggle](https://github.com/adoyle-h/lsp-toggle.nvim)
  - DAP: [nvim-dap](lua/adoyle-neovim-config/plugins/dap/init.lua)
  - Format: [lsp-format](lua/adoyle-neovim-config/plugins/lsp/format.lua) and [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim)
  - Formatter, Linter, LSP, DAP Manager: [mason](lua/adoyle-neovim-config/plugins/lsp/mason.lua) and [mason-installer](lua/adoyle-neovim-config/plugins/lsp/mason-installer.lua)
  - Completion: [nvim-cmp](lua/adoyle-neovim-config/plugins/completion/init.lua)
  - Snippets: [nvim-snippy](lua/adoyle-neovim-config/plugins/completion/snippet.lua)
  - Markdown: [plasticboy/vim-markdown](lua/adoyle-neovim-config/plugins/markdown/main.lua) and [markdown-preview](lua/adoyle-neovim-config/plugins/markdown/preview.lua) and [headlines.nvim](lua/adoyle-neovim-config/plugins/markdown/headlines.lua) and [vim-MarkdownTOC](lua/adoyle-neovim-config/plugins/markdown/toc.lua)
  - Surrounds: [nvim-surround](lua/adoyle-neovim-config/plugins/match/surround.lua) and [nvim-autopairs](lua/adoyle-neovim-config/plugins/match/autopairs.lua) and [nvim-ts-autotag](lua/adoyle-neovim-config/plugins/match/ts-autotag.lua) and [vim-matchup](lua/adoyle-neovim-config/plugins/match/matchup.lua)
  - Git: [gitsigns](lua/adoyle-neovim-config/plugins/git/sign.lua) and [lazygit](lua/adoyle-neovim-config/plugins/git/lazygit.lua) and [diffview.nvim](https://github.com/sindrets/diffview.nvim)
  - Indent Line: [indent-blankline](lua/adoyle-neovim-config/plugins/indent-line.lua)
  - Cursor Move: [hop.nvim](lua/adoyle-neovim-config/plugins/move/jump.lua) and [accelerated-jk](lua/adoyle-neovim-config/plugins/move/accelerated.lua)
  - Window Picker: [nvim-window-picker](lua/adoyle-neovim-config/plugins/move/window-picker.lua) (default) or [yorickpeterse/nvim-window](lua/adoyle-neovim-config/plugins/move/window-selector.lua) or [vim-choosewin](lua/adoyle-neovim-config/plugins/move/choose-window.lua)
  - Window Resize: [simeji/winresizer](lua/adoyle-neovim-config/plugins/window/resize.lua) and [windows.nvim](lua/adoyle-neovim-config/plugins/window/maximize.lua)
  - Context: [aerial](lua/adoyle-neovim-config/plugins/aerial.lua) (default) or [navic](lua/adoyle-neovim-config/plugins/navic.lua) and [nvim-treesitter-context](lua/adoyle-neovim-config/plugins/treesitter/context.lua)
  - Text Align: [vim-easy-align](lua/adoyle-neovim-config/plugins/align.lua)
  - Bookmark: [vim-bookmarks](lua/adoyle-neovim-config/plugins/bookmark.lua)
  - Mark: [marks.nvim](lua/adoyle-neovim-config/plugins/mark.lua)
  - Calendar: [mattn/calendar-vim](lua/adoyle-neovim-config/plugins/calendar.lua)
  - Curl: [rest.nvim](lua/adoyle-neovim-config/plugins/curl.lua)
  - Icons: [devicons](lua/adoyle-neovim-config/plugins/devicons.lua) and [icon-picker](lua/adoyle-neovim-config/plugins/icon-picker.lua)
  - UI Enhancing: [dressing](lua/adoyle-neovim-config/plugins/dressing.lua) and [noice](lua/adoyle-neovim-config/plugins/noice.lua)
  - Start Speed Up: [impatient.nvim](https://github.com/lewis6991/impatient.nvim)
  - Escape: [better-escape.nvim](lua/adoyle-neovim-config/plugins/escape.lua)
  - Increment: [increment-activator](lua/adoyle-neovim-config/plugins/increment.lua)
  - Filetype: [filetype.nvim](lua/adoyle-neovim-config/plugins/filetype.lua)
  - Latex: [nabla](lua/adoyle-neovim-config/plugins/latex.lua)
  - Notification: [notify](lua/adoyle-neovim-config/plugins/notify.lua) (default) or [notifier](lua/adoyle-neovim-config/plugins/notifier.lua)
  - Profiling: [vim-startuptime](lua/adoyle-neovim-config/plugins/profiling.lua)
  - Text-Objects: [wildfire](lua/adoyle-neovim-config/plugins/select.lua) and [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  - Table Edit: [vim-table-mode](lua/adoyle-neovim-config/plugins/table.lua)
  - Terminal: [neoterm](lua/adoyle-neovim-config/plugins/terminal/neoterm.lua)
  - Testing: [nvim-test](lua/adoyle-neovim-config/plugins/test.lua)
  - TODO Comment: [todo-comments](lua/adoyle-neovim-config/plugins/todo.lua)
  - Trailing Spaces: [whitespace](lua/adoyle-neovim-config/plugins/trailing.lua)
  - Yank: [yanky](lua/adoyle-neovim-config/plugins/yank.lua)
  - Zen Mode: [twilight and zen-mode](lua/adoyle-neovim-config/plugins/zen.lua)
  - Notebook: [zk](lua/adoyle-neovim-config/plugins/zk.lua)
  - Live Command: [live-command](https://github.com/smjonas/live-command.nvim)
  - Color Highlighter: [nvim-colorizer](lua/adoyle-neovim-config/plugins/colors/inline.lua)
  - [Games](lua/adoyle-neovim-config/plugins/funny.lua)

  </details>

## Screenshots

<details close>
<summary>Click to expend/collapse</summary>

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

Function signature completion

![completion-function-args.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/completion-function-args.png)

### Float Cmdline

This feature is disabled by default. Because it seems not stable.
You can enable it by below codes.

```lua
require('adoyle-neovim-config').setup {
  plugins = {
    { 'noice', disable = false },
  },
}
```

![cmdline.png](https://media.githubusercontent.com/media/adoyle-h/_imgs/master/github/neovim-config/cmdline.png)

</details>

## Dependencies

- [NVIM v0.8][] or later
- python3、pip3
- nvim python provider
  - `pip3 install --upgrade --user pynvim`
  - `pip2 install --upgrade --user pynvim` (it is optional)
- Git and curl
- A C compiler in your path and libstdc++ installed. (Required by [treesitter](https://github.com/nvim-treesitter/nvim-treesitter#requirements))
- [Nerd Font][]. Recommend [DejaVuSansMonoForPowerline Nerd Font][font]. Remember to change your terminal font setting.
- [ripgrep(rg)](https://github.com/BurntSushi/ripgrep)
- Linux and MacOS are supported. Windows not.

## Installation

You have three ways to install the project.

1. Use the project as an plugin.
2. Out of the box via container.
3. Git clone the project directly.

### Use as plugin

```sh
# Set your nvim config directory
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
NVIM_DATA=${XDG_CONFIG_HOME:-$HOME/.local/share}/nvim
mkdir -p "$NVIM_DATA"/plugins
git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_DATA"/plugins/adoyle-neovim-config

# Create init.lua file
cat <<EOF > "$NVIM_HOME"/init.lua
vim.opt.rtp:prepend { vim.fn.stdpath('data') .. '/plugins/adoyle-neovim-config' }

require('adoyle-neovim-config').setup {}
EOF
```

Do [initialization](#initialization) and then press `nvim` to get started.

### Out of the box

```sh
# Cache the nvim data in host
docker volume create nvim-data
# It's recommended to add this line to ~/.bashrc
alias nvim='docker run --rm -it --platform linux/amd64 -v "nvim-data:/root/.local/share/nvim" -v "$PWD:/workspace" adoyle/neovim:v0.8.0'
```

Do [initialization](#initialization) and then press `nvim` to get started.

### Git clone directly

```sh
# Set your nvim config directory
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
git clone --depth 1 --single-branch https://github.com/adoyle-h/neovim-config.git "$NVIM_HOME"
# If you want to change configs, checkout to new branch
```

Do [initialization](#initialization) and then press `nvim` to get started.

## Initialization

- Use your current editor to edit config in file `init.lua`.
  - `config.pluginManager.use` choose your favorite plugin manager. See [Plugin Manager](#plugin-manager) for details.
  - It maybe be slow to download plugins. Modify `config.proxy.github` option to use proxy. See [Proxy](#proxy) for details.
- Open `nvim`. It will auto download dependent packages, like impatient.nvim, vim-plug or packer. And then auto download plugins.
- When plugins installed failed.
  - If `config.pluginManager.use = vim-plug`
    - Run `:PlugInstall` in nvim, to install all plugins. Repeat it util all plugins installed successfully.
    - All plugines installed in `~/.local/share/nvim/plugins`. You can modify the plugin directory with the `CM.config.pluginManager['vim-plug'].pluginDir` option.
  - If `config.pluginManager.use = packer`
    - Run `:PackerSync` in nvim, to install all plugins. Repeat it util all plugins installed successfully.
    - All plugines installed in `~/.local/share/nvim/pack/packer`. **DO NOT MODIFY** the `config.pluginManager.packer.package_root` option, unless you completely know what you are doing. If the option modified and get any error, please don't ask me anything.
- Run `:TSInstall all` in nvim, to install treesitter parsers.
- Press `<M-m>` to open Mason window. Choose to install LSP/DAP/Formatter/Linter.
<!-- - Run `:MasonToolsInstall` in nvim, to install tools defined in `config['mason-installer'].ensureInstalled`. -->

## Configuration

All config options are optional.

```lua
require('adoyle-neovim-config').setup {}
```

### User Config

You can set your config to override default configs.

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

When repo name in `plugins` matches existed plugin, your defined options will override the default options of plugin. When no matches, it will be loaded as new plugins.

Existed plugins list in [./lua/adoyle-neovim-config/plugins.lua](./lua/adoyle-neovim-config/plugins.lua)

You can refer to [./init.lua](./init.lua) to write your config.

### Default Config

Parts of default config written in [./lua/adoyle-neovim-config/config/default.lua](./lua/adoyle-neovim-config/config/default.lua), and other parts written in `defaultConfig` option of each plugin.

Parts of default highlights written in [./lua/adoyle-neovim-config/config/color.lua](./lua/adoyle-neovim-config/config/color.lua) and [./lua/adoyle-neovim-config/themes/onedarkpro.lua](./lua/adoyle-neovim-config/themes/onedarkpro.lua), and other parts written in `highlights` option of each plugin.

### configFn(config)

Some plugin configs need the module required. Such as `sources` option for `null-ls`.
It must be defined in `configFn(config)` function.
The function must return a table that will be merged into `config` variable.

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

### Override Plugin Options

You can override any [plugin options](./doc/plugin.md#plugin-options) in `require('adoyle-neovim-config').setup {plugins = {}}`. You can override highlights and keymaps.

### View Config

You can get config via `require('adoyle-neovim-config.config').config` or `a.CM.config` in lua.

Also, there are two commands to view configs.
`:ShowConfig` to view final merged config.
`:ShowPlugins` to view disabled and enabled plugins.

Because using [inspect.lua](https://github.com/kikito/inspect.lua) to print configuration,
you may see tags such as `<table id>`. It is for preventing infinite loops.
You can search `--[[<table 28>--]]` to view its value for `<table 28>` in same buffer content.

For `<table id>`, `<function id>`, `<metatable>` tag explanations, see [inspect.lua](https://github.com/kikito/inspect.lua#examples-of-use).

### Plugin Manager

Choose your favorite plugin manager. Now available: `vim-plug` (default) and `packer`.

```lua
require('adoyle-neovim-config').setup {
  config = {
    pluginManager = { use = 'packer' }, -- 'vim-plug' or 'packer'
  },
}
```

The plugins directory maneged by vim-plug is different from packer. When you modify `config.pluginManager.use`, the plugins need to be installed again. See [initialization](#initialization).

- Packer [default config](./lua/adoyle-neovim-config/config/packer.lua)
- Vim-Plug [default config](./lua/adoyle-neovim-config/config/vim-plug.lua)

### [Plugin](./doc/plugin.md)

### [Colors and Highlights](./doc/colors.md)

### Proxy

```lua
require('adoyle-neovim-config').setup {
  config = {
    proxy = {
      -- If you are in China Mainland, it is suggested to set 'https://ghproxy.com'. Otherwise, remove this option.
      github = 'https://ghproxy.com',
    },
  },
}
```

Proxy will not work for some plugins using "git submodule". It's recommended to execute `git config --global http.https://github.com.proxy https://ghproxy.com` to set global git proxy.

## Usage

### [Debug](./doc/debug.md)

Tricks for debug. Such as disable all plugins.

### Keymaps

For basic intro, see [./doc/keymaps.md](./doc/keymaps.md).

Press `<space>k` to see all keymaps in nvim.

### [Commands](./doc/commands.md)

### [Snippets](./doc/snippet.md)

### LSP

Using [nvim-lspconfig][] and [null-ls][] to manage LSP. And using [mason.nvim][] to manege lsp, dap and null-ls packages.

- Call `:Mason` or press `<Alt-m>` to view LSP installations.
- Call `:LspInfo` to show LSP for current file.
- Call `:NullLsInfo` to show LSP for current file.

### Code Format

The code formatting is based on LSP. Using `lsp-format` instead of nvim builtin `vim.lsp.buf.format` to provide more flexible configurations. See [lsp-format options](https://github.com/lukas-reineke/lsp-format.nvim#special-format-options).

You can set multi formatters to format codes at the same time. And you can also change the order of formatters by filetype.

The configs of formatter are at `lsp.format` and `nullLS.sources`.
Default to use the formatters defined in `nullLS.sources`, and then formatters defined in `lsp.format`.

### Telescope Extensions

There are many useful telescope extensions. See [./lua/adoyle-neovim-config/plugins/telescope/extensions.lua](./lua/adoyle-neovim-config/plugins/telescope/extensions.lua)

Use `<space>;` to view all telescope extensions.

## API

Just read [codes](./lua/adoyle-neovim-config/init.lua).

## Project File Structure

```
.
├── autoload/
│   └── plug.vim             // vim-plug source code
├── doc/                     // Documents
├── lsp-settings/            // Global LSP settings
├── lua/
│   └── adoyle-neovim-config/
│       ├── config/          // Keymaps
│       │   ├── color.lua    // Default color config
│       │   └── default.lua  // Default config
│       ├── config.lua       // Config loader
│       ├── consts.lua       // Constants
│       ├── filetype.lua     // FileType autocmd
│       ├── fix-lua.lua
│       ├── framework.lua    // The framework singleton
│       ├── init.lua         // The lua required entry point (plugin way)
│       ├── plugins.lua      // Plugin loading list
│       ├── util.lua         // Utility functions
│       ├── util_spec.lua    // Unit test for util.lua
│       ├── keymap/          // Keymaps
│       ├── plugins/         // Available plugins written in lua
│       │   └── themes/      // Color schemas
│       ├── plugin-manager/
│       │   ├── init.lua     // Plugin Manager
│       │   ├── vim-plug.lua // Wrapper for vim-plug
│       │   └── packer.lua   // Wrapper for packer.nvim
│       └── telescope/       // Utilities for telescope
├── snippets/                // Code Snippets
└── init.lua                 // Neovim configuration entry point (user config put here)
```

## Startup Time

```lua
require('adoyle-neovim-config').setup {
  plugins = {
    { 'profiling', disable = false }, -- This plugin is disabled in default
  }
}
```

Enable [profiling](./lua/plugins/profiling.lua) plugin, and invoke `:StartupTime` in nvim. It will print each time on startup.

## Suggestion, Bug Reporting, Contributing

Any comments and suggestions are always welcome. Please open an [issue][] to contact with me.

If you want to submit a new feature, please open an [issue][] for feature request to talk about your design.

If you want to submit a bug fix, search related issues first, and then open a Pull Requst.

And read [how to contribute](./doc/contribution.md).

## Versions

See [tags][].
The versions follows the rules of [SemVer 2.0.0](http://semver.org/).

## Copyright and License

Copyright 2016-2022 ADoyle (adoyle.h@gmail.com) All Rights Reserved. The project is licensed under the **BSD 3-clause License**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.

See the [NOTICE][] file distributed with this work for additional information regarding copyright ownership.

## Other Projects

[Other lua projects](https://github.com/adoyle-h?tab=repositories&q=&type=source&language=lua&sort=stargazers) created by me.

<!-- links -->

[LICENSE]: ./LICENSE
[NOTICE]: ./NOTICE
[tags]: https://github.com/adoyle-h/neovim-config/tags
[issue]: https://github.com/adoyle-h/neovim-config/issues
[font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DejaVuSansMono
[Nerd Font]: https://github.com/ryanoasis/nerd-fonts
[default-config]: ./lua/adoyle-neovim-config/config/default.lua
[mason.nvim]: https://github.com/williamboman/mason.nvim
[null-ls]: https://github.com/jose-elias-alvarez/null-ls.nvim
[nvim-lspconfig]: https://github.com/neovim/nvim-lspconfig
[NVIM v0.8]: https://github.com/neovim/neovim/releases/tag/v0.8.0
