# LazyVim – Setup y Guía / Setup and Guide

Este repositorio contiene mi configuración personalizada de Neovim basada en LazyVim. A continuación encontrarás instrucciones completas para instalarla en Linux, macOS y Windows, además de una explicación de cómo está organizada la configuración.

This repository contains my customized Neovim configuration based on LazyVim. Below you’ll find complete installation instructions for Linux, macOS and Windows, plus an explanation of how the configuration is organized.

---

**ES — Instalación Rápida**

- Requisitos mínimos:
  - `neovim` >= 0.9 (recomendado 0.10+)
  - `git`
  - Compilador C: `gcc` o `clang` (para plugins nativos)
  - `node` + `npm` y `python3` (requeridos por algunos LSP/formatters)
- Ubicación de la configuración de Neovim:
  - Linux/macOS: `~/.config/nvim`
  - Windows: `%LOCALAPPDATA%\nvim`
- Instala dependencias (ejemplos):
  - Debian/Ubuntu: `sudo apt update && sudo apt install -y neovim git build-essential nodejs npm python3 python3-pip`
  - Arch: `sudo pacman -S neovim git base-devel nodejs npm python`
  - macOS (Homebrew): `brew install neovim git llvm node python`
  - Windows (winget):
    - `winget install Neovim.Neovim Git.Git Python.Python.3.12 OpenJS.NodeJS`  
      (opcional: `winget install Microsoft.PowerShell` para `pwsh`)
- Instala/copia esta configuración:
  - Linux/macOS:
    - Respaldar tu config actual: `mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true`
    - Clonar tu repo: `git clone <URL_DE_TU_REPO> ~/.config/nvim`
  - Windows (PowerShell):
    - Respaldar: `Rename-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.bak" -ErrorAction SilentlyContinue`
    - Clonar: `git clone <URL_DE_TU_REPO> "$env:LOCALAPPDATA\nvim"`
- Primer arranque: ejecuta `nvim`. Se clonará `lazy.nvim` automáticamente y se instalarán los plugins. Revisa `:Lazy` y `:Mason` para el estado.

Notas por sistema operativo:
- Linux: instala `build-essential`/toolchain equivalente; si usas SQL Server CLI, esta config añade `:/opt/mssql-tools18/bin` al `PATH`.
- macOS: instala las Command Line Tools: `xcode-select --install`.
- Windows: esta config usa `pwsh` como shell por defecto; instala PowerShell 7 o cambia `vim.opt.shell` en `lua/config/options.lua`.

---

**EN — Quick Setup**

- Minimum requirements:
  - `neovim` >= 0.9 (0.10+ recommended)
  - `git`
  - C toolchain: `gcc` or `clang` (for native plugins)
  - `node` + `npm` and `python3` (needed by some LSP/formatters)
- Neovim config locations:
  - Linux/macOS: `~/.config/nvim`
  - Windows: `%LOCALAPPDATA%\nvim`
- Install dependencies (examples):
  - Debian/Ubuntu: `sudo apt update && sudo apt install -y neovim git build-essential nodejs npm python3 python3-pip`
  - Arch: `sudo pacman -S neovim git base-devel nodejs npm python`
  - macOS (Homebrew): `brew install neovim git llvm node python`
  - Windows (winget):
    - `winget install Neovim.Neovim Git.Git Python.Python.3.12 OpenJS.NodeJS`  
      (optional: `winget install Microsoft.PowerShell` for `pwsh`)
- Install/copy this config:
  - Linux/macOS:
    - Backup current: `mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true`
    - Clone your repo: `git clone <YOUR_REPO_URL> ~/.config/nvim`
  - Windows (PowerShell):
    - Backup: `Rename-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.bak" -ErrorAction SilentlyContinue`
    - Clone: `git clone <YOUR_REPO_URL> "$env:LOCALAPPDATA\nvim"`
- First launch: run `nvim`. `lazy.nvim` will bootstrap and plugins will install. Check `:Lazy` and `:Mason` for status.

OS notes:
- Linux: install your C toolchain; this config appends `:/opt/mssql-tools18/bin` to `PATH` if you use SQL Server CLI.
- macOS: install Command Line Tools: `xcode-select --install`.
- Windows: this config defaults to `pwsh` as shell; install PowerShell 7 or change `vim.opt.shell` in `lua/config/options.lua`.

---

**ES — Cómo está configurado este proyecto**

