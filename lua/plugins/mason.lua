local dart_config = require("plugins.lsp_configs.dart").dart_config
local on_attach = require("plugins.lsp_configs.attach").on_attach

local function setup_handlers()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  require("lspconfig").eslint.setup({
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
      on_attach(client, bufnr)
    end,
  })

  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  require("lspconfig").cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

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

  require("lspconfig").clangd.setup({
    cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--all-scopes-completion",
      "--completion-style=detailed",
      "--compile-commands-dir=",
      "--function-arg-placeholders=0",
      "--enable-config",
    }, -- custom build dir
    on_attach = on_attach
  })

  require("lspconfig").pylsp.setup({
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { 'E501', 'E231', 'E302' },
            maxLineLength = 100
          }
        }
      }
    },
    capabilities = capabilities,
    on_attach = on_attach
  })
  -- require("lspconfig").dartls.setup(dart_config(on_attach))
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()
    setup_handlers()
  end
}
