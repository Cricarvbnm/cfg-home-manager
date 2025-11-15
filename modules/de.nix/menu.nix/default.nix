{ config, ... }: {
  xdg.configFile = {
    "fuzzel/custom.ini".source =
      config.lib.file.mkOutOfStoreSymlink ./fuzzel.ini;
    "fuzzel/themes".source = ./fuzzel/themes;
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = { include = "${config.xdg.configHome}/fuzzel/custom.ini"; };
    };
  };
}
