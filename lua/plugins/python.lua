-- Python: LSP (pyright, ruff), formatting, Conda/venv selection, Jupyter helpers, DAP
return {
  -- Ensure Python tools
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff",
        "black",
        "debugpy",
      })
    end,
  },

  -- LSP servers and settings
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
              autoImportCompletions = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
      opts.servers.ruff = {
        init_options = {
          settings = {
            args = {},
          },
        },
      }
    end,
  },

  -- Conform formatting: prefer ruff_format, fallback to black
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["python"] = { "ruff_format", "black" }
    end,
  },

  -- Virtual env / Conda selector (works with venv & conda envs)
  {
    "linux-cultist/venv-selector.nvim",
    cmd = { "VenvSelect", "VenvSelectCached" },
    opts = {
      name = { "venv", ".venv", "env", ".conda", "conda" },
      poetry_path = "poetry",
    },
    keys = {
      { "<leader>cv", ":VenvSelect<CR>", desc = "Select Virtualenv/Conda" },
    },
  },

  -- Jupyter-like cells inline via magma-nvim (optional, requires Jupyter installed)
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    ft = { "python", "markdown", "quarto" },
    init = function()
      vim.g.magma_image_provider = "kitty" -- use inline images in kitty/wezterm; fallback if not supported
      vim.g.magma_automatically_open_output = false
    end,
    keys = {
      { "<leader>mn", ":MagmaInit<CR>", desc = "Magma Init Kernel" },
      { "<leader>mr", ":MagmaEvaluateOperator<CR>", desc = "Magma Eval Operator", mode = { "n", "v" } },
      { "<leader>ml", ":MagmaEvaluateLine<CR>", desc = "Magma Eval Line" },
      { "<leader>mc", ":MagmaReevaluateCell<CR>", desc = "Magma Re-eval Cell" },
      { "<leader>mo", ":MagmaShowOutput<CR>", desc = "Magma Show Output" },
      { "<leader>mq", ":MagmaInterrupt<CR>", desc = "Magma Interrupt" },
    },
  },
}

