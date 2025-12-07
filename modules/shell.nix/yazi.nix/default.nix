{ config, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    extraPackages = with pkgs; [
      gnutar
      config.programs.home-manager.package
      config.programs.lazygit.package
    ];
  };
  xdg.configFile.yazi.source = config.lib.file.mkOutOfStoreSymlink ./yazi;
}
