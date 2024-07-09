{ pkgs }:
pkgs.ocamlPackages.buildDunePackage {
  pname = "opam-0install-cudf";
  version = "0.4.3";
  src = pkgs.fetchurl {
    url = "https://github.com/ocaml-opam/opam-0install-solver/releases/download/v0.4.3/opam-0install-cudf-0.4.3.tbz";
    hash = "sha256-1Z4Ovd2lj3mP9Q6+ITyDiTtafDQMOMIJUFdNZ+YUW4o=";
  };
  propagatedBuildInputs = with pkgs.ocamlPackages; [ zeroinstall-solver cudf ];
}
