{ config, ... }: {
  programs.hyprlock = {
    enable = !config.targets.genericLinux.enable; # For broken pam
    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/hyprlock/current.conf
    '';
  };
  xdg.configFile."hypr/${
    if config.targets.genericLinux.enable then
      "hyprlock.conf"
    else
      "hyprlock/current.conf"
  }".source = config.lib.file.mkOutOfStoreSymlink ./hyprlock.conf;
}
