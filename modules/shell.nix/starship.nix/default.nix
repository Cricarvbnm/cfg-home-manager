{ ... }: {
  programs.starship = { enable = true; };
  xdg.configFile."starship.toml".source = ./nerd-font-symbols.toml;
}
