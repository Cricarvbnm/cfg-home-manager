{ config, lib, ... }:
let inherit (lib) mkAfter;
in {
  imports = [ ./nvim.nix ];

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";
    history.path = "${config.xdg.stateHome}/zsh/history";

    initContent = mkAfter "bindkey -v";
  };
}
