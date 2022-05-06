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

NVIM v0.7 and higher.

## Dependency

- Vim Plugin Manager: https://github.com/junegunn/vim-plug
- 100+ Vim plugins
- python3、pip3、python2、pip2
- nvim python provider
  - `pip2 install --upgrade --user pynvim`
  - `pip3 install --upgrade --user pynvim`
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

## Files Structure

```
.
├── README.md
├── UltiSnips/         // snippets
│   └── all.snippets   // snippets for all files
├── abbreviations.vim
├── autocmds.vim
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
