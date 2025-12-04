# ==============================================================================
# Combine All Outputs and Export Them
# ==============================================================================

inputs:
let
  inherit (builtins) readDir attrNames listToAttrs replaceStrings mapAttrs;

  outputFilenames = attrNames (readDir ./outputs);
  nameFileSet = listToAttrs (map (filename: {
    name = replaceStrings [ ".nix" ] [ "" ] filename;
    value = ./outputs/${filename};
  }) outputFilenames);

  outputs = mapAttrs (_: file: import file inputs) nameFileSet;

in outputs
