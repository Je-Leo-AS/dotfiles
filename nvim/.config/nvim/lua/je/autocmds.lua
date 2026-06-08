vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    local opts = { buffer = true }

    vim.keymap.set({ "n", "v", "i" }, "<C-S-p>", "<cmd>TypstPreviewToggle<cr>", opts)
    vim.keymap.set({ "n", "v", "i" }, "<C-S-b>", "!typst compile %", opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  end,
})
