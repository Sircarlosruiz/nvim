return {
  {
    "tpope/vim-dadbod",
    init = function()
      -- SQLAlchemy-style URLs (e.g. postgresql+asyncpg://...) use a driver
      -- suffix that dadbod doesn't recognize as an adapter name. Alias them
      -- to the adapters dadbod actually ships.
      vim.g.db_adapters = vim.tbl_extend("force", vim.g.db_adapters or {}, {
        ["postgresql+asyncpg"] = "postgresql",
        ["postgresql+psycopg2"] = "postgresql",
        ["mysql+pymysql"] = "mysql",
        ["mysql+aiomysql"] = "mysql",
        ["sqlite+aiosqlite"] = "sqlite",
      })
    end,
  },
}
