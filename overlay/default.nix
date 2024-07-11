final: prev:
let
  pkgs = prev;
  callPackage = pkgs.callPackage;
  buildDunePackage = pkgs.ocamlPackages.buildDunePackage;
in
{
  ocamlPackages = prev.ocamlPackages // {
    get-activity-lib = callPackage ./ocaml/get-activity.nix { };
    gitlab = callPackage ./ocaml/gitlab.nix { };
    okra = callPackage ./ocaml/okra.nix { };
  };
  opam = prev.callPackage ./ocaml/opam.nix { inherit buildDunePackage; };
}
