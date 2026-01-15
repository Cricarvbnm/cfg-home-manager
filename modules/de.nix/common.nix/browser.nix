{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "zh-CN" ];
  };

  home.packages = with pkgs; [
    (microsoft-edge.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })
  ];
}
