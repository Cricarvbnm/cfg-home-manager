{ pkgs, ... }:
{
  home.packages = [ pkgs.libreoffice-qt ];
  programs.pandoc = {
    enable = true;
    defaults = {
      pdf-engine = "xelatex";
    };
  };
}
