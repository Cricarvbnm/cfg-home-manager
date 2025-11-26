# Home-Manager shares
# This is a home-manager module

{ ... }: {
  imports = [ ./modules/shell.nix ./modules/system.nix ];

  home.stateVersion = "25.05";
}
