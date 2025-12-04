# ------------------------------------------------------------------------------
# Output: Apps (Deployment Scripts)
# ------------------------------------------------------------------------------

{ flake-utils, nixpkgs, ... }:
let
  inherit (import ../../info.nix) system entryFile attrPath username;

  # This allows you to run: nix run .#deploy
  apps = flake-utils.lib.eachSystem flake-utils.lib.allSystems (sys:
    let
      pkgsForSys = import nixpkgs { inherit system; };

      # Script wrapping the nh command
      deployScript = pkgsForSys.writeShellScriptBin "deploy" ''
        echo "⚙️ Deploying Home Manager configuration for ${username}..."
        ${pkgsForSys.nh}/bin/nh home switch \
          -f ${entryFile} \
          ${attrPath} \
          "$@"
      '';
    in rec {
      # Default app (nix run)
      default = deploy;
      # Named app (nix run .#deploy)
      deploy = {
        type = "app";
        program = "${deployScript}/bin/deploy";
      };
    });

in apps
