# ADoyle-Style Neovim Configuration

Share for learning and reference.

## TOC

<!-- MarkdownTOC GFM -->

- [Version](#version)
- [Dependency](#dependency)
- [Installation](#installation)
- [Files Structure](#files-structure)
- [Suggestion, Bug Reporting, Contributing](#suggestion-bug-reporting-contributing)
- [Copyright and License](#copyright-and-license)

<!-- /MarkdownTOC -->

## Version

NVIM v0.3 and higher.

## Dependency

- Vim Plugin Manager: https://github.com/junegunn/vim-plug
- 100+ Vim plugins
- python3、pip3、python2、pip2
- nvim python provider
  - `pip2 install --upgrade --user pynvim`
  - `pip3 install --upgrade --user pynvim`
- Nerd Font. Recommend [DejaVuSansMonoForPowerline Nerd Font][font]. And change your terminal font setting.

The plugin manager and plugins will be auto-installed. Just invoke `nvim`.

## Installation

```sh
# Set your nvim config directory
NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim
git clone --depth 1 https://github.com/adoyle-h/neovim-config.git $NVIM_HOME

# Export `NVIM_HOME` in your .bashrc file.
echo "export NVIM_HOME=$NVIM_HOME" >> ~/.bashrc

# Restart terminal

# Invoke `nvim` to get started.
nvim
```

## Files Structure

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

## Suggestion, Bug Reporting, Contributing

Any comments and suggestions are always welcome. Please open an [issue][] to contact with me.

## Copyright and License

Copyright (c) 2016-2019 ADoyle. The project is licensed under the **BSD 3-clause License**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.


<!-- links -->

[issue]: https://github.com/adoyle-h/neovim-config/issues
[LICENSE]: ./LICENSE
[font]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DejaVuSansMono
