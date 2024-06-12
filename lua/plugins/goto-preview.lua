return {
  'rmagatti/goto-preview',
  config = function ()
    local gtp = require("goto-preview")
    gtp.setup()

    vim.keymap.set("n", "<leader>pd", gtp.goto_preview_definition, { noremap = true })
    vim.keymap.set("n", "<leader>pt", gtp.goto_preview_type_definition, { noremap = true })
  end
}
