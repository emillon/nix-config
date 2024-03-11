{ pkgs }:
let version = "0.2.0";
in pkgs.ocamlPackages.buildDunePackage {
  pname = "get-activity-lib";
  version = version;
  duneVersion = "3";
  src = pkgs.fetchFromGitHub {
    owner = "tarides";
    repo = "get-activity";
    rev = version;
    hash = "sha256-U1eD9jYUUhUQG+nt4GZi2IwpPPSj0SUu5F/s3tYrbQU=";
  };
  propagatedBuildInputs = with pkgs.ocamlPackages; [
    cohttp-lwt
    cohttp-lwt-unix
    yojson
  ];
}
