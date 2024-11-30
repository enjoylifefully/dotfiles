vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>n", "<cmd>Neotree focus<CR>")
vim.keymap.set("n", "<leader>m", "<cmd>Neotree close<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>bd<CR>")
vim.keymap.set("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>")
vim.keymap.set("i", "<S-CR>", "<Esc>")

vim.keymap.set("n", "<leader>o", function()
	local command = vim.fn.input("%")
	if command ~= "" then
		vim.cmd("terminal " .. command)
		vim.cmd("normal! G")
	end
end)
