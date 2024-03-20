# superspoon.nvim
superspoon.nvim - a minimal and fast statusline

## Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
  'qtkittyy/superspoon.nvim',
  opts = {
    -- Place your configuration below
  }
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
return require('packer').startup(function(use)
  use 'qtkittyy/superspoon.nvim'
end)

require("superspoon").setup({
  -- Place your configuration below
})
```

### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
call plug#begin()
  Plug 'qtkittyy/superspoon.nvim'
call plug#end()

lua << EOF
require("superspoon").setup({
  -- Place your configuration below
})
EOF
```

### Configuration
Superspoon comes with the following defaults:
```lua
{
  mode = true,
  file_info = true,
  filetype = false,
  diagnostics = true,
  line_info = true,
}
```

For more information, check out [`:help lua-heredoc`](https://neovim.io/doc/user/lua.html#%3Alua-heredoc).
