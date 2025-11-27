local config = function ()
  local cmp = require("cmp")
  local cmp_select = { behavior = cmp.SelectBehavior.Select }

  cmp.setup({
    sources = {
      { name = "path" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip", keyword_length = 2 },
      { name = "buffer", keyword_length = 3 },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
      ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      ["<C-c>"] = cmp.mapping.complete(),
    }),
  })

  -- Providers
  local luasnip = require("luasnip")
  vim.keymap.set({ "i" }, "<C-K>", function ()
    luasnip.expand()
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-L>", function ()
    luasnip.jump(1)
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-H>", function ()
    luasnip.jump(-1)
  end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-E>", function ()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end, { silent = true })

  require("luasnip.loaders.from_vscode").lazy_load()
  require("lsp_signature").setup({})
  require("nvim-ts-autotag").setup({
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
  })
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      lazy = true,
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
    },
    "windwp/nvim-ts-autotag",
  },
  config = config,
}
