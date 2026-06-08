return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("tinymist", {})
    vim.lsp.enable("tinymist")
  end,
}
