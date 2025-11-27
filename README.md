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

| Channel        | Varable Name in Module Arguments | Link                                                                       | Description                      |
| -------------- | -------------------------------- | -------------------------------------------------------------------------- | -------------------------------- |
| home-manager   |                                  | https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz |                                  |
| nixpkgs        | `pkgs`                           | https://mirrors.cernet.edu.cn/nix-channels/nixpkgs-unstable                | Mainly used nixpkgs.             |
| nixpkgs-stable | `nixpkgs-stable`                 | https://mirrors.cernet.edu.cn/nix-channels/nixos-25.05                     | Stable version of nixpkgs to use |

Commands to add these channels:

```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
nix-channel --add https://mirrors.cernet.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
nix-channel --add https://mirrors.cernet.edu.cn/nix-channels/nixos-25.05 nixpkgs-stable

nix-channel --update
```

Channels are used in this way (in `home.nix`):

```nix
{ ... }:
let
  inputs = {
    nixpkgs-stable =
      import <nixpkgs-stable> { config = config.nixpkgs.config; };
  };
in {
  _module.args = {inherit inputs; };
}
```

### NixOS Module (`inputs`)

| Channel      | Variable Name in Module Arguments | Link                                                                       | Description                      |
| ------------ | --------------------------------- | -------------------------------------------------------------------------- | -------------------------------- |
| home-manager |                                   | https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz |                                  |
| nixos        | `pkgs`                            | https://mirrors.cernet.edu.cn/nix-channels/nixos-unstable                  | Mainly used nixpkgs.             |
| nixos-stable | `inputs.nixpkgs-stable`           | https://mirrors.cernet.edu.cn/nix-channels/nixos-25.05                     | Stable version of nixpkgs to use |

Commands to add these channels:

```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
nix-channel --add https://mirrors.cernet.edu.cn/nix-channels/nixpkgs-unstable nixos
nix-channel --add https://mirrors.cernet.edu.cn/nix-channels/nixos-25.05 nixpkgs-stable

nix-channel --update
```

Channels are used in this way (may in `/etc/nixos/configuration.nix`):

```nix
{ ... }:
let
  inputs = {
    nixpkgs-stable = import <nixos-stable> { config = config.nixpkgs.config; };
    nixpkgs-unstable =
      import <nixos-unstable> { config = config.nixpkgs.config; };
  };
in {
  _module.args = { inherit inputs; };
}
```

## Deployment

### Standalone

See
https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
(not needed to add channels)

### NixOS Module

Add `imports = [ ./path/to/this/repository ]` into your `configuration.nix`
and rebuild the NixOS.
