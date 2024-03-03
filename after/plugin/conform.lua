require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		angular = { { "prettierd", "prettier" } },
		css = { { "prettierd", "prettier" } },
		flow = { { "prettierd", "prettier" } },
		graphql = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		javascript = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		less = { { "prettierd", "prettier" } },
		markdown = { { "prettierd", "prettier" } },
		scss = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		vue = { { "prettierd", "prettier" } },
		yaml = { { "prettierd", "prettier" } },
	},

	-- Set the log level. Use `:ConformInfo` to see the location of the log file.
	log_level = vim.log.levels.WARN,
	--     -- Conform will notify you when a formatter errors
	notify_on_error = true,
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 750,
	},

	formatters = {
		prettier = {
			prepend_args = {},
		},
	},
})

-- local slow_format_filetypes = {}
-- require("conform").setup({
-- 	format_on_save = function(bufnr)
-- 		if slow_format_filetypes[vim.bo[bufnr].filetype] then
-- 			return
-- 		end
-- 		local function on_format(err)
-- 			if err and err:match("timeout$") then
-- 				slow_format_filetypes[vim.bo[bufnr].filetype] = true
-- 			end
-- 		end
--
-- 		return { timeout_ms = 200, lsp_fallback = true }, on_format
-- 	end,
--
-- 	format_after_save = function(bufnr)
-- 		if not slow_format_filetypes[vim.bo[bufnr].filetype] then
-- 			return
-- 		end
-- 		return { lsp_fallback = true }
-- 	end,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
