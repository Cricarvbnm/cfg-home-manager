{ pkgs, ... }: {
  imports = [
    ./modules/hypr.nix

    ./modules/torrent.nix
    ./modules/terminal.nix
    ./modules/video.nix
    ./modules/dev.nix
    ./modules/browser.nix
    ./modules/toolkits.nix
    ./modules/office.nix
  ];

  home.packages = with pkgs; [ loupe ];
  xdg.autostart.enable = true;
}
