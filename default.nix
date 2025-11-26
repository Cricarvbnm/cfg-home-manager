# Home-Manager as a nixos module
# This is a nixos module

{ pkgs, ... }: {
  imports = [ <home-manager/nixos> ./pkgs.nix ];

  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [ ./shared.nix ];

    users = {
      root = { };
      alec = import ./users/alec.nix { inherit pkgs; };
    };
  };
}
