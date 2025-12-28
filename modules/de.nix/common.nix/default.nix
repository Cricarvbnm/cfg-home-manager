{ pkgs, ... }:
{
  imports = [
    ./dev.nix
    ./terminal.nix
    ./video.nix
    ./browser.nix
    ./office.nix
    ./torrent.nix
    ./system-monitors.nix
    ./communication.nix
  ];

  home.packages = with pkgs; [
    loupe
    baobab
    bleachbit
    wl-clipboard
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
