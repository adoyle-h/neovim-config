# Default Keymaps

List basic keymaps for novices.
Press `<space>k` to see all keymaps in nvim.

## General

- `<space>o` = Toggle outline
- `<space>u` = Toggle undo tree
- `<space>P` = Show plugin status
- `<leader>e` = Refresh current buffer
- `<leader>w` = Save current buffer to disk
- `<M-g>` = Show absolute file path
- `<leader>l` = Toggle invisible characters
- `.` = Repeat last change. Also work in visual mode
- `<leader>ii` = Increment word under cursor
- `<leader>id` = Decrement word under cursor
- `>` = Increment indent
- `<` = Decrement indent
- `gx` = Open URL under cursor
- `<leader>so` = Toggle scrolloff
- `<leader>sp` = Toggle spell-checking

## Copy and Paste

- `<leader>y` = Copy current line into system clipboard
- `<leader>y` in visual mode = Copy selected text into system clipboard
- `Y` = Copy text from cursor to line end
- `<leader>p` = Paste from vim clipboard
- `<leader>P` = Paste from system clipboard
- `<M-p>` = Toggle paste mode
- `<space>y` = List vim registers

## Cursor Motion and Jump

- `fw` = Jump to the start of word (forward)
- `fb` = Jump to the start of word (back forward)
- `fe` = Jump to the end of word
- `fl` = Jump to line
- `fc` or `f1` = Jump to char prefixed which user type (1 char)
- `f2` = Jump to chars prefixed which user type (2 chars)
- `g[` = Jump to previous cursor position
- `g]` = Jump to next cursor position
- `<C-]>` = Jump to the definition of the keyword under the cursor. see `:h CTRL-]`
- `%` = Jump to matched pair
- `[%` = Jump to previous matched pair
- `]%` = Jump to next matched pair
- `gf` = Jump to file when cursor on filepath
- `:{number}` = Jump to line
- `th` = move to parent node (treesitter)
- `tj` = move to next node (treesitter)
- `tk` = move to previous node (treesitter)
- `tl` = move to child node (treesitter)

## Select

- `<leader>sa` = Select all texts
- see `:h text-objects`
- `vaf` = Text-objects for function (Support by treesitter)
- `va%` = Text-objects for matched pairs
- `vat` = Text-objects for XML tag node
- `vin` = Text-objects for treesitter node
- `<leader>v` = Smart select the next closest text-objects
- `<leader>V` = Reverse selection of `<leader>v`

## Swap

- `<M-h>` = Swap current symbol under cursor with previous node
- `<M-j>` = Swap current line with next line
- `<M-k>` = Swap current line with previous line
- `<M-l>` = Swap current symbol under cursor with next node
- `t` = Swap next character under cursor

## Search

- `/` = Search next
- `?` = Search previous
- `<leader>C` = Clear search
- `<C-n>` = Search word under cursor (with `<` and `>` around the word)
- `<C-p>` = Reversed search word under cursor (with `<` and `>` around the word)
- `g<C-n>` = Search word under cursor (without `<` and `>` around the word)
- `g<C-p>` = Reversed search word under cursor (without `<` and `>` around the word)
- `<space>f` = Find files
- `<space>?` = Fuzzy find content in current buffer
- `<space>/` = Fuzzy find content in workspace
- `<leader>f` = Fuzzy find content in workspace (use CtrlSF)

## Highlight

- `<leader>k` = Toggle highlight of all matched words under cursor
- `[k` = Move to previous user highlighted word
- `]k` = Move to next user highlighted word
- `<leader>K` = Clear user highlighted words
- `<leader>h` = Toggle search highlighted
- `<space>H` = Find highlight groups

## File Explorer

