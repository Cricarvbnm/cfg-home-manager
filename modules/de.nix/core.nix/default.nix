{ ... }:
{
  imports = [
    ./niri.nix

    ./modules/idle/hypridle.nix
    ./modules/clipboard/copyq.nix
  ];

  programs.cava.enable = true;
  mine.de.idle = {
    displays.niri = on: "niri msg action power-${if on then "on" else "off"}-monitors";
    lock = "qs -c noctalia-shell ipc call lockScreen lock";
  };
}
