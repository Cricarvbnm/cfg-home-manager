{ ... }: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Sarasa Fixed SC" "Symbols Nerd Font" ];
      sansSerif = [ "Noto Sans CJK SC" "Noto Sans CJK TC" ];
      serif = [ "Noto Serif CJK SC" "Noto Serif CJK TC" ];
    };
  };
}
