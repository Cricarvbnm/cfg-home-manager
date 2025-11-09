{ pkgs, ... }:
let
  lock = "${pkgs.hyprlock}/bin/hyprlock";
  display = status: "hyprctl dispatch dpms ${if status then "on" else "off"}";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = display false;
        ignore_dbus_inhibit = false;
        lock_cmd = lock;
      };

      listener = [
        {
          timeout = 600;
          on-timeout = lock;
        }
        {
          timeout = 605;
          on-timeout = display false;
          on-resume = display true;
        }
      ];
    };
  };
}
