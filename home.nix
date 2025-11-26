# Home-Manager in standalone mode
# This is a home-manager module

{ ... }: {
  imports = [
    ./shared.nix
    ./pkgs.nix

    ./users/alec.nix # Personal Configuration
  ];
}
