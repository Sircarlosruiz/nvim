-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"

vim.opt.fileformat = "unix"
vim.opt.clipboard = "unnamedplus"

-- Detect the operating system and configure the default shell
local sysname = vim.loop.os_uname().sysname
if sysname == "Windows_NT" then
  -- Use PowerShell on Windows for shell commands
  vim.opt.shell = "pwsh"
else
  -- Use the user's shell if defined, otherwise fall back to bash
  vim.opt.shell = os.getenv("SHELL") or "/bin/bash"
end

vim.env.PATH = vim.env.PATH .. ":/opt/mssql-tools18/bin"

-- Fix for Python provider ENOEXEC error
vim.g.python3_host_prog = "/opt/anaconda3/bin/python3"
