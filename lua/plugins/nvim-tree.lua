-- return {}
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      -- remove a default
      -- vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
      vim.keymap.del("n", "<C-k>", { buffer = bufnr })
      -- vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
      vim.keymap.del("n", "K", { buffer = bufnr })

      -- override a default
      vim.keymap.set("n", "<C-J>", api.node.navigate.sibling.first, opts("First Sibling"))
      vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
    end

    require("nvim-tree").setup({
      on_attach = my_on_attach,
      update_focused_file = {
        enable = true,
        update_cwd = true,
        update_root = true,
      },
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 60,
      },
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })

    vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeFocus<CR>")
  end,
}
