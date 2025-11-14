{ ... }: {
  services.hyprpaper = {
    enable = true;
    settings =
      let wallpaper = "/storage/General/Pictures/Wallpaper/133666467_p0.png";
      in {
        preload = [ wallpaper ];
        wallpaper = [ ", ${wallpaper}" ];

        ipc = "on";
        splash = false;
      };
  };
}
