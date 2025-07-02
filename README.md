# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Configuration locations

| Operating System | Path |
| ---------------- | ---- |
| Linux / macOS    | `~/.config/nvim` |
| Windows          | `%LOCALAPPDATA%\\nvim` |

Make sure to create the directory before launching Neovim for the first time.

## Required tools

LazyVim requires several command line tools to be available:

- **git**
- **gcc** or **clang**
- **Node.js** (with `npm`)
- **Python 3**

Installation varies per operating system. Examples:

- **Debian/Ubuntu**: `sudo apt install git gcc clang nodejs python3`
- **macOS** (Homebrew): `brew install git gcc node python`
- **Windows** (Chocolatey): `choco install git mingw clang nodejs python`

Other package managers work as well; use whichever is standard for your system.

## Windows notes

Some commands work best from PowerShell. If you encounter issues, try running
Neovim from `pwsh` instead of `cmd`.
