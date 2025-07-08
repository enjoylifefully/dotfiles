--vim.cmd("filetype indent off")
--vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.cmd.colorscheme "gruber-darker"
--vim.cmd.colorscheme"plain"
--vim.cmd.colorscheme"quiet"
--vim.cmd.colorscheme "lackluster-night"
--vim.cmd.colorscheme"catppuccin-macchiato"
--vim.cmd.colorscheme"vscode"
--vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})
