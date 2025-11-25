-- local dart_config = require("plugins.lsp_configs.dart").dart_config
local on_attach = require("plugins.lsp_configs.attach").on_attach
local rust_settings = require("plugins.lsp_configs.rust_analyzer").settings

local function setup_handlers()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  local base_on_attach = vim.lsp.config.eslint.on_attach
  vim.lsp.config("eslint", {
    on_attach = function(client, bufnr)
      if not base_on_attach then return end

      base_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "LspEslintFixAll",
      })
    end,
  })

  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  vim.lsp.config("cssls", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  vim.lsp.config("ts_ls", {
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

  vim.lsp.config("clangd", {
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

  vim.lsp.config("pylsp", {
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

  vim.lsp.config("terraform_ls", {
    capabilities = capabilities,
    on_attach = on_attach
  })

  vim.lsp.config("gopls", {
    capabilities = capabilities,
    on_attach = on_attach
  })

  vim.lsp.config("rust_analyzer", {
    settings = {
      ['rust-analyzer'] = rust_settings,
    },
    capabilities = capabilities,
    on_attach = on_attach
  })
  -- vim.lsp.config("dartls", dart_config(on_attach))
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
  },
  config = function()
    require("mason").setup({
      ensure_installed = {
        "js-debug-adapter",
        "typescript-language-server"
      }
    })
    require("mason-lspconfig").setup()
    setup_handlers()
  end
}
