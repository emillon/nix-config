{ pkgs }:
pkgs.opam.overrideAttrs (old: {
  version = "2.2.0~beta1";
  src = pkgs.fetchurl {
    url =
      "https://github.com/ocaml/opam/releases/download/2.2.0-beta1/opam-full-2.2.0-beta1.tar.gz";
    sha256 = "wEMV2bSxXalNkZWGkENLwba1qTjWw0fhK7LCaCDdvOk=";
  };
  patches = [ ];
  configureFlags = [ "--with-vendored-deps" ];
  postUnpack = [ ];
})
