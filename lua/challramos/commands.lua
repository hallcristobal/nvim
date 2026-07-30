local codelens_enabled = false
vim.lsp.codelens.enable(false)

vim.api.nvim_create_user_command("CodeLensToggle", function()
  codelens_enabled = not codelens_enabled
  vim.lsp.codelens.enable(codelens_enabled)
  if codelens_enabled then
    vim.lsp.codelens.refresh({ bufnr = 0 })
  end
  vim.notify("CodeLens " .. (codelens_enabled and "enabled" or "disabled"))
end, { desc = "Toggle LSP codelens" })
