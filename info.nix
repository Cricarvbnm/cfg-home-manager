# ==============================================================================
# Information about the whole configuration
# ==============================================================================

rec {
  username = "alec"; # configure for whom

  system =
    builtins.currentSystem or "x86_64-linux"; # configure for which system;

  # For nh.
  # `NH_FILE=${entryFile} NH_ATTRP=${attrPath} nh home switch`
  entryFile = ../home-entry.nix; # where's the file to swtich to
  attrPath = "homeConfigurations.${username}"; # the attribute to switch to
}
