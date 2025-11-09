{ pkgs, ... }: {
  imports = [
    ./modules/hypr.nix

    ./modules/lock.nix
    ./modules/torrent.nix
    ./modules/idle.nix
    ./modules/terminal.nix
    ./modules/video.nix
    ./modules/dev.nix
    ./modules/browser.nix
    ./modules/toolkits.nix
    ./modules/office.nix
  ];

  xdg.autostart.enable = true;
  home.packages = with pkgs; [ loupe ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
