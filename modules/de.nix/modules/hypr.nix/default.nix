{ config, pkgs, ... }: {
  imports = [
    ../bar.nix
    ../clipboard.nix
    ../menu.nix
    ../notification.nix

    # Binding Related
    ../browser.nix
    ../torrent.nix
    ../terminal.nix
    ../lock.nix
    ../wallpaper.nix
  ];

  home.packages = with pkgs; [ hyprshot xdg-launch networkmanagerapplet ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enableXdgAutostart = true;
    extraConfig = ''
      $hyprDir = ${config.xdg.configHome}/hypr
      $configDir = $hyprDir/hyprland.conf.d

      source = $configDir/*.hypr
    '';
    plugins = with pkgs.hyprlandPlugins; [ hyprexpo ];
  };

  xdg.configFile."hypr/hyprland.conf.d".source =
    config.lib.file.mkOutOfStoreSymlink ./hypr/hyprland.conf.d;

  mine.de.idle.display = status:
    "hyprctl dispatch dpms ${if status then "on" else "off"}";

  # Polkit Agent
  services.hyprpolkitagent.enable = true;
}
