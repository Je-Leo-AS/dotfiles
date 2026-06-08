vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set({ "n", "v" }, "<leader>c", '"+y')

vim.keymap.set("i", "<C-v>", "<C-r>+", {
  noremap = true,
  silent = true,
  desc = "Paste from system clipboard",
})

vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', {
  noremap = true,
  silent = true,
  desc = "Paste from system clipboard",
})

vim.keymap.set("v", "<C-c>", '"+y', {
  noremap = true,
  silent = true,
  desc = "Copy selection to system clipboard",
})

vim.keymap.set("n", "<C-c>", '"+yy', {
  noremap = true,
  silent = true,
  desc = "Copy current line to system clipboard",
})

vim.keymap.set({ "n", "v" }, "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set({ "n", "v" }, "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set({ "n", "v" }, "<A-S-Up>", "yyP", { desc = "Copy line up" })
vim.keymap.set({ "n", "v" }, "<A-S-Down>", "yyp", { desc = "Copy line down" })

vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent" })

vim.keymap.set("n", "<leader>t", function()
  vim.cmd("botright split")
  vim.cmd("resize 12")
  vim.cmd("terminal")
end, { desc = "Open terminal" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
