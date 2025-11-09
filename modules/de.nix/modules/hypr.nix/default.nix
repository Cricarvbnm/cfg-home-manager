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

  services = {
    # Hyprpolkit
    hyprpolkitagent.enable = true;

    # Wallpaper
    hyprpaper = {
      enable = true;
      settings =
        let wallpaper = "/storage/General/Pictures/Wallpaper/133666467_p0.png";
        in {
          preload = [ wallpaper ];
          wallpaper = [ ", ${wallpaper}" ];

          ipc = "on";
          splash = false;
        };
    };
  };
  # Lock
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/hyprlock/current.conf
    '';
  };
  xdg.configFile."hypr/hyprlock/current.conf".source =
    config.lib.file.mkOutOfStoreSymlink ./hypr/hyprlock.conf;
}
