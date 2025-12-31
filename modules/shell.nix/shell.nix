{ config, lib, ... }:
let
  inherit (lib) mkAfter;
in
{
  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";
    initContent = mkAfter "bindkey -v";

    history = {
      path = "${config.xdg.stateHome}/zsh/history";
      expireDuplicatesFirst = true;
      extended = true;
      findNoDups = true;
      share = false;
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "sudo" ];
    };
  };
}
