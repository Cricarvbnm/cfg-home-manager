{ ... }:
let inherit (import ./compat.nix) inputs;
in {
  _module.args = { inherit inputs; };
  nix.channels = inputs;
}
