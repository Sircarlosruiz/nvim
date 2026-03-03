-- DevOps: YAML/Kubernetes/Helm & Docker
return {
  -- Ensure tools via Mason
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- LSPs
        "yaml-language-server",
        "helm-ls",
        -- Mason package ids (not lspconfig names)
        "dockerfile-language-server",
        "docker-compose-language-service",
      })
    end,
  },

  -- SchemaStore for better YAML (Kubernetes, GitHub Actions, etc.)
  { "b0o/SchemaStore.nvim", lazy = true },

  -- LSP settings
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      -- YAML with schemas
      opts.servers.yamlls = vim.tbl_deep_extend("force", opts.servers.yamlls or {}, {
        settings = {
          yaml = {
            keyOrdering = false,
            format = { enable = true },
            validate = true,
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      -- Helm LS
      opts.servers.helm_ls = vim.tbl_deep_extend("force", opts.servers.helm_ls or {}, {
        filetypes = { "helm" },
      })

      -- Docker
      opts.servers.dockerls = opts.servers.dockerls or {}
      opts.servers.docker_compose_language_service = opts.servers.docker_compose_language_service or {}
    end,
  },

  -- (Kubernetes UI removed)
}
