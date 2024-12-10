## telescope-csearch

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
use {
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
vim.kemap.set('n', '<leader>cs', '<cmd>lua require("telescope_csearch").search()<cr>', { desc = 'Search code' })
```

## License

MIT
