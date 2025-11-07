{ ... }: {
  imports = [ <home-manager/nixos> ];

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
        imports =
          [ ./modules/system.nix/modules/tieba-sign.nix ./modules/de.nix ];

        home.file.".icon".source =
          "/storage/General/Pictures/Heads/00028-2425649580-high resolution.png";
      };
    };
  };
}
