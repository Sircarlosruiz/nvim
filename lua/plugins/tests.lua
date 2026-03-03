-- Unified test runner (Jest, Pytest) via neotest
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-python",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Test: nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand('%')) end, desc = "Test: file" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: output" },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            env = { CI = true },
            cwd = function() return vim.fn.getcwd() end,
          }),
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          }),
        },
      }
    end,
    config = function(_, opts)
      require("neotest").setup(opts)
    end,
  },
}

