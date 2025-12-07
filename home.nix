# Home-Manager in standalone mode
# This is a home-manager module

{ pkgs, ... }:
{
  imports = [
    ./shared.nix # Works in both NixOS and generic linux

    ./hosts/generic-linux/nvidia.nix # Do something for generic linux
  ];

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      max-jobs = "auto";
    };
    gc = {
      automatic = true;
      dates = "monthly";
    };
  };

  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
