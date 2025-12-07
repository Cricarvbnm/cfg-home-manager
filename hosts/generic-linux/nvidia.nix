{ ... }:
{
  targets.genericLinux.gpu = {
    nvidia = {
      enable = true;
      version = "580.105.08";
      sha256 = "sha256-2cboGIZy8+t03QTPpp3VhHn6HQFiyMKMjRdiV2MpNHU=";
    };
  };
  nixpkgs.config.nvidia.acceptLicense = true;
}
