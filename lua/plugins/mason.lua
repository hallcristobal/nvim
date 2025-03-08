
local dart_config = require("plugins.lsp_configs.dart").dart_config
local on_attach = require('plugins.lsp_configs.attach').on_attach


local handlers = {
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach,
    })
  end,
  ["ts_ls"] = function()
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
      on_attach = on_attach,
    })
  end,
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({ handlers = handlers })
    -- This can't be in the handlers above, because Mason doesn't know dartls exists
    -- require("lspconfig").dartls.setup(dart_config(on_attach))
  end
}
