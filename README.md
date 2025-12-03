# Home-Manager Configuration

This repository includes the versions of standalone and nixos modules.

In fact, this is not a flake. Use flake to manage inputs,
but use [flake-compat](https://github.com/NixOS/flake-compat) to get inputs
and set them to `nix.channels` and `_module.arg.inputs`.

## Files and Usage

### Standalone (for generic linux)

- `home.nix`: The entry that
  **importing the user-specified configuration** (`users/alec.nix`).
  Contains settings only for generic linux.

- `flake-compat.nix`: Manages inputs in flake's way,
  makes them available in module arguments and adds as channels.
  - `default.nix`: Sets inputs from `compat.nix` to `_module.args` and `nix.channels`
  - `compat.nix`: Use [flake-compat](https://github.com/NixOS/flake-compat)
    to something according to `flake.nix` and `flake.lock`
  - `flake.nix` & `flake.lock`: Needs to be managed by command `nix flake`

- `hosts`: Host-related modules
  - `generic-linux`: modules for generic linux

### NixOS Module

- `default.nix`: The entry, only works as nixos module without flake.

### Shared

- `shared.nix`: A home-manager module used in both modes (standalone and nixos module).

- `pkgs.nix`: Adds custom packages using overlays.

- `pkgs`: Custom packages.

- `users`: Modules for per-user settings.

- `modules`: Home settings.

## Deployment

### Channels

Examples

- `nixpkgs`: https://channels.nixos.org/nixos-25.11
- `home-manager`: https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz

### Standalone

See
https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone

### NixOS Module

Add `imports = [ ./path/to/this/repository ]` into your `configuration.nix`
and rebuild the NixOS.
