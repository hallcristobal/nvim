local M = {}

--- default on_attach
function M.on_attach (client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  local function nmap (prefix, func)
    vim.keymap.set("n", prefix, function ()
      func()
    end, opts)
  end
  local function imap (prefix, func)
    vim.keymap.set("i", prefix, function ()
      func()
    end, opts)
  end

  nmap("K", function ()
    vim.lsp.buf.hover()
  end)
  nmap("<leader>vws", function ()
    vim.lsp.buf.workspace_symbol()
  end)
  nmap("<leader>d", function ()
    vim.diagnostic.open_float()
  end)
  nmap("]d", function ()
    vim.diagnostic.goto_next()
  end)
  nmap("[d", function ()
    vim.diagnostic.goto_prev()
  end)
  nmap("<leader>ca", function ()
    vim.lsp.buf.code_action()
  end)
  nmap("<leader>vrn", function ()
    vim.lsp.buf.rename()
  end)
  nmap("<leader>ih", function ()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = nil }), { bufnr = nil })
  end)

  imap("<C-h>", function ()
    vim.lsp.buf.signature_help()
  end)
end
return M
