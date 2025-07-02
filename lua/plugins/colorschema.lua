return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false, -- debe ser false para que esté disponible al inicio
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        transparent = true,
      })
      vim.cmd.colorscheme("solarized-osaka")
    end,
  },
}
