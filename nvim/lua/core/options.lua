--vim.cmd("filetype indent off")
--vim.opt.relativenumber = true
vim.opt.number = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.cmd.colorscheme("gruber-darker")
--vim.cmd.colorscheme("plain")
--vim.cmd.colorscheme("quiet")
--vim.cmd.colorscheme("lackluster-night")
--vim.cmd.colorscheme("catppuccin-macchiato")
--vim.cmd.colorscheme("vscode")
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
