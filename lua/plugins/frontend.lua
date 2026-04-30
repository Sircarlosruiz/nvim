-- Frontend: React/TypeScript/Tailwind + Formatting + JS DAP
return {
  -- Ensure frontend tools via Mason
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- LSPs
        "eslint-lsp",
        "css-lsp",
        "emmet-language-server",
        "tailwindcss-language-server",
        -- Formatters
        "prettierd",
        "eslint_d",
        -- Debugger (handled by mason-nvim-dap)
      })
    end,
  },

  -- LSP servers for web stack (TypeScript extras already imported)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.eslint = opts.servers.eslint or {}
      opts.servers.cssls = opts.servers.cssls or {}
      opts.servers.emmet_ls = opts.servers.emmet_ls or {}
      -- Tailwind is provided by LazyVim extra; keep defaults
    end,
  },

  -- Conform formatting configuration
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      local js_like = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }
      for _, ft in ipairs(js_like) do
        opts.formatters_by_ft[ft] = { "prettierd" }
      end
      opts.formatters_by_ft["json"] = { "prettierd" }
      opts.formatters_by_ft["jsonc"] = { "prettierd" }
      opts.formatters_by_ft["css"] = { "prettierd" }
      opts.formatters_by_ft["scss"] = { "prettierd" }
      opts.formatters_by_ft["html"] = { "prettierd" }
      opts.formatters_by_ft["markdown"] = { "prettierd" }
      opts.formatters_by_ft["yaml"] = { "prettierd" }
      -- Prefer project-local prettier if available (default behavior of prettierd)
    end,
  },

  -- JavaScript/TypeScript debugging via VSCode JS Debug (Node, browser)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = { "js-debug-adapter" },
      automatic_installation = false,
    },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
      require("dap-vscode-js").setup({
        debugger_path = mason_path,
        adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
      })

      -- Basic Node launch configs for JS/TS
      for _, language in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do
        dap.configurations[language] = dap.configurations[language] or {}
        local configs = dap.configurations[language]
        table.insert(configs, {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (node)",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          runtimeExecutable = "node",
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        })
        table.insert(configs, {
          type = "pwa-node",
          request = "attach",
          name = "Attach (node:9229)",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
        })
      end
    end,
  },
}
