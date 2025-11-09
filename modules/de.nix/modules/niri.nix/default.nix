{ config, ... }: {
  xdg.configFile.niri.source = config.lib.file.mkOutOfStoreSymlink ./niri;
}