- Estructura básica
  - `init.lua`: inicia la carga de todo con `require("config.lazy")`.
  - `lua/config/lazy.lua`: configura `lazy.nvim` y LazyVim.
    - Importa la base de LazyVim: `{ "LazyVim/LazyVim", import = "lazyvim.plugins" }`.
    - Extras habilitados: TypeScript, Tailwind, YAML, Docker, JSON, Mini Animate, Copilot, Prettier.
    - Importa tus plugins locales: `{ import = "plugins" }`.
    - `checker.enabled = true` para detectar actualizaciones; `git.url_format` usa HTTPS.
  - `lua/config/options.lua`: ajustes globales.
    - `winbar`, `fileformat = "unix"`, `clipboard = "unnamedplus"`.
    - Shell por SO: `pwsh` en Windows, `$SHELL` o `/bin/bash` en Unix.
    - Añade `:/opt/mssql-tools18/bin` al `PATH` (útil para `sqlcmd`/herramientas MSSQL).
  - `lua/config/keymaps.lua`: atajo extra `\<leader>sx` para `Telescope resume`.
  - `lua/config/autocmds.lua`: listo para autocmds adicionales (se mantienen los de LazyVim por defecto).
  - `lazyvim.json`: define extras de LazyVim (AI Copilot, refactoring, markdown, python, sql, yaml, eslint, etc.).
  - `lazy-lock.json`: versiones exactas de plugins (lockfile de `lazy.nvim`).

- Tema y UI
  - `lua/plugins/colorschema.lua`: tema por defecto `craftzdog/solarized-osaka.nvim` con transparencia.
  - `lua/plugins/catppuccin.lua`: integración opcional del tema Catppuccin con múltiples plugins.
  - `lua/plugins/lualine.lua`: barra de estado con diagnósticos, VCS, hora y soporte para `noice`, `dap`, `lazy`.
  - `lua/plugins/bufferline.lua`: navegación de buffers con diagnósticos y offsets para Neo-tree.
  - `lua/plugins/which-key.lua`: preset tipo “helix” y organización de grupos de atajos.
  - `lua/plugins/noice.lua`, `lua/plugins/nui.lua`: mejoras de UI y notificaciones (si están presentes).

- Búsqueda, archivos y diagnóstico
  - `lua/plugins/telescope.lua` y `lua/plugins/file-browser.lua`: `Telescope` + extensión file-browser (`\<leader>sB`).
  - `lua/plugins/grug-far.lua`: búsqueda y reemplazo avanzado (`\<leader>sr`).
  - `lua/plugins/trouble.lua`: panel de diagnósticos, símbolos y listas (`\<leader>xx`, `\<leader>cs`, etc.).
  - `lua/plugins/todo-comments.lua`: navegación de TODO/FIXME y vistas en Trouble/Telescope.

- LSP, formato y Treesitter
  - `lua/plugins/lspconfig.lua`: diagnósticos, inlay hints, folds y servidores (`lua_ls`, `pyright`, extras de LazyVim).
  - `lua/plugins/mason.lua`: asegura instalación de herramientas (p. ej. `pyright`).
  - `lua/plugins/treesitter.lua`, `lua/plugins/treesitter-textobjects.lua`, `lua/plugins/ts-autotag.lua`, `lua/plugins/ts-comments.lua`: soporte sólido de sintaxis/AST para edición moderna.
  - Formateo frontend: `lua/plugins/frontend.lua` configura `conform.nvim` con `prettierd`/`eslint_d`.

- Lenguajes y herramientas
  - Frontend/web: ESLint, CSS LS, Emmet, Tailwind, Prettier. DAP JS con `js-debug-adapter`.
  - Python: `pyright`, `ruff_lsp`, `black`, `debugpy`, selector de entornos (`venv-selector`), soporte Jupyter opcional (`magma-nvim`).
  - DevOps: YAML con `SchemaStore`, `helm_ls`, Dockerfile y docker-compose LS.

- Depuración y pruebas
  - `lua/plugins/nvim-dap.lua`: DAP + UI, mapeos (`\<leader>db`, `\<leader>dc`, `\<leader>du`, etc.).
  - `lua/plugins/tests.lua`: `neotest` para Jest y Pytest con mapeos (`\<leader>tt`, `\<leader>tf`).

Atajos útiles (resumen)
- `\<leader>?`: ver atajos del buffer (which-key).
- Buffers: `\<S-h>`/`\<S-l>`, `[b` `]b`, `\<leader>bp` pin.
- Diagnostics: `\<leader>xx` Trouble; navegación `]q` / `[q`.
- Buscar: `\<leader>sr` GrugFar; `\<leader>sB` file browser; `\<leader>sx` Telescope resume.
- DAP: `\<leader>db` breakpoint, `\<leader>dc` continuar, `\<leader>du` UI.
- Tests: `\<leader>tt` nearest, `\<leader>tf` archivo.

Actualización y mantenimiento
- Actualiza plugins: `:Lazy sync` o `:Lazy check` y `:Lazy update`.
- Gestiona LSP/formatters: `:Mason` (instala/actualiza herramientas recomendadas).

Solución de problemas
- `pwsh` no encontrado en Windows: instala PowerShell 7 o cambia `vim.opt.shell`.
- Compiladores faltantes: instala `gcc`/`clang` y headers de tu sistema.
- `node`/`python` faltantes: instálalos o desactiva plugins que dependan de ellos.
- Entornos corporativos/proxy: configura variables de proxy para que `Mason` pueda descargar binarios.

