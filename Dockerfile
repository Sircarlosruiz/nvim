# syntax=docker/dockerfile:1
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  git \
  gnupg \
  locales \
  ripgrep \
  unzip \
  zip \
  build-essential \
  software-properties-common \
  && locale-gen en_US.UTF-8 \
  && add-apt-repository ppa:neovim-ppa/stable \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  neovim \
  fd-find \
  python3 \
  python3-pip \
  python3-venv \
  nodejs \
  npm \
  && ln -s /usr/bin/fdfind /usr/local/bin/fd \
  && python3 -m pip install --no-cache-dir pynvim \
  && npm install -g neovim \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash neovim
RUN mkdir -p /workspace && chown neovim:neovim /workspace
USER neovim
WORKDIR /home/neovim

ENV XDG_CONFIG_HOME=/home/neovim/.config \
  XDG_DATA_HOME=/home/neovim/.local/share \
  XDG_STATE_HOME=/home/neovim/.local/state \
  XDG_CACHE_HOME=/home/neovim/.cache

COPY --chown=neovim:neovim . /home/neovim/.config/nvim

WORKDIR /home/neovim/.config/nvim

RUN mkdir -p $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME \
  && nvim --headless \
  "+Lazy! sync" \
  +qa

WORKDIR /workspace

ENTRYPOINT ["nvim"]
CMD []
