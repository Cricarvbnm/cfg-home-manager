{ config, inputs, ... }: {
  imports = [
    ./niri.nix

    ../modules/idle/hypridle.nix
    ../modules/clipboard/copyq.nix
    ../modules/polkit/hyprpolkitagent.nix

    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile.noctalia.source =
    config.lib.file.mkOutOfStoreSymlink ./noctalia;

  programs.cava.enable = true;
  mine.de.idle = {
    displays.niri = on:
      "niri msg action power-${if on then "on" else "off"}-monitors";
    lock = "hyprlock";
  };
}
