return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "typescript",
        "javascript",
        "rust",
        "cpp",
        "html",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "prisma",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- autotag = {
      --   enable = true,
      --   virtual_text = {
      --     spacing = 5,
      --     severity_limit = "Warning",
      --   },
      --   update_in_insert = true,
      -- },
    })
  end
}
