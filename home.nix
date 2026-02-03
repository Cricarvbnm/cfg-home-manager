{ pkgs, ... }:
{
  imports = [
    # Do something for generic linux
    ./hosts/generic-linux/nvidia.nix

    # Main settings
    ./modules/de.nix
    ./modules/shell.nix
    ./modules/system.nix
  ];

  home = {
    username = "alec";
    homeDirectory = "/home/alec";
    file.".icon".source = ./icon.png;

    stateVersion = "25.05";
  };

  nix = {
    package = pkgs.nix;
    # settings.substituters = [ "https://mirrors.cernet.edu.cn/nix-channels/store" ];
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
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
