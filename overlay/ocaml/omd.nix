{ pkgs }:
pkgs.ocamlPackages.omd.overrideAttrs (old: {
  version = "2.0.0~alpha4";
  src = pkgs.fetchFromGitHub {
    owner = "ocaml";
    repo = "omd";
    rev = "2.0.0.alpha4";
    hash = "sha256-5eZitDaNKSkLOsyPf5g5v9wdZZ3iVQGu8Ot4FHZZ3AI=";
  };
  propagatedBuildInputs = with pkgs.ocamlPackages; [
    dune-build-info
    uucp
    uunf
    uutf
  ];
})
