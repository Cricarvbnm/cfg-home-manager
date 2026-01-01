{ config, pkgs, ... }:
{
  programs = {
    # Interactive shell
    fish = {
      enable = true;

      loginShellInit = ''
        # Source /etc/profile if it exists
        exec bash -c "test -e /etc/profile && source /etc/profile; exec fish"
      '';

      interactiveShellInit = ''
        # Use vi keybindings
        fish_vi_key_bindings
      '';

      shellInit = ''
        # Ensure SHELL variable is set to fish
        set -gx SHELL "${config.programs.fish.package}/bin/fish"
      '';

      plugins = with pkgs.fishPlugins; [
        {
          name = "bass";
          src = bass.src;
        }
        {
          name = "done";
          src = done.src;
        }
        {
          name = "autopair";
          src = autopair.src;
        }
      ];
    };

    # Login shell
    bash = {
      enable = true;

      initExtra = ''
        # Launch interactive shell
        if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} && ''${SHLVL} == 1 ]]
        then
          shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""
          exec "${config.programs.fish.package}/bin/fish" $LOGIN_OPTION
        fi
      '';
    };
  };

  home.packages = with pkgs; [
    jq # Needed by fish plugin 'done'
  ];
}
