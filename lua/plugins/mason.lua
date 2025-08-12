local dart_config = require("plugins.lsp_configs.dart").dart_config
local ts_ls_setup = require("plugins.lsp_configs.ts_ls").setup
local on_attach = require("plugins.lsp_configs.attach").on_attach

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
  ["eslint"] = function()
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
  end,
  ["cssls"] = function()
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
  ["clangd"] = function()
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
  end,
  ["pylsp"] = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    require 'lspconfig'.pylsp.setup {
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
    }
  end,
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
