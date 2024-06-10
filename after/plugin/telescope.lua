local builtin = require('telescope.builtin')


require("telescope").setup({
  defaults = {
    initial_mode = "normal"
  }
})

function ConcatArray(a, b)
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
      "testing/",
    }
    return ConcatArray(file_ignore_patterns, ra_ignore_patterns)
  end
  return file_ignore_patterns
end

-- Search for files only in "src/"
vim.keymap.set('n', '<leader>pa', function()
  builtin.find_files({
    initial_mode = "insert",
    search_dirs = { "src/" },
    file_ignore_patterns = build_ignores()
  })
end, {})
-- Search for files in cwd w/ ignore
vim.keymap.set('n', '<leader>pf', function()
  builtin.find_files({
    initial_mode = "insert",
    file_ignore_patterns = build_ignores()
  })
end, {})
-- Search for files in cwd w/o ignore
vim.keymap.set('n', '<leader>Pf', function()
  builtin.find_files({
    initial_mode = "insert",
  })
end, {})

-- Search for git files w/ ignore
vim.keymap.set('n', '<C-p>', function()
  builtin.git_files({
    initial_mode = "insert",
    file_ignore_patterns = build_ignores()
  })
end, {})

-- Grep search w/ ignore
vim.keymap.set('n', '<leader>ps', function()
  builtin.live_grep({
    file_ignore_patterns = build_ignores(),
    initial_mode = "insert"
  })
end)
-- Grep search w/o ignore
vim.keymap.set('n', '<leader>Ps', function()
  builtin.live_grep({
    file_ignore_patterns = build_ignores(),
    initial_mode = "insert"
  })
end)

-- vim.keymap.set('n', '<leader>ps', function()
  -- --     builtin.grep_string({ search = vim.fn.input("Grep > ") })
  -- -- end)
  --
