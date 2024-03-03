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
		bash = { "beautysh" },
		prisma = { "prisma" },
	},

	-- Set the log level. Use `:ConformInfo` to see the location of the log file.
	log_level = vim.log.levels.WARN,
	--     -- Conform will notify you when a formatter errors
	notify_on_error = true,
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 750, lsp_fallback = true }
	end,
	formatters = {
		prettier = {
			prepend_args = {},
		},
		prisma = {
			command = "prisma format",
			stdin = false,
			require_cwd = true,
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

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
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
