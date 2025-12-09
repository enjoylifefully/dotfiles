--return {}
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		--      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	opts = {
		window = {
			position = "right",
		},
		filesystem = {
			hijack_netrw_behavior = "disabled", -- Impede que o Neo-tree sobrescreva o Netrw
		},
	},
}
