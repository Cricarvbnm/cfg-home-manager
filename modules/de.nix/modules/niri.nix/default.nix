{ config, ... }: {
  imports = [
    ../bar.nix
    ../lock.nix
    ../idle.nix
    ../notification.nix
    ../clipboard.nix
    ../menu.nix
    ../polkit.nix
    ../wallpaper.nix
  ];

  xdg.configFile.niri.source = config.lib.file.mkOutOfStoreSymlink ./niri;
}
