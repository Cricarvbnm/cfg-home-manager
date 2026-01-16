{ ... }:
{
  imports = [
    ./toolkits.nix
    ./common.nix
    ./core.nix
  ];

  xdg.autostart.enable = true;
}
