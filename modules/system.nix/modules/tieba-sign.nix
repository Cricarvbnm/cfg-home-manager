{ pkgs, ... }:
let
  version = "v1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "Cricarvbnm";
    repo = "tieba-sign-go";
    tag = version;
    sha256 = "sha256-qtI3cg5l6sv/itpq5+ANx3oxOFTlED6eug8bjQXZiz8=";
  };
  drv = pkgs.buildGoModule {
    pname = "tieba-sign";
    inherit version src;
    vendorHash = "sha256-GkyRdDnokFlWIG5UMIUhA/QDpVgLPrGm6TS9CNXlHJI=";
  };
in {
  home.packages = [ drv ];
  systemd.user = {
    services.tieba-sign = {
      Unit = { After = [ "network-online.target" ]; };

      Service = {
        ExecStart = "${drv}/bin/tieba-sign";
        Restart = "no";
        Type = "oneshot";
      };
    };

    timers.tieba-sign = {
      Install.WantedBy = [ "timers.target" ];
      Timer.OnCalendar = "*:00:00";
    };
  };
}
