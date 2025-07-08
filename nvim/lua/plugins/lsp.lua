local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

return { {
	"neovim/nvim-lspconfig",
	opts = {
		inlay_hints = { enabled = true },
	},
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

				--vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				--vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
				--				vim.keymap.set("n", "gq", vim.lsp.buf.format, opts)
				vim.keymap.set("n", "R", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gm", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, opts)
				vim.keymap.set({ "n", "x" }, "<F3>",
					"<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end,
		})

		-- These are just examples. Replace them with the language
		-- servers you have installed in your system

		-- rust
		lspconfig.rust_analyzer.setup {
			on_attach = on_attach,
			-- on_attach = function(client, bufnr)
			-- 	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			-- end
			settings = { ['rust-analyzer'] = {
				diagnostics = {
					enable = true,
				},
			} }
		}

		-- lua
		lspconfig.lua_ls.setup {
			on_attach = on_attach,
			settings = { Lua = {
				diagnostics = { globals = { 'vim' } }
			} }
		}

		-- c, cpp
		lspconfig.clangd.setup {
			on_attach = on_attach,
			cmd = {
				"clangd"
			}
		}

		lspconfig.ts_ls.setup({
			on_attach = on_attach,
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
