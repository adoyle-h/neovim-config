# Colors and Highlights

You can change colors via `config.colors`

Default color configs is defined in [./lua/adoyle-neovim-config/config/colors.lua](./lua/adoyle-neovim-config/config/colors.lua).

The background, frontground, cursorline colors, please change the config of theme plugin (defaults to ['onedarkpro'](./lua/adoyle-neovim-config/themes/onedarkpro.lua)).

```lua
require('adoyle-neovim-config').setup {
  config = {
    colors = { -- to change basic colors
      white = '#BEC0C4',
      black = '#101012',
      grey1 = '#18191B',
      grey2 = '#242629',
      grey3 = '#34373B',
      grey = '#6C6F7F',
      green = '#75C44E',
      orange = '#D75F00',
      blue = '#689AFD',
      cyan = '#ACCBE1',
      purple = '#765ADA',
      yellow = '#C3B11A',
      red = '#BF3100',
      lightYellow = '#FFFFED',
      lightGreen = '#C4D697',
      lightGrey = '#818387',
    },

    theme = {
      -- see lua/adoyle-neovim-config/plugins/themes/onedarkpro.lua
      onedarkpro = {
        colors = {
          cursorline = 'green',
        }
      }
    }
  },
}
```

## Theme
### Theme: onedarkpro

```lua
require('adoyle-neovim-config').setup {
  config = {
		theme = {
      use = 'onedarkpro',
      -- The onedarkpro plugin provides four themes.
      onedarkpro = {
        theme = 'onedark', -- 'onelight', 'onedark_vivid', 'onedark_dark'
        -- Options see https://github.com/olimorris/onedarkpro.nvim#wrench-configuration
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
