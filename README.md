# superspoon.nvim
superspoon.nvim - a fast and extensible statusline

## Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    'qtkittyy/superspoon.nvim',
}
```
### [packer](https://github.com/wbthomason/packer.nvim)
```lua
use { 'qtkittyy/superspoon.nvim' }
```
### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'qtkittyy/superspoon.nvim'
```

### Loading superspooon.nvim
To load superspoon in lua use the following code snippet
```lua
require("superspoon").setup()
```
The plugin can similarly be loaded in a `.vim` file by wrapping it in lua heredoc 
```vim
lua << EOF
require("superspoon").setup()
EOF
```
For more information, check out `:help lua-heredoc.`
