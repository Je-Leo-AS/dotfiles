-- init.lua - Configuração do Neovim usando Treesitter

-- Carregar o plugin packer
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Outros plugins...
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- Mais plugins...
end)

-- Configuração do Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "vim", "python", "javascript", "html" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

-- Mapeamentos úteis
vim.api.nvim_set_keymap('n', '<leader>th', ':TSHighlight<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ti', ':TSInstallInfo<CR>', { noremap = true, silent = true })

-- Fim da configuração
