{ pkgs, inputs, ... }: {
  imports = [ <home-manager/nixos> ];

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

  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [
      { home.stateVersion = "25.05"; }
      ./modules/system.nix
      ./modules/shell.nix
    ];

    users = {
      root = { };

      alec = {
        imports = [ ./modules/system.nix/tieba-sign.nix ./modules/de.nix ];

        home = {
          file.".icon".source =
            "/storage/General/Pictures/Heads/00028-2425649580-high resolution.png";
          packages = with pkgs; [ save-music ];
        };
      };
    };
  };
}
