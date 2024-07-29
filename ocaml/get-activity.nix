{ pkgs }:
let version = "2.0.0";
in pkgs.ocamlPackages.buildDunePackage {
  pname = "get-activity-lib";
  version = version;
  duneVersion = "3";
  src = pkgs.fetchFromGitHub {
    owner = "tarides";
    repo = "get-activity";
    rev = version;
    hash = "sha256-LrO2+X4hHFhleFomuKl9lBkAGadtlQPT7ANLk6ZrNro=";
  };
  propagatedBuildInputs = with pkgs.ocamlPackages; [
    astring
    curly
    fmt
    logs
    ppx_yojson_conv
  ];
}
