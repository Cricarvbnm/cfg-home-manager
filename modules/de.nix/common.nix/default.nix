{ pkgs, ... }:
{
  imports = [
    ./dev.nix
    ./terminal.nix
    ./video.nix
    ./browser.nix
    ./office.nix
    ./torrent.nix
    ./system-management.nix
    ./communication.nix
  ];

  home.packages = with pkgs; [
    loupe # Picture viewer
    wl-clipboard
  ];

  # Screen recording
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
