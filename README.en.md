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

- Vim Package Manager: https://github.com/junegunn/vim-plug

## Installation

```sh
git clone https://github.com/adoyle-h/neovim-config.git
cd neovim-config
./install

# export `NVIM_HOME` in your `.bashrc` file.
echo 'export NVIM_HOME=${XDG_CONFIG_HOME:-$HOME/.config}/nvim' >> ~/.bashrc
```

And then enter `nvim` to open neovim and `:PlugInstall` to install vim plugins.

## Files Structure

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

## Suggestion, Bug Reporting, Contributing

Any comments and suggestions are always welcome. Please open an [issue][] to contact with me.

## Copyright and License

Copyright (c) 2016-2019 ADoyle. The project is licensed under the **BSD 3-clause License**.

See the [LICENSE][] file for the specific language governing permissions and limitations under the License.


<!-- links -->

[issue]: https://github.com/adoyle-h/neovim-config/issues
[LICENSE]: ./LICENSE
