{ fetchFromGitHub, python3Packages }:
let
  pname = "ytdl-nfo";
  version = "0.3.0";
in
python3Packages.buildPythonApplication {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "owdevel";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JVavTteRHdKGx+yZeM8v0MnlYw2RiQcrLswh0N4WNW0=";
  };
  pyproject = true;
  build-system = [ python3Packages.poetry-core ];
  dependencies = with python3Packages; [
    pyyaml
    setuptools
  ];
}
