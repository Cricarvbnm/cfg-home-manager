{ config, ... }: {
  programs.waybar.enable = true;
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink ./waybar;

  xdg.desktopEntries = {
    "waybar" = {
      exec = "waybar";
      name = "Waybar";
    };
    "waybar-bot" = {
      name = "Waybar Bottom";
      exec = "waybar --config ${config.xdg.configHome}/waybar/bot.jsonc";
    };
  };
}
