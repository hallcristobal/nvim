local jdtls = require('jdtls')
local lspconfig = require('lspconfig')
local on_attach = require("plugins.lsp_configs.attach").on_attach

local capabilities = vim.lsp.protocol.make_client_capabilities()
local config = {
  cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
  root_dir = vim.fs.dirname(vim.fs.find({ 'pom.xml', 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
jdtls.start_or_attach(config)
lspconfig.jdtls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
