return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function ()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "mbbill/undotree",
    config = function ()
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      vim.opt.undofile = true
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function ()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end,
  },
  "alvan/vim-closetag",
  { import = "plugins.colors" },
  "nvim-tree/nvim-web-devicons",
}
