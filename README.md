# Home-Manager Configuration

This repository includes the versions of standalone and nixos modules.

**No flakes**.

## Standalone (mainly for generic linux)

The entry is `home.nix`,
**importing the user-specified configuration** (`users/alec.nix`).

## NixOS Module

The entry is `default.nix`.

## Requirements: `inputs` / Channels (in $NIX_PATH)

Channels are added into `inputs` in `home.nix` (as standalone)
or any parent module like `/etc/nixos/configuration.nix` (as nixos module).

### Standalone (Channels)

See `home.nix`.

### NixOS Module (`inputs`)

| Channel      | Variable Name in Module Arguments | Link                                                                       | Description                      |
| ------------ | --------------------------------- | -------------------------------------------------------------------------- | -------------------------------- |
| home-manager |                                   | https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz |                                  |
| nixos-stable | `inputs.nixpkgs-stable`           | https://mirrors.cernet.edu.cn/nix-channels/nixos-25.05                     | Stable version of nixpkgs to use |

## Deployment

### Standalone

See
https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone

### NixOS Module

Add `imports = [ ./path/to/this/repository ]` into your `configuration.nix`
and rebuild the NixOS.
