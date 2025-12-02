{ pkgs, ... }: {
  imports = [ ./toolkits.nix ./common.nix ./cores/noctalia.nix ];

  xdg.autostart.enable = true;
  home.packages = with pkgs; [ loupe baobab bleachbit qq wechat wl-clipboard ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
