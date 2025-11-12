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
  mine.de.idle.displays = {
    niri = status:
      "niri msg action power-${if status then "on" else "off"}-monitors";
  };
}
