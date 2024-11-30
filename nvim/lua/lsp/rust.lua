local nvim_lsp = vim.lsp
local rust_analyzer_path = "/opt/homebrew/bin/rust-analyzer"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    nvim_lsp.start({
      cmd = { rust_analyzer_path },
      filetypes = { "rust" },
      root_dir = vim.fn.getcwd(),
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = { command = "clippy" },
        },
      },
      on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end,
    })
  end,
})

