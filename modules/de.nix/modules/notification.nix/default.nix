{ ... }: {
  services.swaync.enable = true;
  xdg.configFile = {
    "swaync/style.css".source = ./swaync/.config/swaync/style.css;
    "swaync/styles".source = ./swaync/.config/swaync/styles;
  };
}
