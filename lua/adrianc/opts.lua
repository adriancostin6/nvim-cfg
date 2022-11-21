local opt = vim.opt

opt.listchars = { tab = '▷▷', trail = '·', extends = '◣', precedes = '◢', nbsp = '○', eol = '↵' }
opt.list = true

opt.termguicolors=true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.nu = true
opt.rnu = true

opt.hidden = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile =  true
opt.wrap = false

opt.undodir = vim.fn.stdpath('config') .. '/undo'

opt.cursorline = true
vim.wo.colorcolumn = '80'

opt.clipboard = 'unnamedplus'
