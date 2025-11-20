{ config, lib, pkgs, ... }:
let inherit (lib) mkAfter;
in {
  imports = [ ./nvim.nix ./starship.nix ];

  home.packages = with pkgs; [
    bat
    file
    htop
    iftop
    nethogs
    lsof
    tree
    aria2
    curl
    nix-output-monitor
    ffmpeg-headless
  ];

  programs = {
    zsh = {
      enable = true;

      dotDir = ".config/zsh";
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
        highlighters = [ "main" "brackets" ];
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "sudo" ];
      };
    };

    zoxide.enable = true;
  };

  home.shellAliases = {
    nd = "nix profile diff-closures --profile /nix/var/nix/profiles/system";
    npi = "nix path-info -r /nix/var/nix/profiles/system";
  };
}
