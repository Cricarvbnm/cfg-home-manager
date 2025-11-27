{ pkgs, ... }: {
  imports = [ ../../modules/system.nix/tieba-sign.nix ../../modules/de.nix ];

  home = {
    username = "alec";
    homeDirectory = "/home/alec";

    file.".icon".source = ./icon.png;
    packages = with pkgs; [ save-music ];
  };
}
