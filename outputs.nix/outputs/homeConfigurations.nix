# ------------------------------------------------------------------------------
# Output: Home Manager Configuration
# ------------------------------------------------------------------------------

{ flake-utils, unflake, home-manager, nixpkgs, ... }@inputs:

let
  inherit (builtins) mapAttrs;

  inherit (import ../../info.nix) username system;

  # --------------------------------------------------------------------------
  # Nixpkgs Instantiation
  # --------------------------------------------------------------------------

  pkgs = import nixpkgs {
    inherit system;
    # Add an overlay to make custom packages available inside `pkgs`
    overlays = [
      (_: _:
        mapAttrs (_: value: value.${system}) (import ./packages.nix inputs))
    ];
  };

  # --------------------------------------------------------------------------
  # Home Configuration
  # --------------------------------------------------------------------------

  homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    # Pass flake inputs to all modules
    extraSpecialArgs = { inherit inputs; };

    modules = [
      # Core settings
      {
        home = {
          # Install 'nh' (CLI helper) and the 'unflake' wrapper tool
          packages = [ pkgs.nh unflake.packages.${system}.default ];

          # Environment variables required for 'nh' to locate this config
          sessionVariables = {
            NH_FILE = ./home-entry.nix;
            NH_ATTRP = "homeConfigurations.${username}";
          };
        };

        nix.settings.experimental-features = [ "flakes" ];
      }

      ../../users/${username}.nix # user-specific configuration
      ../../home.nix # generic home configuration
    ];
  };

in homeConfigurations
