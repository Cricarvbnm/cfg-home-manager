{ config, ... }: {
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/hyprlock/current.conf
    '';
  };
  xdg.configFile."hypr/hyprlock/current.conf".source =
    config.lib.file.mkOutOfStoreSymlink ./hyprlock.conf;
  mine.de.idle.lock = "${config.programs.hyprlock.package}/bin/hyprlock";
}
