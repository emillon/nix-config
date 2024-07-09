{ pkgs }:
let
  fetchurl = pkgs.fetchurl;
  version = "2.2.0";
  opam_src = pkgs.fetchFromGitHub ({
    owner = "ocaml";
    repo = "opam";
    rev = version;
    hash = "sha256-ogBSommjV3qM/11CmJSKOpiM7kWTUVtYdzgJ3MqdPLk=";
  });
  swhid_core = pkgs.ocamlPackages.buildDunePackage {
    pname = "swhid_core";
    version = "0.1";
    src = pkgs.fetchFromGitHub {
      owner = "ocamlpro";
      repo = "swhid_core";
      rev = "0.1";
      hash = "sha256-uLnVbptCvmBeNbOjGjyAWAKgzkKLDTYVFY6SNH2zf0A=";
    };
  };
  zeroinstall-solver = pkgs.ocamlPackages.buildDunePackage {
    pname = "0install-solver";
    version = "2.18";
    src = fetchurl {
      url = "https://github.com/0install/0install/releases/download/v2.18/0install-2.18.tbz";
      hash = "sha256-ZIxLMYwaJt/LRAZcImq4ynI3lZJK2Ao785rhzg6ZIMM=";
    };
  };
  opam-0install-cudf = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-0install-cudf";
    version = "0.4.3";
    src = fetchurl {
      url = "https://github.com/ocaml-opam/opam-0install-solver/releases/download/v0.4.3/opam-0install-cudf-0.4.3.tbz";
      hash = "sha256-1Z4Ovd2lj3mP9Q6+ITyDiTtafDQMOMIJUFdNZ+YUW4o=";
    };
    propagatedBuildInputs = [ zeroinstall-solver pkgs.ocamlPackages.cudf ];
  };
  spdx_licenses = pkgs.ocamlPackages.buildDunePackage {
    pname = "spdx_licenses";
    version = "1.2.0";
    src = fetchurl {
      url = "https://github.com/kit-ty-kate/spdx_licenses/releases/download/v1.2.0/spdx_licenses-1.2.0.tar.gz";
      hash = "sha256-9ViB7PRDz70w3RJczapgn2tJx9wTWgAbdzos6r3J2r4=";
    };
  };
  opam_solver = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-solver";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ opam-0install-cudf re dose3 opam_format ];
  };
  opam_core = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-core";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ uutf swhid_core jsonm sha ocamlgraph re ];
  };
  opam_format = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-format";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ re opam-file-format opam_core ];
  };
  opam_repository = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-repository";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ opam_format ];
  };
  opam_state = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-state";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ spdx_licenses re opam_repository ];
  };
  opam_client = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam-client";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    propagatedBuildInputs = with pkgs.ocamlPackages; [ cmdliner base64 re opam_repository opam_solver opam_state ];
  };
  opam = pkgs.ocamlPackages.buildDunePackage {
    pname = "opam";
    dontConfigure = true;
    inherit version;
    src = opam_src;
    buildInputs = with pkgs.ocamlPackages; [ opam_client ];
  };
in
opam
