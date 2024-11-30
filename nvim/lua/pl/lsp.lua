return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require "lspconfig"

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig.util.default_config.capabilities,
				require "cmp_nvim_lsp".default_capabilities()
			)

			-- Executes the callback function every time a
			-- language server is attached to a buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "R", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				end,
			})

			-- These are just examples. Replace them with the language
			-- servers you have installed in your system

			-- rust
			lspconfig.rust_analyzer.setup {}

			-- lua
			lspconfig.lua_ls.setup {
				settings = { Lua = {
					diagnostics = { globals = { 'vim' } }
				} }
			}

			-- c, cpp
			lspconfig.clangd.setup {}

			lspconfig.ts_ls.setup({
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})
			---
			-- Autocompletion setup
			---
			local cmp = require "cmp"

			cmp.setup {
				sources = {
					{ name = "nvim_lsp" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-l>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					--["<S-CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						-- You need Neovim v0.10 to use vim.snippet
						vim.snippet.expand(args.body)
					end,
				},
			}
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
}
