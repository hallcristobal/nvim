require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		offsets = { {
			filetype = "NvimTree",
			text = "",
			padding = 1,
		} },
		seperator_style = "slope",
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
	},
})
