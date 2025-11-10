{ pkgs, ... }: {
  imports = [ ./modules/vscode.nix ];

  home.packages = with pkgs; [ jetbrains.idea-ultimate ];
}
