return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      inlay_hints = { enabled = true, exclude = { "vue" } },
      codelens = { enabled = false },
      folds = { enabled = true },
      capabilities = {
        workspace = { fileOperations = { didRename = true, willRename = true } },
      },
      format = { formatting_options = nil, timeout_ms = nil },
      ---@type table<string, lazyvim.lsp.Config|boolean>
      servers = {
        stylua = { enabled = false },
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              codeLens = { enable = true },
              completion = { callSnippet = "Replace" },
              doc = { privateName = { "^_" } },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        pyright = {},
      },
      ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
      setup = {},
    }
    return ret
  end,

  ---@param opts PluginLspOpts
  config = vim.schedule_wrap(function(_, opts)
    -- autoformat
    LazyVim.format.register(LazyVim.lsp.formatter())

    -- ✅ reemplazo de on_attach / on_dynamic_capability con Snacks
    require("snacks.util").lsp.on(function(client, buffer)
      if type(client) == "number" then
        client = vim.lsp.get_client_by_id(client)
      end

      if not client then
        return
      end
      buffer = buffer or 0
      -- inlay hints
      if
        opts.inlay_hints.enabled
        and client.supports_method("textDocument/inlayHint")
        and vim.api.nvim_buf_is_valid(buffer)
        and vim.bo[buffer].buftype == ""
        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
      then
        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      end

      -- folds
      if opts.folds.enabled and client.supports_method("textDocument/foldingRange") then
        if LazyVim.set_default("foldmethod", "expr") then
          LazyVim.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
        end
      end

      -- codelens
      if opts.codelens.enabled and vim.lsp.codelens and client.supports_method("textDocument/codeLens") then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end
    end)

    -- diagnostics
    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = function(diagnostic)
        local icons = LazyVim.config.icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
        return "●"
      end
    end
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- capacidades por defecto
    if opts.capabilities then
      vim.lsp.config("*", { capabilities = opts.capabilities })
    end

    -- 🔧 registro/habilitación de servidores
    local have_mason = LazyVim.has("mason-lspconfig.nvim")
    local mason_all = have_mason
        and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
      or {}

    local mason_exclude = {} ---@type string[]

    local function configure(server)
      local sopts = opts.servers[server]
      sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts

      if sopts.enabled == false then
        mason_exclude[#mason_exclude + 1] = server
        return
      end

      local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
      local handler = opts.setup[server] or opts.setup["*"]
      if handler and handler(server, sopts) then
        mason_exclude[#mason_exclude + 1] = server
      else
        -- ✅ nuevo API nativo
        vim.lsp.config(server, sopts)
        if not use_mason then
          vim.lsp.enable(server)
        end
      end
      return use_mason
    end

    local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))

    if have_mason then
      require("mason-lspconfig").setup({
        ensure_installed = vim.list_extend(install, LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}),
        automatic_enable = { exclude = mason_exclude },
      })
    end
  end),
}
