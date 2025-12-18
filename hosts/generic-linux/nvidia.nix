{ ... }:
{
  targets.genericLinux.gpu = {
    nvidia = {
      enable = true;
      version = "580.119.02";

      # nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/@VERSION@/NVIDIA-Linux-x86_64-@VERSION@.run
      sha256 = "sha256-gCD139PuiK7no4mQ0MPSr+VHUemhcLqerdfqZwE47Nc=";
    };
  };
  nixpkgs.config.nvidia.acceptLicense = true;
}
