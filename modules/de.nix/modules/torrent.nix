{ pkgs, ... }: {
  home.packages = with pkgs; [ qbittorrent-enhanced ];
  systemd.user = {
    services.peer-ban-helper = {
      Install.WantedBy = [ "default.target" ];
      Service =
        (let docker-compose = "${pkgs.docker-compose}/bin/docker-compose";
        in {
          ExecStart = "${docker-compose} up";
          ExecStop = "${docker-compose} up";
          WorkingDirectory = "%h/.local/opt/PeerBanHelper";
        });
      Unit.After = [ "network.target" "docker.service" ];
    };
  };
}
