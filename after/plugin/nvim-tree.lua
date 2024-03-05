require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
		icons = {
			show = {
				file = false,
			},
		},
	},
	filters = {
		dotfiles = false,
	},
})
