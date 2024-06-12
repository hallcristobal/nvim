local config = function()
  local lsp_zero = require('lsp-zero')

  lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "<leader>gd", function()
      require("telescope.builtin").lsp_definitions()
    end, opts)
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
    vim.keymap.set("n", "<leader>vrr", function()
      require("telescope.builtin").lsp_references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- apparently is needed to have persistent signajure_help

    if client.server_capabilities.document_highlight then
      vim.api.nvim_exec(
        [[
      hi LspReferenceRead  gui=none  guibg=#393649
      hi LspReferenceText  [gui=none  guibg=#393649
      hi LspReferenceWrite gui=none  guibg=#393649
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
        false
      )
    end
    lsp_zero.default_keymaps(opts)
  end)

  require('mason').setup({})
  require('mason-lspconfig').setup({
    handlers = {
      lsp_zero.default_setup,
      lua_ls = function()
        local lua_opts = lsp_zero.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
      end
    }
  })

  require("luasnip.loaders.from_vscode").lazy_load()
  require("lsp_signature").setup({})
end

return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    {
      'L3MON4D3/LuaSnip',
      version = "v2.*",
      build = "make install_jsregexp"
    },
    {
      'ray-x/lsp_signature.nvim',
      event = "VeryLazy",
    }
  },
  config = config
}
