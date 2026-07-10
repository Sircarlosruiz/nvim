return {
  "specs-explorer",
  dir = "~/dev/specsmd.nvim/",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>se", "<cmd>SpecsExplorer<cr>", desc = "Specs Explorer" },
  },
  config = function()
    require("specsmd").setup({})
  end,
}
