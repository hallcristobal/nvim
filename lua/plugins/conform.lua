local config = function()
  local conform = require("conform")

  local standardJsOrDefault = function(bufnr)
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    -- if cwd == "platco-resident-app" then
    --   return { lsp_format = "prefer" }
    -- end

    if vim.fn.filereadable(cwd .. "/.eslintrc.js") == 1 then
      return { "eslint" }
    elseif conform.get_formatter_info("standardjs", bufnr).available then
      return { "standardjs" }
    else
      return { "prettierd", "prettier" }
    end
  end

  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      angular = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      flow = { "prettierd", "prettier", stop_after_first = true },
      graphql = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "jq", "prettierd", "prettier", stop_after_first = true },
      javascript = standardJsOrDefault,
      javascriptreact = {},
      less = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      vue = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      bash = { "beautysh" },
      prisma = { "prisma" },
      python = { "black" },
    },
    log_level = vim.log.levels.INFO,
    notify_on_error = true,
  })

  conform.formatters.stylua = {
    prepend_args = {
      "--indent-type",
      "Spaces",
      "--indent-width",
      "2",
      "--call-parentheses",
      "Always",
    },
  }

  vim.keymap.set("n", "<leader>f", function()
    conform.format({
      async = true,
      lsp_fallback = true,
      filter = function(client) return client.name ~= "ts_ls" end
    })
  end)

  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })
  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end

return {
  "stevearc/conform.nvim",
  config = config,
}
