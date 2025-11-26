# This is a nixos module and home-manager module

{ inputs, ... }: {
  nixpkgs.overlays = [
    # Include all from ./pkgs
    (self: super:
      (let
        inherit (builtins)
          readDir attrNames listToAttrs mapAttrs replaceStrings;

        files = readDir ./pkgs;
        filenames = attrNames files;
        nameFileSet = listToAttrs (map (v: {
          name = replaceStrings [ ".nix" ] [ "" ] v;
          value = ./pkgs/${v};
        }) filenames);

      in mapAttrs (k: v: super.callPackage v { }) nameFileSet))

    (self: super: { inherit (inputs.nixpkgs-stable) ffmpeg-normalize; })
  ];
}
