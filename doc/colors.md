# Colors and Highlights

The color design:

- Subject color: blue
- Second color: green
- Search/Match color: orange

You can change the colors and highlights.

## The background, frontground, cursorline colors

Change basic colors via `config.colors`.

Default color configs is defined in [./lua/adoyle-neovim-config/config/colors.lua](./lua/adoyle-neovim-config/config/colors.lua).

```lua
require('adoyle-neovim-config').setup {
  config = {
    colors = { -- basic colors
      white = '#BEC0C4', -- frontground
      black = '#15181D', -- background
      cursorLine = '#252931',
    },
  }
}
```

## The highlights for plugins

Override plugin highlights via `plugins`.

```lua
require('adoyle-neovim-config').setup {
  plugins = {
    {
      'stevearc/aerial.nvim',
      highlights = {
        AerialLine = { bg = 'green' },
      }
    },
  },
}
```

## The syntax highlights

The syntax highlights are defined by nvim-treesitter, whose [highlights config](../lua/adoyle-neovim-config/plugins/treesitter/highlights.lua).

Use `:TSHighlightCapturesUnderCursor` to view the highlight group of word under cursor.

## Theme

Default theme is ['onedarkpro'](./lua/adoyle-neovim-config/plugins/themes/onedarkpro.lua).

### Theme: onedarkpro

```lua
require('adoyle-neovim-config').setup {
  config = {
    theme = {
      use = 'onedarkpro',
      -- The onedarkpro plugin provides four themes.
      onedarkpro = {
        theme = 'onedark', -- 'onelight', 'onedark_vivid', 'onedark_dark'

        -- You can override options
        -- Options see https://github.com/olimorris/onedarkpro.nvim#wrench-configuration
        colors = {},
        highlights = {},
        plugins = {},
        styles = {},
        options = {},
      }
    }
  },
}
```

### Theme: material

```lua
require('adoyle-neovim-config').setup {
  config = {
    theme = {
      use = 'material',
      -- The material plugin provides five themes.
      material = {
        style = 'darker', -- 'darker', 'lighter', 'oceanic', 'palenight' 'deep ocean'
        -- Options see https://github.com/marko-cerovac/material.nvim
      }
    }
  },
}
```
