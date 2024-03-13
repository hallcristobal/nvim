require("telescope").setup({
    defaults = {
        initial_mode = "normal"
    }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ initial_mode = "insert" }) end, {})
vim.keymap.set('n', '<C-p>', function() builtin.git_files({ initial_mode = "insert" }) end, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
