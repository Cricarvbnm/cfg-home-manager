{ config, lib, pkgs, ... }:
let inherit (lib) mkAfter;
in {
  imports = [
    ./coreutils.nix
    ./rsync.nix
    ./nvim.nix
    ./starship.nix
    ./git.nix
    ./dev.nix
    ./nix-output-monitor.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    fd # finder
    fzf # finder
    duf # df
    dust # du
    gdu # du with console

    fastfetch
    file
    htop
    iftop
    nethogs
    lsof
    aria2
    curl
    ffmpeg-headless
  ];

  programs = {
    ripgrep-all.enable = true;

    zsh = {
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
        highlighters = [ "main" "brackets" ];
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "sudo" ];
      };
    };
  };
}
