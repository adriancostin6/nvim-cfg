local present, masonlspconfig = pcall(require, "mason-lspconfig")

if not present then
  return
end

require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "sumneko_lua", "tsserver", "jsonls", "jdtls", "texlab", "cmake", "html", "pyright", }
})
