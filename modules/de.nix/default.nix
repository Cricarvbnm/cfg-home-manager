{ pkgs, ... }: {
  imports = [
    # ./hypr.nix
    ./niri.nix

    ./wallpaper.nix
    ./torrent.nix
    ./idle.nix
    ./terminal.nix
    ./video.nix
    ./dev.nix
    ./browser.nix
    ./toolkits.nix
    ./office.nix
  ];

  xdg.autostart.enable = true;
  home.packages = with pkgs; [ loupe baobab bleachbit qq wechat ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
