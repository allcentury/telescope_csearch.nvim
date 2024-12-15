## telescope_csearch

This [Telescope](https://github.com/nvim-telescope/telescope.nvim) plugin uses [codesearch](https://github.com/google/codesearch/tree/master) to search code in your project.

### Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'allcentury/telescope-csearch',
  requires = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope_csearch').setup({
      index_path = '~/.csearchindex'
    })
  end
}
```

Using [lazy](https://github.com/folke/lazy.nvim):

```lua
return {
  'allcentury/telescope-csearch',
  requires = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope_csearch').setup({
      index_path = '~/.csearchindex'
    })
  end,
  cond = function()
    return vim.fn.executable('csearch')
  end
}
```

## Usage

```lua
-- search by pressing <leader>cs
vim.keymap.set('n', '<leader>cs', function()
  require('telescope_csearch').csearch()
end, { desc = 'CSearch grep' })

-- search for word under cursor
vim.keymap.set('n', '<leader>csw', function()
  require('telescope_csearch').csearch({
    default_text = vim.fn.expand('<cword>')
  })
end, { desc = 'CSearch word under cursor' })
```

## License

MIT
