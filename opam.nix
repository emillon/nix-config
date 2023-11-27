{ pkgs }:
pkgs.opam.overrideAttrs (old: {
  version = "2.2.0~alpha3";
  src = pkgs.fetchurl {
    url =
      "https://github.com/ocaml/opam/releases/download/2.2.0-alpha3/opam-full-2.2.0-alpha3.tar.gz";
    sha256 = "uvFgLRV7+QrMpPFcTMOMGKTu4IBQ+0vX8IfiVgpL1rI=";
  };
  patches = [ ];
  configureFlags = [ "--with-vendored-deps" ];
  postUnpack = [ ];
})
