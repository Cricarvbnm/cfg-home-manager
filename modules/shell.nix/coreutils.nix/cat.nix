{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.bat ];
    shellAliases.cat = "bat --plain";
  };
}
