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

  programs = {
    # Screen recording
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };

    # Mail
    thunderbird = {
      enable = true;

      profiles.default = {
        isDefault = true;
      };
    };
  };
}