---

**EN — How This Project Is Configured**

- Core layout
  - `init.lua`: bootstraps everything via `require("config.lazy")`.
  - `lua/config/lazy.lua`: sets up `lazy.nvim` and LazyVim.
    - Adds LazyVim base and extras: TypeScript, Tailwind, YAML, Docker, JSON, Mini Animate, Copilot, Prettier.
    - Imports local plugins: `{ import = "plugins" }`.
    - `checker.enabled = true`; `git.url_format` uses HTTPS.
  - `lua/config/options.lua`: global options.
    - `winbar`, `fileformat = "unix"`, `clipboard = "unnamedplus"`.
    - OS-aware shell: `pwsh` on Windows, `$SHELL` or `/bin/bash` on Unix.
    - Appends `:/opt/mssql-tools18/bin` to `PATH` for SQL CLI tools.
  - `lua/config/keymaps.lua`: adds `\<leader>sx` for `Telescope resume`.
  - `lua/config/autocmds.lua`: ready for custom autocmds (LazyVim defaults apply).
  - `lazyvim.json`: declares LazyVim extras (AI Copilot, refactoring, markdown, python, sql, yaml, eslint, etc.).
  - `lazy-lock.json`: pinned plugin versions for reproducible setups.

- Theme and UI
  - `lua/plugins/colorschema.lua`: default theme `craftzdog/solarized-osaka.nvim` with transparency.
  - `lua/plugins/catppuccin.lua`: Catppuccin integration across plugins.
  - `lua/plugins/lualine.lua`: statusline with diagnostics, VCS, clock, `noice`/`dap`/`lazy` integration.
  - `lua/plugins/bufferline.lua`: buffer navigation with diagnostics and offsets.
  - `lua/plugins/which-key.lua`: “helix”-style preset and grouped keymaps.

- Search, files and diagnostics
  - `lua/plugins/telescope.lua` + `lua/plugins/file-browser.lua`: Telescope with file-browser (`\<leader>sB`).
  - `lua/plugins/grug-far.lua`: advanced search & replace (`\<leader>sr`).
  - `lua/plugins/trouble.lua`: diagnostics/symbols/quickfix hub (`\<leader>xx`, `\<leader>cs`).
  - `lua/plugins/todo-comments.lua`: TODO/FIXME navigation and pickers.

- LSP, formatting and Treesitter
  - `lua/plugins/lspconfig.lua`: diagnostics, inlay hints, folds; servers like `lua_ls`, `pyright` plus LazyVim extras.
  - `lua/plugins/mason.lua`: ensures key tools are installed (e.g. `pyright`).
  - Treesitter stack: `treesitter.lua`, `treesitter-textobjects.lua`, `ts-autotag.lua`, `ts-comments.lua`.
  - Frontend formatting: `frontend.lua` with `conform.nvim` (`prettierd`/`eslint_d`).

- Languages and tooling
  - Frontend/web: ESLint, CSS LS, Emmet, Tailwind, Prettier. JS DAP via `js-debug-adapter`.
  - Python: `pyright`, `ruff_lsp`, `black`, `debugpy`, env selector (`venv-selector`), optional Jupyter (`magma-nvim`).
  - DevOps: YAML with `SchemaStore`, `helm_ls`, Dockerfile and docker-compose language servers.

- Debugging and testing
  - `nvim-dap.lua`: DAP + UI with keymaps (`\<leader>db`, `\<leader>dc`, `\<leader>du`).
  - `tests.lua`: `neotest` for Jest and Pytest with keymaps (`\<leader>tt`, `\<leader>tf`).

Useful keymaps (quick glance)
- `\<leader>?`: buffer keymaps (which-key).
- Buffers: `\<S-h>`/`\<S-l>`, `[b` `]b`, `\<leader>bp` pin.
- Diagnostics: `\<leader>xx` Trouble; `]q` / `[q` to navigate.
- Search: `\<leader>sr` GrugFar; `\<leader>sB` file browser; `\<leader>sx` Telescope resume.
- DAP: `\<leader>db` breakpoint, `\<leader>dc` continue, `\<leader>du` UI.
- Tests: `\<leader>tt` nearest, `\<leader>tf` file.

Updates and maintenance
- Update plugins: `:Lazy sync` or `:Lazy check` then `:Lazy update`.
- Manage LSP/formatters: `:Mason` (install/update recommended tools).

Troubleshooting
- `pwsh` missing on Windows: install PowerShell 7 or change `vim.opt.shell`.
- Missing compilers: install `gcc`/`clang` and system headers.
- Missing `node`/`python`: install them or disable dependent plugins.
- Corporate/proxy networks: configure proxy env vars so `Mason` can download binaries.

---

Créditos: basado en [LazyVim](https://github.com/LazyVim/LazyVim) y su ecosistema. Revisa también la guía oficial de instalación: https://lazyvim.github.io/installation
