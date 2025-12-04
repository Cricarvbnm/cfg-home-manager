# Home-Manager as a nixos module
# This is a nixos module

{ pkgs, ... }:
let inherit (import ./info.nix) username;
in {
  imports = [ <home-manager/nixos> ];

  nixpkgs.overlays = [
    (let
      inherit (builtins)
        filter match readDir attrNames listToAttrs mapAttrs replaceStrings;

      files = readDir ./pkgs;
      filenames = attrNames files;
      isNixFile = filename: (match ".+.nix$" filename) != null;
      nixFiles = filter isNixFile filenames;

      pairPackageNameAndNixFile = v: {
        name = replaceStrings [ ".nix" ] [ "" ] v;
        value = ./pkgs/${v};
      };
      nameFileSet = listToAttrs (map pairPackageNameAndNixFile nixFiles);

      nameDerivationSet = mapAttrs (k: v: pkgs.callPackage v { }) nameFileSet;
    in self: super: nameDerivationSet)
  ];

  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [ ./shared.nix ];

    users = {
      root = { };
      alec = import ./users/${username}.nix { inherit pkgs; };
    };
  };
}
