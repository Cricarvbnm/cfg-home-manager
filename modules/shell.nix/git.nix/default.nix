{ lib, ... }: {
  programs.git.enable = true;
  xdg.configHome."git/config" = lib.mkForce { source = ./gitconfig; };
}
