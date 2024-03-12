# superspoon.nvim
superspoon.nvim - a fast and extensible statusline

## Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    'qtkittyy/superspoon.nvim',
    opts = {},
}
```
### [packer](https://github.com/wbthomason/packer.nvim)
```lua
use {
    'qtkittyy/superspoon.nvim',
}

...

require("superspoon").setup()
```
### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
call plug#begin()

...

Plug 'qtkittyy/superspoon.nvim'

...

call plug#end()

...

lua require("superspoon").setup()
```
