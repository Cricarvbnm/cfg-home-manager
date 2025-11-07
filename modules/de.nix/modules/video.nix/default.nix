{ config, ... }: {
  programs.mpv = { enable = true; };
  xdg.configFile."mpv".source = config.lib.file.mkOutOfStoreSymlink ./mpv;
}
