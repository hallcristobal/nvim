return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    config = function()
      require("kanagawa").setup({
        -- hello
        commentStyle = { italic = true },
        colors = {
          theme = {
            all = { ui = { bg_gutter = "none" } },
          },
        },
        theme = "lotus",
      })
    end,
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("flow").setup({
        dark_theme = true, -- Set the theme with dark background.
        high_contrast = false, -- Make the dark background darker or the light background lighter.
        transparent = false, -- Set transparent background.
        fluo_color = "pink", -- Color used as fluo. Available values are pink, yellow, orange, or green.
        mode = "base", -- Mode of the colors. Available values are: dark, bright, desaturate, or base.
        aggressive_spell = false, -- Use colors for spell check.
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
      })
    end,
  },
}
