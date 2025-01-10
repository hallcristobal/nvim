return {
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
}
