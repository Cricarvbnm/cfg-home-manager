{ ... }: {
  services.swaync.enable = true;
  xdg.configFile = {
    "swaync/style.css".source = ./swaync/style.css;
    "swaync/styles".source = ./swaync/styles;
  };
}
