{ pkgs, ... }: {
  home = {
    packages = [ pkgs.rsync ];
    shellAliases = {
      cpr =
        "rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1";
      mvr = "cpr --remove-source-files";
    };
  };
}
