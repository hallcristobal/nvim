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

vim.api.nvim_create_user_command("VaultStringDecrypt", function()
  vim.cmd("normal! gvy")
  vim.fn.setreg('"', vim.fn.system(
    'sed "s/^[[:space:]]*//" | ansible-vault decrypt --vault-pass-file private/.vaultpass --output -',
    vim.fn.getreg('"')
  ))
  vim.cmd("normal! gvP")
end, { range = true, desc = "Decrypt vault string inline" })

vim.api.nvim_create_user_command("Base64Decode", function()
  vim.cmd("normal! gvy")
  vim.fn.setreg('"', vim.fn.system("base64 --decode", vim.fn.getreg('"')))
  vim.cmd("normal! gvP")
end, { range = true, desc = "Base64 decode selection inline" })
