-- Open netrw Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
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
vim.keymap.set({ "n", "v" }, "<leader>y", [["*y]])
-- Yank line to system clipboard
vim.keymap.set("n", "<leader>Y", [["*Y]])

-- Shortcut search & replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<C-n>", "<cmd>bp<CR>")
vim.keymap.set("n", "<C-m>", "<cmd>bn<CR>")
vim.keymap.set("n", "<C-x>", "<cmd>bd<CR>")

-- this is so frustrating....
vim.keymap.set("n", "<CR>", "<Down>")

-- Prevent issues....
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "]q", "<cmd>cn<CR>")
vim.keymap.set("n", "[q", "<cmd>cp<CR>")
vim.keymap.set("n", "<leader>Q", "<cmd>.cc<CR>")
vim.keymap.set("n", "<leader>cqq", "<cmd>call setqflist([])<CR>")
