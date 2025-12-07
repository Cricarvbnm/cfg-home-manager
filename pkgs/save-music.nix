{
  stdenv,
  fetchFromGitHub,
  pkgs,
  lib,
  makeWrapper,
  ...
}:
stdenv.mkDerivation rec {
  name = "save-music";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "Cricarvbnm";
    repo = "save-music";
    tag = "v${version}";

    hash = "sha256-jCmO83ebyjhy8Rg70Jk3oMxOEr5k6lPF6yT180vjgPU=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = with pkgs; [
    curl
    kid3-cli
    ffmpeg-normalize
    ffmpeg
    bash
  ];

  installPhase = ''
    mkdir -p $out/{bin,share}

    cp $src/bin/* $out/bin/
    cp -r $src/share/* $out/share/

    for exe in $out/bin/*; do
      wrapProgram "$exe" \
        --prefix PATH : "${lib.makeBinPath buildInputs}"
    done
  '';
}
