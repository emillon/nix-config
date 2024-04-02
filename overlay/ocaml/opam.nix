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
  postConfigure = if pkgs.system == "aarch64-darwin" then
    "echo '( -noautolink -cclib -lunix -cclib -lmccs_stubs -cclib -lmccs_glpk_stubs -cclib -lsha_stubs -cclib -lc++ -ccopt -lc++abi )' > src/client/linking.sexp"
  else
    [ ];
  postUnpack = [ ];
})
