{ pkgs, buildDunePackage }:
let
  fetchurl = pkgs.fetchurl;
  version = "2.2.0";
  dontConfigure = true;
  src = pkgs.fetchFromGitHub ({
    owner = "ocaml";
    repo = "opam";
    rev = version;
    hash = "sha256-ogBSommjV3qM/11CmJSKOpiM7kWTUVtYdzgJ3MqdPLk=";
  });
  opam_solver = buildDunePackage {
    pname = "opam-solver";
    inherit dontConfigure src version;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ opam-0install-cudf re dose3 opam_format ];
  };
  opam_core = buildDunePackage {
    pname = "opam-core";
    inherit dontConfigure src version;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ uutf swhid_core jsonm sha ocamlgraph re ];
  };
  opam_format = buildDunePackage {
    pname = "opam-format";
    inherit dontConfigure src version;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ re opam-file-format opam_core ];
  };
  opam_repository = buildDunePackage {
    pname = "opam-repository";
    inherit dontConfigure src version;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ opam_format ];
  };
  opam_state = buildDunePackage {
    pname = "opam-state";
    inherit dontConfigure src version;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ spdx_licenses re opam_repository ];
  };
  opam_client = buildDunePackage {
    pname = "opam-client";
    inherit dontConfigure src version;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ cmdliner base64 re opam_repository opam_solver opam_state ];
  };
in
buildDunePackage {
  pname = "opam";
  inherit dontConfigure src version;
  buildInputs = with pkgs.ocamlPackages; [ opam_client ];
}
