local function ConcatArray(a, b)
  local result = { unpack(a) }
  table.move(b, 1, #b, #result + 1, result)
  return result
end

local function build_ignores()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  local file_ignore_patterns = {
    "yarn%.lock",
    "node_modules/",
    "raycast/",
    "dist/",
    "%.next",
    "%.git/",
    "%.gitlab/",
    "build/",
    "target/",
    "package%-lock%.json",
  }

  if cwd == "platco-resident-app" then
    local ra_ignore_patterns = {
      "assets/",
      "bolt/",
      "coverage/",
      "cypress/",
      "dist/",
      "docs/",
      "i18n/",
      "infra/",
      "license/",
      "node_modules/",
      "scripts/",
      "test/",
      "testing/",
    }
    return ConcatArray(file_ignore_patterns, ra_ignore_patterns)
  end
  return file_ignore_patterns
end

local config = function()
  require("telescope").setup({
    defaults = {
      layout_strategy = "vertical",
      mappings = {
        n = {
          ['<C-d>'] = require("telescope.actions").delete_buffer
        }
      }
    }
  })
  local builtin = require("telescope.builtin")

  -- Search for files only in "src/"
  vim.keymap.set('n', '<leader>pa', function()
    builtin.find_files({
      search_dirs = { "src/" },
      file_ignore_patterns = build_ignores(),
    })
  end, {})

  -- Search for files in cwd w/ ignore
  vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
      file_ignore_patterns = build_ignores()
    })
  end, {})

  -- Search for files in cwd w/o ignore
  vim.keymap.set('n', '<leader>Pf', function()
    builtin.find_files()
  end, {})

  -- Search for git files w/ ignore
  vim.keymap.set('n', '<C-p>', function()
    builtin.git_files({
      file_ignore_patterns = build_ignores()
    })
  end, {})

  -- Grep search w/ ignore
  vim.keymap.set('n', '<leader>ps', function()
    builtin.live_grep({
      file_ignore_patterns = build_ignores(),
    })
  end)

  -- Grep search w/o ignore
  vim.keymap.set('n', '<leader>Ps', function()
    builtin.live_grep({
      file_ignore_patterns = build_ignores(),
    })
  end)

  -- View references
  vim.keymap.set("n", "<leader>vrr", function()
    builtin.lsp_references({
      file_ignore_patterns = build_ignores(),
      initial_mode = "normal"
    })
  end)

  -- View Definitions
  vim.keymap.set("n", "<leader>gd", function()
    builtin.lsp_definitions({
      file_ignore_patterns = build_ignores(),
      initial_mode = "normal"
    })
  end)

  -- View Buffers
  vim.keymap.set("n", "<leader>vb", function()
    builtin.buffers({
      initial_mode = "normal"
    })
  end)
end

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config
}
