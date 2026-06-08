local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("je.plugins.colorscheme"),
  require("je.plugins.telescope"),
  require("je.plugins.treesitter"),
  require("je.plugins.dap"),
  require("je.plugins.lsp"),
  require("je.plugins.typst"),
  require("je.plugins.yazi"),
  require("je.plugins.snacks"),
}, {})
