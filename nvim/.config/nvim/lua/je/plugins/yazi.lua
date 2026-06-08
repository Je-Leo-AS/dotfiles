return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
  },
  keys = {
    {
      "<leader>y",
      "<cmd>Yazi cwd<cr>",
      desc = "Open Yazi",
    },
  },
  opts = {
    open_for_directories = false,
    floating_window_scaling_factor = 0.95,
    yazi_floating_window_border = "rounded",
  },
}
