{ fetchFromGitHub, buildDunePackage }:
let
  pname = "swhid_core";
  version = "0.1";
in
buildDunePackage {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "ocamlpro";
    repo = pname;
    rev = version;
    hash = "sha256-uLnVbptCvmBeNbOjGjyAWAKgzkKLDTYVFY6SNH2zf0A=";
  };
}
