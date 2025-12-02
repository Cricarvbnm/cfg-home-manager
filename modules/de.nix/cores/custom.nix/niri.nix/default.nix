{ config, pkgs, ... }: {
  home.packages = [ pkgs.xdg-launch ];
  xdg.configFile.niri.source = config.lib.file.mkOutOfStoreSymlink ./niri;
}
