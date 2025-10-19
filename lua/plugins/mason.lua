return {
  "mason.nvim",
  opts = {
    ensure_installed = {
      "pyright",
    },
  },
  { "mason-org/mason-lspconfig.nvim", config = function() end },
}
