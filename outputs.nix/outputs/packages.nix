# ------------------------------------------------------------------------------
# Output: Packages (custom)
# ------------------------------------------------------------------------------

{ flake-utils, nixpkgs, ... }:
let
  inherit (builtins)
    filter match readDir attrNames listToAttrs mapAttrs replaceStrings;

  inherit (import ../../info.nix) system;
  pkgs = import nixpkgs { inherit system; };

  # 1. Scan the ./pkgs directory
  pkgsDir = ../../pkgs;
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
  packages = flake-utils.lib.eachSystem flake-utils.lib.allSystems
    (_: mapAttrs (_: path: pkgs.callPackage path { }) packagePaths);

in packages
