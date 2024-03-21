{ pkgs }:
let version = "1.0.1";
in pkgs.ocamlPackages.buildDunePackage {
  pname = "get-activity-lib";
  version = version;
  duneVersion = "3";
  src = pkgs.fetchFromGitHub {
    owner = "tarides";
    repo = "get-activity";
    rev = version;
    hash = "sha256-H2LE3ccxfb0f/JH08Ra3+yQTNzSa0EIWllkJ6je913U=";
  };
  propagatedBuildInputs = with pkgs.ocamlPackages; [
    astring
    curly
    fmt
    ppx_yojson_conv
  ];
}
