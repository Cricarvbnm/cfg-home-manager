{ ... }:
{
  imports = [
    ./niri.nix

    ../modules/bar/waybar.nix
    ../modules/clipboard/copyq.nix
    ../modules/idle/hypridle.nix
    ../modules/lock/hyprlock.nix
    ../modules/logout/wlogout.nix
    ../modules/menu/fuzzel.nix
    ../modules/notification/swaync.nix
    ../modules/wallpaper/hyprpaper.nix
  ];
}