- `<space>m` = Reveal current buffer in file explorer. Or close file explorer.
- `<space>b` = Toggle buffers window
- `<space>g` = Toggle git files window
- `?` = Show file explorer keymaps window
- `<C-h>` = Change current work directory to upper
- `<C-l>` = Change current work directory to the folder under cursor
- `<c-r>` = Refresh
- `<cr>` or `o` = Open file in current window, or toggle folder opened/collapsed
- `q` = Close file explorer window
- `H` = Toggle hidden and git-ignored files
- `f` = Enter filter pattern
- `/` = Enter live filter patter
- `<c-x>` = Clear filter
- `C` = Close node
- `D` = Fuzzy_finder_directory
- `O` = Open file in system finder
- `P` = Toggle preview
- `R` = Refresh
- `S` = Open split
- `Z` = Expand all nodes
- `[g` = Move to previous git modified file
- `]g` = Move to next git modified file
- `A` = Add folder
- `a` = Add file or folder
- `c` = Copy
- `d` = Delete
- `f` = Filter on submit
- `m` = Move
- `p` = Paste from clipboard
- `q` = Close window
- `r` = Rename
- `s` = Open split
- `t` = Open tabnew
- `v` = Open vsplit
- `x` = Cut to clipboard
- `y` = Copy to clipboard
- `z` = Close all nodes

## Pickers and Windows

- `<space>;` = Choose Telescope pickers
- `<space>M` = Show man page
- `<space>p` = Find commands
- `<space>C` = Find command history
- `<space>h` = Find vim help
- `<space>k` = Find keymaps
- `<space>d` = Find diagnostics
- `<space>S` = Find search history
- `<space>j` = Show jumplists
- `<space>v` = Find vim options
- `<space>r` = Show recently opened files
- `<space>n` = Find notifications
- `<space>t` = List tabs
- `<space>T` = List todo comments

### Telescope Window

- `<C-j>` = Move to next selection
- `<C-k>` = Move to previous selection
- `<C-s>` = Open buffer in horizontal split window
- `<C-t>` = Open buffer in new tab
- `<C-b>` = Scroll results window page up
- `<C-f>` = Scroll results window page down
- `<C-u>` = Scroll preview window page up
- `<C-d>` = Scroll preview window page down

## Edit and Write

- `u` = Undo
- `U` = Redo
- `u` in visual selection = Characters to upper case
- `U` in visual selection = Characters to lower case
- `<space><space>` = Insert a space at right position of cursor
- `[<space>` = Insert a space at left position of cursor
- `]<space>` = Insert a space at right position of cursor
- `~` = Character to upper case or lower case
- `<M-s>` = Spell suggestion
- `<space>z` = Toggle zen mode for writing
- `J` = Join lines into one
- `K` = Split current line on cursor

## Word Case

- `crm` = MixedCase
- `crc` = camelCase
- `crs` or `cr_` = snake_case
- `cru` = SNAKE_UPPERCASE
- `cr-` = dash-case
- `crk` = kebab-case
- `cr.` = dot.case
- `cr<space>` = space case

## Insert Mode

- Emacs shortcuts like `<C-e>`, `<C-a>`, `<C-u>`, `<C-k>`, `<M-b>`, `<M-f>`...
- `<M-CR>` = Move cursor to next line

## Buffer Line

- `[b` = Select previous buffer
- `]b` = Select next buffer
- `<leader>1` = Select 1st buffer
- `<leader>2` = Select 2nd buffer
- `<leader>3` = Select 3rd buffer
- `<leader>4` = Select 4th buffer
- `<leader>9` = Select 9th buffer
- `<leader>0` = Select last buffer

## Tab

- `<C-t>n` = Open new tab
- `<C-t>x` = Close tab

## Window

