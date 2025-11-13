{ config, pkgs, ... }: {
  programs.waybar.enable = true;
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink ./waybar;

  # Need to be launched by compositors
  xdg.desktopEntries = {
    "waybar" = {
      name = "Waybar";
      exec = "waybar";
    };
    "waybar-bot" = {
      name = "Waybar Bottom";
      exec = "waybar --config ${config.xdg.configHome}/waybar/bot.jsonc";
    };
  };

  home.packages = with pkgs; [ networkmanagerapplet xdg-launch ];
}
