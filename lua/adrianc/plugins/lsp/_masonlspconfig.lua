local present, masonlspconfig = pcall(require, "mason-lspconfig")

if not present then
  return
end

if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.g.python3_host_prog = '~/repos/software_dev/common/ext-tools/python3/python.exe'
end

require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "sumneko_lua", "tsserver", "jsonls", "jdtls", "texlab", "cmake", "html", "pyright", }
})