- `-` = Choose window
- `<C-w>q` = Close current window
- `<C-w>|` = Open split window
- `<C-w>\` or `<C-w>n` = Open vsplit window
- `<C-w><C-w>` = Enter window resize mode
- `<C-w>h` = Focus to left window
- `<C-w>j` = Focus to bottom window
- `<C-w>k` = Focus to upper window
- `<C-w>l` = Focus to right window
- `<C-w>o` = Focus to next window
- `<C-w>O` = Focus to previous window
- `<C-w>H` = Adjust window border to left (5 spaces)
- `<C-w>J` = Increment window height (3 spaces)
- `<C-w>K` = Decrement window height (3 spaces)
- `<C-w>L` = Adjust window border to right (5 spaces)
- `<C-w><` = Adjust window border to left (1 space)
- `<C-w>>` = Adjust window border to right (1 space)
- `<C-w>+` = Increment window height (1 space)
- `<C-w>-` = Decrement window height (1 space)
- `<C-w>t` = Move current window to new tab
- `<C-w>_` = Maximize window height
- `<C-w>=` = Make all windows (almost) equally high and wide, but use 'winheight' and 'winwidth' for the current window.

## Scroll

- `G` = Scroll to top
- `gg` = Scroll to buttom
- `<C-y>` = Scroll up 10% of window
- `<C-e>` = Scroll down 10% of window
- `<C-u>` = Scroll up 50% of window
- `<C-d>` = Scroll down 50% of window
- `<C-b>` = Scroll page up
- `<C-f>` = Scroll page down
- `zt` = Scroll to window top
- `zz` = Scroll to window middle
- `zb` = Scroll to window buttom

## Terminal

- `<leader>tt` = Create new terminal
- `<leader>ts` = Send current line or selected texts to terminal

## Coding

### Comments

- `<leader>cc` or `<space>c` = Comment toggle current line
- `<leader>cb` = Comment toggle current block
- `<leader>ca` = Comment insert end of line
- `<leader>cO` = Comment insert below
- `<leader>co` = Comment insert above

### Completion

- `<M-c>` = Abort completion
-	`<CR>` = Confirm selection
-	`<C-n>` = Select next completion. And select history next in cmdline
-	`<C-p>` = Select prev completion. And select history prev in cmdline
-	`<Up>` or `<S-Tab>` or `<C-k>` = Select prev completion
-	`<Down>` or `<Tab>` or `<C-j>` = Select next completion
-	`<C-f>` = Select page down
-	`<C-b>` = Select page up
-	`<C-u>` = Scroll preview up
-	`<C-d>` = Scroll preview down

### LSP and Diagnostic

- `<space>d` = Find diagnostics
- `<M-m>` = Toggle Mason window to install or uninstall lsp/dap/linter/formatter adapters
- `[d` = Move to the previous diagnostic in the current buffer
- `]d` = Move to the next diagnostic in the current buffer
- `gD` = Jumps to the declaration of the symbol under the cursor.
- `gR` = Renames all references to the symbol under the cursor.
- `ga` = Selects a code action available at the current cursor position.
- `gh` = Displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window.
- `gs` = Displays signature information about the symbol under the cursor in a floating window.
- `gF` = Formats a buffer using the attached (and optionally filtered) language server clients. (Autoformat will be trigger when write buffer to disk)
- `gd` = Goto preview definition about the symbol under cursor
- `gt` = Goto preview type definition about the symbol under cursor
- `gi` = Show implementation about the symbol under cursor
- `gr` = Show references about the symbol under cursor

## Diff

- `<leader>df` = :diffthis
- `<leader>do` = :diffoff
- `<leader>d1` = :diffget LOCAL
- `<leader>d2` = :diffget REMOTE
- `<leader>d3` = :diffget BASE

## DAP

- `<F9>` = Continue
- `<F10>` = Step over
- `<F11>` = Step into
- `<F12>` = Step out
- `<leader>db` = Toggle breakpoint
- `<leader>dB` = Set breakpoint with condition
- `<leader>dp` = Set breakpoint with log message
- `<leader>dr` = Open REPL
- `<leader>dl` = Run last

## Git

- `<leader>G` = Open Gitsigns window

## Gutter

- `<leader>N` = Toggle relative/absolute number gutter
- `<leader>L` = Toggle linenumber gutter

## Uncategory

- `<leader>cr` = Send request in HTTP file (NTBBloodbath/rest.nvim)
