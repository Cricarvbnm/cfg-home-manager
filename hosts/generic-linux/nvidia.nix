{ ... }:
{
  targets.genericLinux.gpu = {
    nvidia = {
      enable = true;
      version = "590.48.01";

      # nix store prefetch-file https://download.nvidia.com/XFree86/Linux-x86_64/$version/NVIDIA-Linux-x86_64-$version.run
      sha256 = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
    };
  };
  nixpkgs.config.nvidia.acceptLicense = true;
}
