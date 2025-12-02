# Home-Manager in standalone mode
# This is a home-manager module

{ lib, pkgs, ... }:
let
  channelURLs = {
    nixpkgs = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
    home-manager =
      "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
  };
  channels = lib.mapAttrs (name: url: builtins.fetchTarball url) channelURLs;
  inputs =
    lib.mapAttrs (name: channel: import channel { inherit (pkgs) config; })
    channels;
in {
  imports = [
    ./shared.nix
    ./pkgs.nix

    ./hosts/generic-linux/nvidia.nix

    ./users/alec.nix # Personal Configuration
  ];

  nix.channels = channels;
  _module.args = { inherit inputs; };

  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
