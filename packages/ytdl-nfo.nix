{ pkgs }:
let
  pname = "ytdl-nfo";
  version = "0.3.0";
in
pkgs.python3Packages.buildPythonApplication {
  inherit pname version;
  src = pkgs.fetchFromGitHub {
    owner = "owdevel";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JVavTteRHdKGx+yZeM8v0MnlYw2RiQcrLswh0N4WNW0=";
  };
  pyproject = true;
  build-system = [ pkgs.python3Packages.poetry-core ];
  dependencies = with pkgs.python3Packages; [
    pyyaml
    setuptools
  ];
}
