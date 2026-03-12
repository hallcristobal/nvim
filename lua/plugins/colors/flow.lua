return {
  "0xstepit/flow.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    theme = {
      style = "dark", --  "dark" | "light"
      contrast = "default", -- "default" | "high"
      transparent = true, -- true | false
    },
    colors = {
      mode = "default", -- "default" | "dark" | "light"
      fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
      custom = {
        saturation = "", -- "" | string representing an integer between 0 and 100
        light = "", -- "" | string representing an integer between 0 and 100
      },
    },
    ui = {
      -- borders = "theme", -- "theme" | "inverse" | "fluo" | "none"
      aggressive_spell = true, -- true | false
    },
  },
  config = function (_, opts)
    require("flow").setup(opts)
    vim.cmd("colorscheme flow")
  end,
}
