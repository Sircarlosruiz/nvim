# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Configuration locations

| Operating System | Path                   |
| ---------------- | ---------------------- |
| Linux / macOS    | `~/.config/nvim`       |
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

## Mason-managed tools

This template uses [Mason](https://github.com/williamboman/mason.nvim) to
automatically install additional CLI tools. The file
`lua/plugins/example.lua` lists common utilities such as `shellcheck` and
`shfmt` that Mason will download when needed. Binaries are fetched for your
operating system and placed inside Mason's data directory.

If you prefer manual installation or your environment does not allow Mason to
download binaries, you can install these tools yourself:

- **ShellCheck** – available from package managers or from
  <https://github.com/koalaman/shellcheck/releases> for Linux, macOS and Windows
- **shfmt** – distributed at <https://github.com/mvdan/sh/releases> with
  downloads for all platforms

## Building the Docker image

If you prefer to run LazyVim from a container, this repository includes a
`Dockerfile`. Give the resulting image a name (or tag) by using the `-t`
parameter when you build it. For example, to create an image called
`lazyvim:latest`, run:

```bash
docker build -t lazyvim:latest .
```

You can replace `lazyvim:latest` with any name that suits your setup.

## Developing with the Docker image

Once the image is built, you can launch Neovim inside a container and edit your
project files by mounting your working directory into `/workspace`:

```bash
docker run --rm -it \
  -v "$(pwd)":/workspace \
  -w /workspace \
  lazyvim:latest
```

Because the image's entrypoint is `nvim`, the editor opens immediately inside
the container. The `-v` flag shares your current directory with the container,
and `-w /workspace` sets it as the working directory so Neovim starts in the
right place. When you exit Neovim, the container stops and any changes to your
project files remain on the host.

If you want to persist Neovim's cache or plugin downloads between runs, map the
corresponding directories as volumes. For example:

```bash
docker run --rm -it \
  -v "$(pwd)":/workspace \
  -v lazyvim-data:/home/neovim/.local/share \
  lazyvim:latest
```

This approach keeps LazyVim's data under the named volume `lazyvim-data` while
still letting you edit source code from the host machine.
