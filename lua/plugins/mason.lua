return {
  "mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "pyright",
    })

    -- Avoid repeatedly trying to install tools that are not needed in this setup.
    local skip = {
      ["black"] = true,
      ["chrome-debug-adapter"] = true,
      ["debugpy"] = true,
      ["ruff"] = true,
      ["ruff-lsp"] = true,
      ["sqlfluff"] = true,
      ["stylua"] = true,
    }

    local filtered = {}
    local seen = {}
    for _, pkg in ipairs(opts.ensure_installed) do
      if not skip[pkg] and not seen[pkg] then
        seen[pkg] = true
        filtered[#filtered + 1] = pkg
      end
    end
    opts.ensure_installed = filtered
  end,
  -- Keep explicit to avoid lazy-loading races on mason-lspconfig setup.
  {
    "mason-org/mason-lspconfig.nvim",
    config = function() end,
  },
}
