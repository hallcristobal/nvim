local dart_config = require("plugins.lsp_configs.dart").dart_config
local on_attach = require('plugins.lsp_configs.attach').on_attach


local handlers = {
  function(server_name)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
  ["cssls"] = function ()
    --Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    require("lspconfig").cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
  ["ts_ls"] = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    require("lspconfig").ts_ls.setup({
      settings = {
        javascript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,                      -- boolean;
            includeInlayFunctionLikeReturnTypeHints = true,               -- boolean;
            includeInlayFunctionParameterTypeHints = true,                -- boolean;
            includeInlayParameterNameHints = 'all',                       -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- boolean;
            includeInlayPropertyDeclarationTypeHints = true,              -- boolean;
            includeInlayVariableTypeHints = true,                         -- boolean;
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,      -- boolean;
          },
        },
        typescript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,                      -- boolean;
            includeInlayFunctionLikeReturnTypeHints = true,               -- boolean;
            includeInlayFunctionParameterTypeHints = true,                -- boolean;
            includeInlayParameterNameHints = 'all',                       -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- boolean;
            includeInlayPropertyDeclarationTypeHints = true,              -- boolean;
            includeInlayVariableTypeHints = true,                         -- boolean;
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,      -- boolean;
          },
        },
      },
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
  ["jdtls"] = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local config = {
      cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
      root_dir = vim.fs.dirname(vim.fs.find({ 'pom.xml', 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    }
    require('jdtls').start_or_attach(config)
    require("lspconfig").jdtls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({ handlers = handlers })
    -- This can't be in the handlers above, because Mason doesn't know dartls exists
    -- require("lspconfig").dartls.setup(dart_config(on_attach))
  end
}
