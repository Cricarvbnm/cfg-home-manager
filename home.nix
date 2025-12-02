# Home-Manager in standalone mode
# This is a home-manager module

{ ... }:
let inputs = { };
in {
  imports = [
    ./shared.nix
    ./pkgs.nix

    ./hosts/generic-linux/nvidia.nix

    ./users/alec.nix # Personal Configuration
  ];

  _module.args = { inherit inputs; };

  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
