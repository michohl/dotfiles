# Neovim

This configuration is built for version `0.8` of Neovim and certain aspects will not work without this version. On debian systems you'll have to build from source to accomplish this.

# Setup

## Before launching Neovim

```console
$ ./scripts/install-deps.sh
$ ./scripts/install-packer.sh
```

## LSP Dependencies

By default Mason will probably fail to install all the language servers unless you have the following packages

| LSP             | Package(s) Required  |
|:--              |:--                   |
| gopls           | golang               |
| rust_analzyer   | cargo, rustc         |
| neocmake        | g++                  |
| Everything Else | npm                  |

These are not included in `scripts/install-deps.sh` because not every machine needs to be used for all these languages.

## Installing Fonts

If you want the Nvim Tree fonts to work properly then you will need to install the [Nerd Fonts Collection](https://www.nerdfonts.com/).

```console
$ ./scripts/install-nerd-fonts.sh
```

## Inside Neovim

```console
:PackerSync
```
