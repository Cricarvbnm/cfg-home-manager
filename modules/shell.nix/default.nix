{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkAfter;
in
{
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
    # Core Utilities - basic CLI helpers
    fd # file finder
    fzf # fuzzy finder
    duf # disk usage viewer
    dust # directory size analyzer
    gdu # console disk-usage analyzer

    # Archive Tools - compression / extraction
    unzip # unzip utility
    zip # zip utility
    p7zip # 7z archive tool
    rar # RAR archive tool
    xz # XZ compression tool
    zstd # Zstandard compression tool

    # Miscellaneous Utilities - assorted system and network tools
    fastfetch # system info fetcher
    file # file type identification
    htop # interactive process viewer
    iftop # network traffic monitor
    nethogs # per-process network bandwidth monitor
    lsof # list open files and their processes
    aria2 # multi-protocol download utility
    curl # data transfer tool
    ffmpeg-headless # FFmpeg (headless) for audio/video processing
    tldr # Simple manual
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
  };
}
