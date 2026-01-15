{
  pkgs,
  config,
  lib,
  ...
}:
let
  aliases = rec {
    cpr = "rsync --archive -hhh --partial --info=stats1,progress2 --modify-window=1";
    mvr = "${cpr} --remove-source-files";
  };
in
{
  home = {
    packages = [ pkgs.rsync ];
    shellAliases = lib.mkIf (
      !(config.programs.fish.enable && config.programs.fish.preferAbbrs)
    ) aliases;
  };

  programs.fish.shellAbbrs = lib.mkIf config.programs.fish.preferAbbrs aliases;
}
