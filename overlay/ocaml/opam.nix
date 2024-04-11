{ pkgs }:
pkgs.opam.overrideAttrs (old: {
  version = "2.2.0~beta2";
  src = pkgs.fetchurl {
    url =
      "https://github.com/ocaml/opam/releases/download/2.2.0-beta2/opam-full-2.2.0-beta2.tar.gz";
    sha256 = "RtVAAy70kKm+G7PmasUgY7LXAsV/d/HVn7dOosnMiZo=";
  };
  patches = [ ];
  configureFlags = [ "--with-vendored-deps" ];
  postConfigure = if pkgs.stdenv.isDarwin then
    "echo '( -noautolink -cclib -lunix -cclib -lmccs_stubs -cclib -lmccs_glpk_stubs -cclib -lsha_stubs -cclib -lc++ -ccopt -lc++abi )' > src/client/linking.sexp"
  else
    [ ];
  postUnpack = [ ];
})
