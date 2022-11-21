-- Telescope
vim.keymap.set('n', '<Space>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<Space>fp', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<Space>ll', ':Telescope buffers<CR>')
vim.keymap.set('n', '<Space>gf', ':Telescope git_files<CR>')

-- Telescope file browser
vim.keymap.set('n', '<Space>e', ':Telescope file_browser path=%:p:h theme=ivy<CR>', { silent = true })
if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.keymap.set('n', '<Space>v', ':Telescope file_browser path=~/AppData/Local/nvim/ theme=ivy<CR>', { silent = true })
else 
    vim.keymap.set('n', '<Space>v', ':Telescope file_browser path=~/.config/nvim/<CR> theme=ivy', { silent = true })
end

-- Telescope project view
vim.api.nvim_set_keymap(
        'n',
        '<Space>p',
        ":Telescope project theme=ivy<CR>",
        {noremap = true, silent = true}
)

-- Telescope frecency
vim.api.nvim_set_keymap("n", "<Space>h", ":Telescope frecency<CR>", {noremap = true, silent = true})
