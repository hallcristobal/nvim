return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },
  'alvan/vim-closetag',
  {
    'github/copilot.vim',
    enabled = false,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    config = function()
      require('kanagawa').setup({
        -- hello
        commentStyle = { italic = true },
        colors = {
          theme = {
            all = { ui = { bg_gutter = "none" } }
          }
        },
        theme = "lotus",
      })
      -- vim.cmd("colorscheme kanagawa")
    end
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("flow").setup {
        dark_theme = true,        -- Set the theme with dark background.
        high_contrast = false,    -- Make the dark background darker or the light background lighter.
        transparent = false,      -- Set transparent background.
        fluo_color = "pink",      -- Color used as fluo. Available values are pink, yellow, orange, or green.
        mode = "base",            -- Mode of the colors. Available values are: dark, bright, desaturate, or base.
        aggressive_spell = false, -- Use colors for spell check.
      }

      vim.cmd("colorscheme flow")
    end,
  }
}
