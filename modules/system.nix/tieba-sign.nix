{ pkgs, ... }:
{
  home.packages = [ pkgs.tieba-sign ];
  systemd.user = {
    services.tieba-sign = {
      Unit = {
        After = [ "network-online.target" ];
      };

      Service = {
        ExecStart = "${pkgs.tieba-sign}/bin/tieba-sign";
        Restart = "no";
        Type = "oneshot";
      };
    };

    timers.tieba-sign = {
      Install.WantedBy = [ "timers.target" ];
      Timer.OnCalendar = "hourly";
    };
  };
}
