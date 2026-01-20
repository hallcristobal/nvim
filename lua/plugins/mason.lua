-- local dart_config = require("plugins.lsp_configs.dart").dart_config
local on_attach = require("plugins.lsp_configs.attach").on_attach
local rust_settings = require("plugins.lsp_configs.rust_analyzer").settings

local function setup_handlers ()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local base_on_attach = vim.lsp.config.eslint.on_attach
  vim.lsp.config("eslint", {
    on_attach = function (client, bufnr)
      if not base_on_attach then
        return
      end

      base_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "LspEslintFixAll",
      })
    end,
  })

  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        hint = {
          enable = true,
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            [vim.fn.stdpath("config")] = true,
            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  })

  vim.lsp.config("cssls", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  vim.lsp.config("ts_ls", {
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true, -- boolean;
          includeInlayFunctionLikeReturnTypeHints = true, -- boolean;
          includeInlayFunctionParameterTypeHints = true, -- boolean;
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- boolean;
          includeInlayPropertyDeclarationTypeHints = true, -- boolean;
          includeInlayVariableTypeHints = true, -- boolean;
          includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- boolean;
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true, -- boolean;
          includeInlayFunctionLikeReturnTypeHints = true, -- boolean;
          includeInlayFunctionParameterTypeHints = true, -- boolean;
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- boolean;
          includeInlayPropertyDeclarationTypeHints = true, -- boolean;
          includeInlayVariableTypeHints = true, -- boolean;
          includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- boolean;
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
    },
    on_attach = on_attach,
  })

  vim.lsp.config("pylsp", {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = { "E501", "E231", "E302" },
            maxLineLength = 100,
          },
        },
      },
    },
    capabilities = capabilities,
    on_attach = on_attach,
  })

  vim.lsp.config("terraform_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- vim.lsp.config("rust_analyzer", {
  --   settings = {
  --     ["rust-analyzer"] = rust_settings,
  --   },
  --   capabilities = capabilities,
  --   on_attach = on_attach,
  -- })
  vim.lsp.config("ansiblels", {
    capabilities = capabilities,
    on_attach = on_attach,
  })
  -- vim.lsp.config("dartls", dart_config(on_attach))
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          vim.fn.stdpath("config") .. "/lua",
          "lazy.nvim",
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
        enabled = function (_root_dir)
          return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
        end,
      },
    },
  },
  config = function ()
    require("mason").setup({
      ensure_installed = {
        -- Lua
        "lua-language-server",
        -- Rust
        -- "rust-analyzer",
        "codelldb",
        -- C, CXX
        "clangd",
        "clang-format",
        -- JS, TS
        "typescript-language-server",
        "prettierd",
      },
    })
    require("mason-lspconfig").setup()
    setup_handlers()
  end,
}
