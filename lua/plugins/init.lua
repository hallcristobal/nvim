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
        injections = { enable = true },
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
  {
    "mrcjkb/rustaceanvim",
    version = '^5',
    lazy = false,
    config = function ()
      local extension_path = vim.fn.exepath("codelldb") .. "/extension/"
      local c_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require("rustaceanvim.config")
      vim.g.rustaceanvim = {
        server = {
          on_attach = require("plugins.lsp_configs.attach").on_attach,
        },
        dap = {
          adapter = cfg.get_codelldb_adapter(c_path, liblldb_path),
        },
      }
    end,
  },
}
