vim.cmd("set expandtab")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")
vim.g.mapleader = " "


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
  {
     "neovim/nvim-lspconfig",
     config = function()
        vim.lsp.config("tinymist", {})
        vim.lsp.enable("tinymist")
     end,
  },
  {
     "chomosuke/typst-preview.nvim",
     ft = "typst",
     build = function() require("typst-preview").update() end,
  },
  {
     "folke/snacks.nvim",
     priority = 1000,
     lazy = false,
     opts = {
	     dashboard = {
        enabled = true,
        preset = {
          header = [[
      ███╗   ██╗██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██║   ██║██║████╗ ████║
      ██╔██╗ ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "y", desc = "Yazi",         action = ":terminal yazi" },
            { icon = " ", key = "c", desc = "Config", action = ":e ~/.config/nvim/init.lua" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      notifier = {
         enabled = true,
         timeout = 3000,
       },
   }
  },
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
vim.opt.wrap = true
vim.opt.linebreak = true

-- Keymaps gerais
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
-- vim.keymap.set({"n", "v", "i"}, "<C-Insert>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({"n", "v"}, "<leader>c", '"+y')
-- Colar do CLIPBOARD (Ctrl+C de fora) no modo insert
vim.keymap.set('i', '<C-v>', '<C-r>+', { desc = "Paste from system clipboard (CLIPBOARD)" })

-- Opcional: no modo normal também (cole depois do cursor)
vim.keymap.set('n', '<C-v>', '"+p', { desc = "Paste from system clipboard after cursor" })

-- Opcional: no modo visual, substituir seleção colando do CLIPBOARD
vim.keymap.set('v', '<C-v>', '"+p', { desc = "Paste (replace selection) from clipboard" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    local opts = { buffer = true }
    vim.keymap.set({"n", "v", "i"}, "<C-S-p>", "<cmd>TypstPreviewToggle<cr>", opts)
    vim.keymap.set({"n", "v", "i"}, "<C-S-b>", "!typst compile %", opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  end,
 })

vim.keymap.set({"n","v"}, "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set({"n","v"}, "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set({"n","v"}, "<A-S-Up>", "yyP", { desc = "Copy line up" })
vim.keymap.set({"n","v"}, "<A-S-Down>", "yyp", { desc = "Copy line down" })
-- Comentar linha com Ctrl+/  (funciona na maioria dos terminais)
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<C-/>", "gc",  { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent" })

vim.keymap.set("n", "<leader>t", function()
  vim.cmd("botright split")
  vim.cmd("resize 12")
  vim.cmd("terminal")
end, { desc = "Open terminal" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
