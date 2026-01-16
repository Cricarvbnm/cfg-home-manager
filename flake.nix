{
  description = "Alec's Home Manager Flake";

  inputs = {
    self.submodules = true;

    unflake.url = "https://codeberg.org/goldstein/unflake/archive/main.tar.gz";
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.url = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      flake-utils,
      unflake,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      # =====================================================================
      # Information about the whole configuration
      # =====================================================================

      username = "alec"; # configure for whom

      system = builtins.currentSystem or "x86_64-linux"; # configure for which system;

      # For nh.
      # `NH_FILE=${entryFile} NH_ATTRP=${attrPath} nh home switch`
      entryFile = ./home-entry.nix; # where's the file to swtich to
      attrPath = "homeConfigurations.${username}"; # the attribute to switch to

      # =====================================================================
      # Nixpkgs Instantiation
      # =====================================================================

      inherit (builtins) mapAttrs;

      pkgs = import nixpkgs {
        inherit system;
        # Add an overlay to make custom packages available inside `pkgs`
        overlays = [ (_: _: mapAttrs (_: value: value.${system}) (self.packages)) ];
      };
    in
    {
      # =====================================================================
      # Outputs
      # =====================================================================

      # =====================================================================
      # Home Manager Configuration
      # =====================================================================

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass flake inputs to all modules
        extraSpecialArgs = { inherit inputs; };

        modules = [
          # Core settings
          {
            home = {
              # Install 'nh' (CLI helper) and the 'unflake' wrapper tool
              packages = [
                pkgs.nh
                unflake.packages.${system}.default
              ];

              # Environment variables required for 'nh' to locate this config
              sessionVariables = {
                NH_FILE = entryFile;
                NH_ATTRP = attrPath;
              };
            };

            nix.settings.experimental-features = [ "flakes" ];
          }

          ./home.nix # home configuration
        ];
      };

      # =====================================================================
      # Packages (custom)
      # =====================================================================

      packages =
        let
          inherit (builtins)
            filter
            match
            readDir
            attrNames
            listToAttrs
            replaceStrings
            ;

          # 1. Scan the ./pkgs directory
          pkgsDir = ./pkgs;
          fileList = readDir pkgsDir;

          # 2. Filter for .nix files only
          isNixFile = name: (match ".+\\.nix$" name) != null;
          nixFilenames = filter isNixFile (attrNames fileList);

          # 3. Map filenames to file paths
          # Example: "tool.nix" -> { name = "tool"; value = ./pkgs/tool.nix; }
          toPackageAttribute = filename: {
            name = replaceStrings [ ".nix" ] [ "" ] filename;
            value = pkgsDir + "/${filename}";
          };

          packagePaths = listToAttrs (map toPackageAttribute nixFilenames);

          # 4. Generate the `packages` output for all systems supported by flake-utils
          # We use pkgs.callPackage to instantiate the derivations found in ./pkgs
          packages = flake-utils.lib.eachSystem flake-utils.lib.allSystems (
            _: mapAttrs (_: path: pkgs.callPackage path { }) packagePaths
          );
        in
        packages;

    };
}
