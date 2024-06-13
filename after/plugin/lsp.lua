-- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
-- local lsp_format_on_save = function(bufnr)
--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
--         vim.api.nvim_create_autocmd('BufWritePre', {
--                 group = augroup,
--                 buffer = bufnr,
--                 callback = function()
--                         vim.lsp.buf.format()
--                         filter = function(client)
--                                 return client.name == "null-ls"
--                         end
--                 end
--         })
-- end

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- lsp_format_on_save(bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<leader>gd", function()
		require("telescope.builtin").lsp_definitions()
	end, opts)
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
	vim.keymap.set("v", "<leader>ca", function()
		require("cosmic-ui").range_code_actions()
	end, opts)
	vim.keymap.set("n", "<leader>ca", function()
		require("cosmic-ui").code_actions()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		require("telescope.builtin").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		require("cosmic-ui").rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- apparently is needed to have persistent signajure_help

	-- Set autocommands conditional on server_capabilities
	-- Light highlight color: #b2dbe7
	-- Dark highlight color: #393649
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      hi LspReferenceRead  gui=none	guibg=#393649
      hi LspReferenceText  [gui=none	guibg=#393649
      hi LspReferenceWrite gui=none	guibg=#393649
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"rust_analyzer",
	},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

require("lspconfig").pylsp.setup({
	filetypes = { "python" },
	settings = {
		formatCommand = { "black" },
		pylsp = {
			plugins = {
				pycodestyle = {
					enabled = true,
					ignore = { "E501", "E231" },
					maxLineLength = 120,
				},
			},
		},
	},
})

local capabilities = vim.tbl_deep_extend(
	"force",
	{},
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities()
)

require("lspconfig").clangd.setup({
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

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("lsp_signature").setup({
	debug = false, -- set to true to enable debug logging
	log_path = "debug_log_file_path", -- debug log path
	verbose = false, -- show debug line number
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- If you want to hook lspsaga or other signature handler, pls set to false
	doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default
	wrap = false, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
	-- will set to true when fully tested, set to false will use whichever side has more space
	-- this setting will be helpful if you do not want the PUM and floating win overlap
	fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = true, -- virtual hint enable
	hint_prefix = "🐼 ", -- Panda for parameter
	hint_scheme = "String",
	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
	-- to view the hiding contents
	max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width, the value need >= 40
	handler_opts = {
		border = "rounded", -- double, rounded, single, shadow, none
	},
	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
	auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
	check_completion_visible = true, -- adjust position of signature window relative to completion popup
	extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
	padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
	transparency = nil, -- disabled by default, allow floating win transparent value 1~100
	shadow_blend = 36, -- if you using shadow as border use this set the opacity
	shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	-- formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

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

-- ["<S-Tab>"] = cmp.mapping(function(fallback)
--   if cmp.visible() then
--     cmp.select_prev_item()
--   elseif luasnip.locally_jumpable(-1) then
--     luasnip.jump(-1)
--   else
--     fallback()
--   end
-- end, { "i", "s" }),

-- vim.lsp.handlers['textDocument/hover'] = function(_, method, result)
--     vim.lsp.util.focusable_float(method, function()
--         if not (result and result.contents) then
--             -- return { 'No information available' }
--             return
--         end
--         local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
--         markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
--         if vim.tbl_isempty(markdown_lines) then
--             -- return { 'No information available' }
--             return
--         end
--         local bufnr, winnr = vim.lsp.util.fancy_floating_markdown(markdown_lines, {
--             pad_left = 1, pad_right = 1,
--         })
--         vim.lsp.util.close_preview_autocmd({ "CursorMoved", "BufHidden" }, winnr)
--         return bufnr, winnr
--     end)
-- end
