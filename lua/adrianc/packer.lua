-- +---------+---------------------------------------------------------------
-- | Helpers |
-- +---------+
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


-- +----------+--------------------------------------------------------------
-- | Autocmds |
-- +----------+
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup end
]])


-- +---------+-----------------------------------------------------------------
-- | Plugins |
-- +---------+
return require'packer'.startup({function()
  use 'wbthomason/packer.nvim'

  -- +-----------+-------------------------------------------------------------
  -- | Telescope |
  -- +-----------+
  use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
      cmd = 'Telescope',
      requires = {
          {'nvim-lua/plenary.nvim', opt = true},
          {'kyazdani42/nvim-web-devicons', opt = true,},
          {'natecraddock/telescope-zf-native.nvim', opt = true},
          {'nvim-telescope/telescope-file-browser.nvim', opt = true},
          {'nvim-telescope/telescope-project.nvim', opt = true},
          {
            'nvim-telescope/telescope-frecency.nvim',
            opt = true,
            requires = {'kkharji/sqlite.lua'},
          },
      },
      wants = {
          'plenary.nvim',
          'nvim-web-devicons',
          'telescope-zf-native.nvim',
          'telescope-file-browser.nvim',
          'telescope-project.nvim',
          'telescope-frecency.nvim',
      },
      setup = [[require'adrianc.plugins.telescope.maps']],
      config = [[require'adrianc.plugins.telescope.config']]
  }

  -- +------------+------------------------------------------------------------
  -- | Treesitter |
  -- +------------+
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = 'BufRead',
      config = [[require'adrianc.plugins._treesitter']]
  }

  -- +----+--------------------------------------------------------------------
  -- | UI |
  -- +----+
  use {
    -- Colors
    {
      'folke/tokyonight.nvim',
      as = 'tokyo',
      event = 'ColorSchemePre',
      setup = [[require'adrianc.plugins.ui.colors._tokyo']],
    },
    {
      'catppuccin/nvim',
      as = 'catppuccin',
      event = 'ColorSchemePre',
      setup = [[require'adrianc.plugins.ui.colors._capucin']],
    },
    -- Bar
    {
      'nvim-lualine/lualine.nvim',
      as = 'lualine',
      -- Loads lualine after the colorscheme.
      event = 'ColorScheme',
      requires = {
        {'kyazdani42/nvim-web-devicons', opt = true,},
      },
      -- Starts lualine.
      config = [[require'adrianc.plugins.ui.bar._lualine']],
    },
  }

  if packer_bootstrap then
    require'packer'.sync()
  end
end,
config = {
display = {
  open_fn = function()
    return require('packer.util').float({ border = 'single' })
  end
}
}})
