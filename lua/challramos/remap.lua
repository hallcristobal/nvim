-- Open netrw Explorer
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>")
vim.keymap.set({ "n", "v", "s" }, "<C-f>", "<cmd>NvimTreeToggle<CR>")
-- Shortcut for pasting from " register in insert mode
vim.keymap.set("i", "<C-v>", [[<C-R>"]])

-- Move line below to end of current line
vim.keymap.set("n", "J", "mzJ`z")
-- Half page down, cursor middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Half page up, cursor middle
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Next search result, cursor middle
vim.keymap.set("n", "n", "nzzzv")
-- Previous search result, cursor middle
vim.keymap.set("n", "N", "Nzzzv")

-- Paste witout yanking
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- Yank line to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Shortcut search & replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<C-n>", "<cmd>bp<CR>")
vim.keymap.set("n", "<C-m>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<C-x>", "<cmd>bd<CR>")

-- this is so frustrating....
vim.keymap.set("n", "<CR>", "<Down>")

-- Prevent issues....
vim.keymap.set("n", "Q", "<nop>")
-- Close go back to normal mode when pressing Escape in terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<leader><Esc>", "<Esc>")

vim.keymap.set("n", "]q", "<cmd>cn<CR>")
vim.keymap.set("n", "[q", "<cmd>cp<CR>")
vim.keymap.set("n", "<leader>Q", "<cmd>.cc<CR>")
vim.keymap.set("n", "<leader>cqq", "<cmd>call setqflist([])<CR>")

vim.keymap.set("n", "<leader>.", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<leader>,", "<cmd>tabprev<CR>")

-- Folding
vim.keymap.set("n", "<leader><Tab>", "za", { desc = "Toggle fold" })
vim.keymap.set("n", "<leader>o", "zR", { desc = "Open all folds" })
vim.keymap.set("n", "<leader>O", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "<return>", "<nop>")
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float()
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev()
end)
