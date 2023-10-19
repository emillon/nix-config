{ pkgs }:
pkgs.ocamlPackages.buildDunePackage {
  pname = "get-activity";
  version = "n/a";
  duneVersion = "3";
  src = pkgs.fetchFromGitHub {
    owner = "patricoferris";
    repo = "get-activity";
    rev = "a384724b4630031e07c2f2962f44bf76378685d8";
    hash = "sha256-oRzBdgS7aNrlT+9OQ3Jv/uYPmBTAgRwJr1E3hpgtdoY=";
  };
  propagatedBuildInputs = with pkgs.ocamlPackages; [
    astring
    cohttp-lwt
    fmt
    yojson
  ];
}
