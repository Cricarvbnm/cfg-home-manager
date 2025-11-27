# Home-Manager in standalone mode
# This is a home-manager module

{ config, ... }:
let
  inputs = {
    nixpkgs-stable =
      import <nixpkgs-stable> { config = config.nixpkgs.config; };
  };
in {
  imports = [
    ./shared.nix
    ./pkgs.nix

    ./users/alec.nix # Personal Configuration
  ];

  _module.args = { inherit inputs; };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
