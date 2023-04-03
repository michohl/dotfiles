# Neovim

This configuration is built for version `0.8` of Neovim and certain aspects will not work without this version. On debian systems you'll have to build from source to accomplish this.

# Setup

## Before launching Neovim

```console
$ ./scripts/install-deps.sh
$ ./scripts/install-packer.sh
```

## Installing Fonts

If you want the Nvim Tree fonts to work properly then you will need to install the [Nerd Fonts Collection](https://www.nerdfonts.com/).

```console
$ ./scripts/install-nerd-fonts.sh
```

## Inside Neovim

```console
:PackerSync
```
