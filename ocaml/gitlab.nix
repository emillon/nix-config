{ pkgs }:
pkgs.ocamlPackages.buildDunePackage {
  pname = "gitlab";
  version = "0.1.8";
  duneVersion = "3";
  src = pkgs.fetchFromGitHub {
    owner = "tmcgilchrist";
    repo = "ocaml-gitlab";
    rev = "0.1.8";
    hash = "sha256-7pUpH1SoP4eW8ild5j+Tcy+aTXq0+eSkhKUOXJ6Z30k=";
  };
  nativeBuildInputs = with pkgs.ocamlPackages; [ atdgen ];
  propagatedBuildInputs = with pkgs.ocamlPackages; [
    atdgen
    cohttp-lwt
    iso8601
    uri
  ];
}
