{ config, ... }: {
  programs.kitty = {
    enable = true;

    enableGitIntegration = true;
    # themeFile = "Catppuccin-Macchiato";
    extraConfig = ''
      include kitty-custom.conf
    '';
  };

  xdg.configFile = {
    "kitty/current-theme.conf".source =
      ./kitty/.config/kitty/current-theme.conf;
    "kitty/kitty-custom.conf".source =
      config.lib.file.mkOutOfStoreSymlink ./kitty/.config/kitty/kitty.conf;
  };
}
