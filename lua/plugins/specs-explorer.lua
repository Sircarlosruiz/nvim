return {
  "specs-explorer",
  dir = "~/dev/specs.md/nvim-extension/",
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
