vim.cmd("set expandtab")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")
vim.g.mapleader = " "

-- init.lua
vim.opt.clipboard = "unnamedplus"  -- usa o CLIPBOARD (Ctrl+C/Ctrl+V)

-- ou para usar os dois
vim.opt.clipboard = "unnamed,unnamedplus"
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
local opts = {}
local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1001 },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
  },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
  { "mfussenegger/nvim-dap-python" },   -- adapter de python
  { "williamboman/mason.nvim" },        -- gerenciador de adapters
  { "jay-babu/mason-nvim-dap.nvim" },  -- bridge mason + dap
}
require("lazy").setup(plugins, opts)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})

-- Catppuccin
require("catppuccin").setup()
vim.cmd.colorscheme("catppuccin")

-- Mason
require("mason").setup()
require("mason-nvim-dap").setup({
  ensure_installed = { "debugpy" },
  automatic_installation = true,
})

-- DAP Python
require("dap-python").setup("python3")

-- DAP UI
local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

-- Abre/fecha UI automaticamente ao iniciar/terminar debug
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- Keymaps de debug
vim.keymap.set("n", "<F5>",       dap.continue,          { desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>",      dap.step_over,         { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>",      dap.step_into,         { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>",      dap.step_out,          { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>b",  dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>du", dapui.toggle,          { desc = "Debug: Toggle UI" })

vim.opt.number = true
vim.opt.relativenumber = false  -- opcional, muito útil com movimentos

-- Keymaps gerais
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set({"n", "v"}, "<C-c>", '"+y', { desc = "Copy to system clipboard" })
-- Redireciona Shift+Insert para colar do CLIPBOARD (+ register)
vim.keymap.set('i', '<S-Insert>', '<C-r>+', { desc = "Paste from CLIPBOARD (system copy)" })
vim.keymap.set({'n', 'v'}, '<S-Insert>', '"+p', { desc = "Paste from CLIPBOARD after cursor" })
-- Colar do CLIPBOARD (Ctrl+C de fora) no modo insert
vim.keymap.set('i', '<C-v>', '<C-r>+', { desc = "Paste from system clipboard (CLIPBOARD)" })

-- Opcional: no modo normal também (cole depois do cursor)
vim.keymap.set('n', '<C-v>', '"+p', { desc = "Paste from system clipboard after cursor" })

-- Opcional: no modo visual, substituir seleção colando do CLIPBOARD
vim.keymap.set('v', '<C-v>', '"+p', { desc = "Paste (replace selection) from clipboard" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.keymap.set("n", "<C-S-b>", function()
      vim.cmd("!typst compile %")
    end, { buffer = true, desc = "Compile Typst" })
  end,
})

vim.keymap.set({"n","v"}, "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set({"n","v"}, "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })

