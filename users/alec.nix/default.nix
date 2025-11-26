{ pkgs, ... }: {
  imports = [ ../../modules/system.nix/tieba-sign.nix ../../modules/de.nix ];

  home = {
    file.".icon".source = ./icon.png;
    packages = with pkgs; [ save-music ];
  };
}
