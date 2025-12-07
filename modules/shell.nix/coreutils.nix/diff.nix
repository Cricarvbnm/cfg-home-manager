{ ... }:
{
  imports = [ ../git.nix ];
  home.shellAliases.diff = "git diff --no-index";
}
