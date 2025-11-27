return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function ()
    vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
    vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
    vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
    vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")

    -- vim.keymap.del("t", "<C-h>")
    -- vim.keymap.del("t", "<C-l>")
    -- vim.keymap.del("t", "<C-j>")
    -- vim.keymap.del("t", "<C-k>")
  end,
}
