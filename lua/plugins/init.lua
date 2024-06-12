return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    config = function()
      vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
      vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
      vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
      vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
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
  }
}
