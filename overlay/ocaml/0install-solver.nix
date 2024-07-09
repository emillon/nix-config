{ fetchurl, buildDunePackage }:
buildDunePackage {
  pname = "0install-solver";
  version = "2.18";
  src = fetchurl {
    url = "https://github.com/0install/0install/releases/download/v2.18/0install-2.18.tbz";
    hash = "sha256-ZIxLMYwaJt/LRAZcImq4ynI3lZJK2Ao785rhzg6ZIMM=";
  };
}
