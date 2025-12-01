{ pkgs, ... }: {
  home = {
    packages = [ pkgs.lsd ];
    shellAliases = {
      ls = "lsd";
      la = "ls -A";
      ll = "ls -l";
      l = "ls -Al";

      tree = "lsd --tree";
    };
  };
}
