return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- refactoring.nvim v2+ dropped the telescope extension, so override LazyVim's
    -- config to skip load_extension("refactoring") which no longer exists
    config = function(_, opts)
      require("refactoring").setup(opts)
    end,
    keys = {
      {
        "<leader>rs",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Refactor",
      },
    },
  },
}
