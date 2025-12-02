{ pkgs, ... }: {
  imports = [ ./vscode.nix ];

  home.packages = with pkgs; [ jetbrains.idea-ultimate ];
}
