{ pkgs }:
let
  version = "0.3.0";
  okra-lib = pkgs.ocamlPackages.buildDunePackage {
    pname = "okra-lib";
    version = version;
    src = pkgs.fetchFromGitHub {
      owner = "tarides";
      repo = "okra";
      rev = version;
      hash = "sha256-TUKjDPeO640a+2OPo4v04OYf5bI35UtmYzMR4hIY/R4=";
    };
    duneVersion = "3";
    propagatedBuildInputs = with pkgs.ocamlPackages; [
      calendar
      csv
      get-activity-lib
      gitlab
      omd
    ];
  };
in {
  okra-bin = pkgs.ocamlPackages.buildDunePackage {
    meta.mainProgram = "okra";
    duneVersion = "3";
    inherit (okra-lib) version src;
    pname = "okra";
    propagatedBuildInputs = with pkgs.ocamlPackages; [
      cmdliner
      cohttp-lwt-unix
      dune-build-info
      okra-lib
      ppx_deriving_yaml
      xdg
    ];
  };
}
