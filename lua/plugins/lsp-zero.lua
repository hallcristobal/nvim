local config = function()
	local lsp_zero = require("lsp-zero")

	lsp_zero.on_attach(function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>d", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- apparently is needed to have persistent signajure_help

		if client.server_capabilities.document_highlight then
			vim.api.nvim_exec(
				[[
      hi LspReferenceRead  gui=none  guibg=#393649
      hi LspReferenceText  [gui=none  guibg=#393649
      hi LspReferenceWrite gui=none  guibg=#393649
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
				false
			)
		end
		lsp_zero.default_keymaps(opts)
	end)

	local lspconfig = require("lspconfig")
	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	)

	require("mason").setup({})
	require("mason-lspconfig").setup({
		handlers = {
			lsp_zero.default_setup,
			lua_ls = function()
				local lua_opts = lsp_zero.nvim_lua_ls()
				lspconfig.lua_ls.setup(lua_opts)
			end,
			clangd = function()
				lspconfig.clangd.setup({
					cmd = {
						"clangd",
						"--background-index",
						"--suggest-missing-includes",
						"--all-scopes-completion",
						"--completion-style=detailed",
						"--compile-commands-dir=",
						"--function-arg-placeholders=0",
					}, -- custom build dir

					capabilities = capabilities,
				})
			end,
		},
	})

	local luasnip = require("luasnip")
	vim.keymap.set({ "i" }, "<C-K>", function()
		luasnip.expand()
	end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<C-L>", function()
		luasnip.jump(1)
	end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<C-J>", function()
		luasnip.jump(-1)
	end, { silent = true })

	vim.keymap.set({ "i", "s" }, "<C-E>", function()
		if luasnip.choice_active() then
			luasnip.change_choice(1)
		end
	end, { silent = true })

	require("luasnip.loaders.from_vscode").lazy_load()
	require("lsp_signature").setup({})
	require("nvim-ts-autotag").setup({
		opts = {
			enable_close = true, 
			enable_rename = true, 
			enable_close_on_slash = false, 
		},
		per_filetype = {
			["html"] = {
				enable_close = false,
			},
		},
	})
end

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "VeryLazy",
		},
		"windwp/nvim-ts-autotag",
	},
	config = config,
}
