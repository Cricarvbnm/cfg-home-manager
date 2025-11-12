{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkOption types literalMD mapAttrs mapAttrsToList concatStringsSep toLower;
  cfg = config.mine.de.idle;

  scriptTemplate = ./display-toggle.bash;

  # 1. Process compositor commands: escape and split into on/off sets
  processCommands = on:
    mapAttrs (compositor: toggleFn: {
      compositorEscaped = toLower compositor;
      commandEscaped = (toggleFn on);
    }) cfg.displays;

  # 2. Generate shell array definitions (to inject into the template)
  generateArrayDefinitions = on:
    let
      commandSet = processCommands on;
      arrayName = if on then "SUPPORTED_ON" else "SUPPORTED_OFF";
    in concatStringsSep "\n" (mapAttrsToList (compositor: data:
      ''${arrayName}["${data.compositorEscaped}"]="${data.commandEscaped}"'')
      commandSet);

  # 3. Inject dynamic content into the external script template
  # Replace placeholders with generated array definitions
  populatedScript = pkgs.replaceVars scriptTemplate {
    SUPPORTED_ON_DEFINITIONS = generateArrayDefinitions true;
    SUPPORTED_OFF_DEFINITIONS = generateArrayDefinitions false;
  };

  # 4. Package the populated script as a system application
  displayToggleScript = pkgs.writeShellApplication {
    name = "display-toggle";
    text = builtins.readFile populatedScript;
  };

  # Script installation path (globally accessible)
  scriptPath = "${displayToggleScript}/bin/display-toggle";
in {
  options.mine.de.idle = {
    # Preserve original lock command option
    lock = mkOption {
      description = "Desktop lock command";
      type = types.str;
    };

    # New multi-compositor display toggle configuration
    displays = mkOption {
      description = literalMD ''
        Multi-compositor display toggle command configuration set (Wayland-only):
        - Key: Compositor identifier (must match XDG_CURRENT_DESKTOP value, case-insensitive)
          Example values: "hyprland", "sway", "gnome", "kde", "labwc"
        - Value: Function (accepts boolean parameter)
          - `true`: Returns display enable command
          - `false`: Returns display disable command

        Detection Logic:
        1. Validates Wayland session via XDG_SESSION_TYPE=wayland
        2. Reads XDG_CURRENT_DESKTOP (standard Wayland compositor identifier)
        3. Normalizes to lowercase for case-insensitive matching
        4. Matches against registered compositor keys (also case-insensitive)

        Note: XDG_CURRENT_DESKTOP typically uses values like:
        - Hyprland: "Hyprland"
        - Sway: "sway" or "Sway"
        - GNOME: "GNOME"
        - KDE Plasma: "KDE"
        - LabWC: "LabWC"
      '';
      type =
        types.attrsOf (types.functionTo types.str); # Function type: bool → str
      default = { }; # No default configuration
    };
  };

  config = {
    # Configure hypridle: use the generated dynamic script
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "${scriptPath} off"; # Turn off display after sleep
          ignore_dbus_inhibit = false;
          lock_cmd = cfg.lock;
        };

        listener = [
          {
            timeout = 600;
            on-timeout = cfg.lock;
          }
          {
            timeout = 605;
            on-timeout = "${scriptPath} off";
            on-resume = "${scriptPath} on";
          }
        ];
      };
    };
  };
}
