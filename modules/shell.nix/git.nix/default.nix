{ lib, ... }: {
  programs.git.enable = true;
  xdg.configFile."git/config" = lib.mkForce { source = ./gitconfig; };
}
