function ColorMyPencils(color)
	color = color or "vscode"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

require("vscode").setup({
	style = "dark",
	transparent = true,
	italic_comments = true,
	underline_links = true,
	color_overrides = {
		vscLineNumber = "#CCCCCC",
	},
})
require("vscode").load()
ColorMyPencils()
