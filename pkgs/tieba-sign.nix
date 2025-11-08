{ buildGoModule, fetchFromGitHub, ... }:
buildGoModule rec {
  pname = "tieba-sign";
  version = "v1.0.0";

  src = fetchFromGitHub {
    owner = "Cricarvbnm";
    repo = "tieba-sign-go";
    tag = version;
    sha256 = "sha256-qtI3cg5l6sv/itpq5+ANx3oxOFTlED6eug8bjQXZiz8=";
  };

  vendorHash = "sha256-GkyRdDnokFlWIG5UMIUhA/QDpVgLPrGm6TS9CNXlHJI=";
}
