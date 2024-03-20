# superspoon.nvim
superspoon.nvim - a minimal and fast statusline

## Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    'qtkittyy/superspoon.nvim',
}
```
### [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use { 'qtkittyy/superspoon.nvim' }
```
### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'qtkittyy/superspoon.nvim'
```

### Configuration
Superspoon comes with the following defaults:
```lua
require("superspoon").setup({
	mode = true,
	file_info = true,
	filetype = false,
	diagnostics = true,
	line_info = true,
})
```

The can similarly be achieved through a `.vim` file by wrapping it in lua heredoc like this:
```vim
lua << EOF
require("superspoon").setup()
EOF
```

For more information, check out [`:help lua-heredoc`](https://neovim.io/doc/user/lua.html#%3Alua-heredoc).

**Note:** Superspoon can alternativly be loaded via [lazy.nvim](https://github.com/folke/lazy.nvim) like this:
```lua
{
    'qtkittyy/superspoon.nvim',
    opts = {},
}
```
