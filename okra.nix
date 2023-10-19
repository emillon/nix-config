{ pkgs, okra-repo }:
let
  okra-lib = pkgs.ocamlPackages.buildDunePackage {
    pname = "okra";
    version = "n/a";
    src = okra-repo;
    duneVersion = "3";
    propagatedBuildInputs = with pkgs.ocamlPackages; [
      calendar
      csv
      get-activity
      gitlab
      omd
    ];
  };
in {
  okra-bin = pkgs.ocamlPackages.buildDunePackage {
    meta.mainProgram = "okra";
    pname = "okra-bin";
    version = "n/a";
    src = okra-repo;
    duneVersion = "3";
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
