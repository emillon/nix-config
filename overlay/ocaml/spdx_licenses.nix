{ pkgs }:
pkgs.ocamlPackages.buildDunePackage {
  pname = "spdx_licenses";
  version = "1.2.0";
  src = pkgs.fetchurl {
    url = "https://github.com/kit-ty-kate/spdx_licenses/releases/download/v1.2.0/spdx_licenses-1.2.0.tar.gz";
    hash = "sha256-9ViB7PRDz70w3RJczapgn2tJx9wTWgAbdzos6r3J2r4=";
  };
}
