local dart_config = require("plugins.lsp_configs.dart").dart_config

--- default on_attach
function on_attach(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
  end, opts)
  -- vim.keymap.set("n", "<leader>f", function()
  --   vim.lsp.buf.format({ bufnr = bufnr, async = true })
  -- end, opts)
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, opts)

  vim.keymap.set("n", "<leader>L", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = nil }), { bufnr = nil })
  end, opts)
end

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
    require("lspconfig").dartls.setup(dart_config(on_attach))
  end
}
