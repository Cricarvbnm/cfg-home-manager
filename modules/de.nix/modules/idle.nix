{ config, lib, ... }:
let
  lock = config.mine.de.idle.lock;
  display = config.mine.de.idle.display;
in {
  options.mine.de.idle = (let inherit (lib) mkOption types literalMD;
  in {
    lock = mkOption {
      description = "Lock command";
      type = types.str;
    };
    display = mkOption {
      description = literalMD ''
        Receive a bool value, return a display switch command.
        `true` for on, `false` for off.
      '';
    };
  });

  config = {
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
  };
}
