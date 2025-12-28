{ ... }:
{
  imports = [
    ./toolkits.nix
    ./common.nix
    ./cores/noctalia.nix
  ];

  xdg.autostart.enable = true;
}
