require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
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
