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
return require'packer'.startup({function(use)
  use 'wbthomason/packer.nvim'

  -- +-----+-------------------------------------------------------------------
  -- | Git |
  -- +-----+
  use {
    {
      'lewis6991/gitsigns.nvim',
      config = function() require'gitsigns'.setup()end,},
    {
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      cmd = {'DiffviewOpen', 'DiffviewFileHistory'},
    },
  }

  -- +------------+------------------------------------------------------------
  -- | Completion |
  -- +------------+
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        requires = {
          {'rafamadriz/friendly-snippets', event = 'InsertEnter'},
        },
        wants = 'friendly-snippets',
        event = 'InsertEnter',
        config = [[require'adrianc.plugins.completion._luasnip']],
      },
      {'onsails/lspkind.nvim', opt = true,},
      {'kyazdani42/nvim-web-devicons', opt = true,},
      {'hrsh7th/cmp-path',          after = 'nvim-cmp'},
      {'hrsh7th/cmp-buffer',        after = 'nvim-cmp'},
      {'hrsh7th/cmp-cmdline',       after = 'nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp',      after = 'nvim-cmp',},
      {'hrsh7th/cmp-nvim-lua',      after = 'nvim-cmp',},
      {'saadparwaiz1/cmp_luasnip',  after = 'nvim-cmp',},
    },
    wants = {'LuaSnip', 'nvim-web-devicons', 'lspkind.nvim',},
    event = 'InsertEnter',
    config = [[require'adrianc.plugins.completion._cmp']],
  }

  -- +-----+-------------------------------------------------------------------
  -- | LSP |
  -- +-----+
  use {
    { 'williamboman/mason.nvim',
       config = function() require'mason'.setup() end,
    },
    { 'williamboman/mason-lspconfig.nvim',
      after = 'mason.nvim',
      config = [[require'adrianc.plugins.lsp._masonlspconfig']],
    },
    { 'neovim/nvim-lspconfig',
      after = {'mason.nvim', 'mason-lspconfig.nvim', },
      config = [[require'adrianc.plugins.lsp._lspconfig']],
    },
  }

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
