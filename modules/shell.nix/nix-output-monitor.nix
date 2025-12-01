{ pkgs, ... }: {
  home = {
    packages = [ pkgs.nix-output-monitor ];
    shellAliases = {
      hms = "home-manager switch |& nom";
      hmb = "home-manager build |& nom";
    };
  };
}
