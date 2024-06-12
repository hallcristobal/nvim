local config = function()
  local conform = require('conform')

  local standardJsOrDefault = function(bufnr)
    if conform.get_formatter_info("standardjs", bufnr).available then
      return { "standardjs" }
    else
      return { { "prettierd", "prettier", "standardjs" } }
    end
  end

  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      angular = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      flow = { { "prettierd", "prettier" } },
      graphql = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      javascript = standardJsOrDefault,
      javascriptreact = standardJsOrDefault,
      less = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      vue = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      bash = { "beautysh" },
      prisma = { "prisma" },
      python = { "black" }
    },
    log_level = vim.log.levels.WARN,
    notify_on_error = true,
  })

  vim.keymap.set("n", "<leader>f", function()
    conform.format({ async = true, lsp_fallback = true })
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
  'stevearc/conform.nvim',
  config = config
}
