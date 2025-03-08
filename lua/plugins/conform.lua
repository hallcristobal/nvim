local config = function()
  local conform = require('conform')
  local prettier_opt = { "prettierd", "prettier", stop_after_first = true }

  local standardJsOrDefault = function(bufnr)
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    if cwd == "platco_resident_app"  then
      return { prefer_lsp = true, stop_after_first = true }
    end

    if vim.fn.filereadable(cwd .. "/.eslintrc.js") == 1 then
      return { "eslint", stop_after_first = true }
    elseif conform.get_formatter_info("standardjs", bufnr).available then
      return { "standardjs", stop_after_first = true }
    else
      return { "prettierd", "prettier", stop_after_first = true }
    end
  end
  local tsOrDefault = function()
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    if cwd == "miracast-app" then
      return { "prettierd", stop_after_first = true }
    end

    return prettier_opt
  end


  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      json = { "jq", "prettierd", "prettier", stop_after_first = true },
      bash = { "beautysh" },
      prisma = { "prisma" },
      python = { "black" },

      javascript = standardJsOrDefault,
      javascriptreact = standardJsOrDefault,

      angular = prettier_opt,
      css = prettier_opt,
      flow = prettier_opt,
      graphql = prettier_opt,
      html = prettier_opt,
      less = prettier_opt,
      markdown = prettier_opt,
      scss = prettier_opt,
      typescript = tsOrDefault,
      typescriptreact = tsOrDefault,
      vue = prettier_opt,
      yaml = prettier_opt,
    },
    notify_on_error = true,
  })

  vim.keymap.set("n", "<leader>f", function()
    conform.format({
      async = true,
      lsp_fallback = true,
      filter = function(client) return client.name ~= "ts_ls" end
    })
  end)
end

return {
  'stevearc/conform.nvim',
  config = config
}
