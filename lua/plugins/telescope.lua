local ignores = require("plugins.telescope.ignores")
local utils = require("plugins.utils.utils")
local function ConcatArray (a, b)
  local result = { unpack(a) }
  table.move(b, 1, #b, #result + 1, result)
  return result
end

local function build_ignores ()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  -- We're probably in a Dart/Flutter project
  if utils.is_in_tree("pubspec.yaml") then
    return ConcatArray(ignores["default"], ignores["dart"])
  end

  if utils.is_in_tree("pom.xml") then
    return ConcatArray(ignores["default"], ignores["java"])
  end

  return ConcatArray(ignores["default"], ignores[cwd])
end

local config = function ()
  require("telescope").setup({
    defaults = {
      layout_strategy = "vertical",
      mappings = {
        n = {
          ["<C-d>"] = require("telescope.actions").delete_buffer,
        },
      },
    },
  })
  local builtin = require("telescope.builtin")

  -- Search for files only in "src/"
  vim.keymap.set("n", "<leader>pa", function ()
    builtin.find_files({
      search_dirs = { "src/" },
      file_ignore_patterns = build_ignores(),
      hidden = true,
    })
  end, {})

  -- Search for files in cwd w/ ignore
  vim.keymap.set("n", "<leader>pf", function ()
    builtin.find_files({
      file_ignore_patterns = build_ignores(),
      hidden = true,
    })
  end, {})

  -- Search for files in cwd w/o ignore
  vim.keymap.set("n", "<leader>Pf", function ()
    builtin.find_files({
      file_ignore_patterns = {},
      hidden = true,
    })
  end, {})

  -- Search for git files w/ ignore
  vim.keymap.set("n", "<C-p>", function ()
    builtin.git_files({
      file_ignore_patterns = build_ignores(),
      hidden = true,
    })
  end, {})

  -- Grep search w/ ignore
  vim.keymap.set("n", "<leader>ps", function ()
    builtin.live_grep({
      file_ignore_patterns = build_ignores(),
      hidden = true,
    })
  end)

  -- Grep search w/o ignore
  vim.keymap.set("n", "<leader>Ps", function ()
    builtin.live_grep({
      file_ignore_patterns = {},
      hidden = true,
    })
  end)

  -- View references
  vim.keymap.set("n", "<leader>vrr", function ()
    builtin.lsp_references({
      file_ignore_patterns = build_ignores(),
      initial_mode = "normal",
      hidden = true,
    })
  end)

  -- View Definitions
  vim.keymap.set("n", "<leader>gd", function ()
    builtin.lsp_definitions({
      file_ignore_patterns = build_ignores(),
      initial_mode = "normal",
      hidden = true,
    })
  end)
  -- View Definitions
  vim.keymap.set("n", "<leader>gi", function ()
    builtin.lsp_implementations({
      file_ignore_patterns = build_ignores(),
      initial_mode = "normal",
      hidden = true,
    })
  end)


  -- View Buffers
  vim.keymap.set("n", "<leader>vb", function ()
    builtin.buffers({
      initial_mode = "normal",
      hidden = true,
    })
  end)

  -- vim.keymap.set("n", "<leader>fr", function ()
  --   require("telescope").extensions.flutter.commands()
  -- end)
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = config,
}
