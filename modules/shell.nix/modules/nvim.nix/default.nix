{ config, pkgs, ... }:
let
  myTexlive =
    pkgs.texliveMedium.withPackages (ps: with ps; [ ctex enumitem titling ]);
in {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      luarocks
      gnutar
      gnumake
      unzip
      gcc
      cargo
      go
      python3
      nodejs_24
      myTexlive
    ];
  };

  home.packages = [ myTexlive pkgs.zathura ];

  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink ./nvim;
  home.file.".latexmkrc".source =
    config.lib.file.mkOutOfStoreSymlink ./latexmkrc;
}
