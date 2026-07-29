return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Parsers to install (replaces auto_install; list the languages you use).
      local ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }

      require("nvim-treesitter").install(ensure_installed)

      -- Open files with all folds expanded (avoid everything collapsed on load).
      vim.opt.foldlevelstart = 99

      -- Highlighting + indentation (injections are handled natively, no setup).
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          -- highlight = { enable = true }
          pcall(vim.treesitter.start)
          -- indent = { enable = true } (experimental on main)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          -- treesitter-based folding
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
      vim.opt.undofile = true
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
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
    config = function()
      local extension_path = vim.fn.exepath("codelldb") .. ""
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
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  -- }
  -- "github/copilot.vim",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    config = function()
      local copilotChat = require("CopilotChat")
      copilotChat.setup({
        model = "claude-opus-4.6",
        resources = { "selection", "buffer" },
        insert_at_end = true,
        allow_insecure = true,
        trusted_tools = true,
        mappings = {
          reset = {
            normal = "<C-x>",
            insert = "",
          },
          complete = {
            normal = "",
            insert = "<C-l>",
          }
        },
      })
      vim.keymap.set({ "n", "s", "v" }, "<leader>l", copilotChat.toggle)
    end
  }
}
