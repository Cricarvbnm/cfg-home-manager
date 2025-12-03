{
  inputs = {
    self.submodules = true;

    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.url = "nixpkgs";
    };
  };

  outputs = { ... }: { };
}
