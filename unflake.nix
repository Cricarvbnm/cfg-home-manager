let
  deps = rec {
    unflake_github_nix-community_home-manager = builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      rev = "6bcb2395ab9ed05616052262da526cd7c5b4b123";
    };
    unflake_github_nix-systems_default = builtins.fetchTree {
      type = "github";
      owner = "nix-systems";
      repo = "default";
      rev = "da67096a3b9bf56a91d16901293e51ba5b49a27e";
    };
    unflake_github_nixos_nixpkgs_ref_nixos-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "418468ac9527e799809c900eda37cbff999199b6";
    };
    unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable = builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      rev = "ece6e266caf1effab32eceef0403b797b4330373";
    };
    unflake_github_numtide_flake-utils = builtins.fetchTree {
      type = "github";
      owner = "numtide";
      repo = "flake-utils";
      rev = "11707dc2f618dd54ca8739b309ec4fc024de578b";
    };
    unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz = builtins.fetchTree {
      type = "tarball";
      url = "https://codeberg.org/api/v1/repos/goldstein/unflake/archive/b7cc0b421c8d60720fe40ae7a67e37359892f99a.tar.gz";
    };
  };
  universe = rec {
    unflake_github_nix-community_home-manager =
      ((import "${deps.unflake_github_nix-community_home-manager.outPath}/flake.nix").outputs {
        self = unflake_github_nix-community_home-manager;
        nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      })
      // deps.unflake_github_nix-community_home-manager
      // {
        _flake = true;
        outPath = "${deps.unflake_github_nix-community_home-manager.outPath}";
        sourceInfo = deps.unflake_github_nix-community_home-manager;
      };
    unflake_github_nix-systems_default =
      ((import "${deps.unflake_github_nix-systems_default.outPath}/flake.nix").outputs {
        self = unflake_github_nix-systems_default;
      })
      // deps.unflake_github_nix-systems_default
      // {
        _flake = true;
        outPath = "${deps.unflake_github_nix-systems_default.outPath}";
        sourceInfo = deps.unflake_github_nix-systems_default;
      };
    unflake_github_nixos_nixpkgs_ref_nixos-unstable =
      ((import "${deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable.outPath}/flake.nix").outputs {
        self = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      })
      // deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable
      // {
        _flake = true;
        outPath = "${deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable.outPath}";
        sourceInfo = deps.unflake_github_nixos_nixpkgs_ref_nixos-unstable;
      };
    unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable =
      ((import "${deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable.outPath}/flake.nix").outputs {
        self = unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
      })
      // deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable
      // {
        _flake = true;
        outPath = "${deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable.outPath}";
        sourceInfo = deps.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
      };
    unflake_github_numtide_flake-utils =
      ((import "${deps.unflake_github_numtide_flake-utils.outPath}/flake.nix").outputs {
        self = unflake_github_numtide_flake-utils;
        systems = unflake_github_nix-systems_default;
      })
      // deps.unflake_github_numtide_flake-utils
      // {
        _flake = true;
        outPath = "${deps.unflake_github_numtide_flake-utils.outPath}";
        sourceInfo = deps.unflake_github_numtide_flake-utils;
      };
    unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz =
      (
        (import "${deps.unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz.outPath}/flake.nix")
        .outputs
        {
          self = unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz;
          nixpkgs = unflake_github_nixos_nixpkgs_ref_nixos-unstable;
        }
      )
      // deps.unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz
      // {
        _flake = true;
        outPath = "${deps.unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz.outPath
        }";
        sourceInfo = deps.unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz;
      };
  };
  inputs = {
    flake-utils = universe.unflake_github_numtide_flake-utils;
    home-manager = universe.unflake_github_nix-community_home-manager;
    nixpkgs = universe.unflake_github_nixos_nixpkgs_ref_nixpkgs-unstable;
    unflake = universe.unflake_tarball_https---codeberg-org-goldstein-unflake-archive-main-tar-gz;
    self = throw "to use inputs.self, write `(import ./unflake.nix).withInputs (inputs: ...)`";
    withInputs =
      outputs:
      let
        self = outputs (inputs // { inherit self; });
      in
      self;
  };
in
inputs
