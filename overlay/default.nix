final: prev:
let
  pkgs = prev;
  callPackage = pkgs.callPackage;
in
{
  ocamlPackages = prev.ocamlPackages // {
    get-activity-lib = callPackage ./ocaml/get-activity.nix { };
    gitlab = callPackage ./ocaml/gitlab.nix { };
    omd = callPackage ./ocaml/omd.nix { inherit pkgs; };
    okra = callPackage ./ocaml/okra.nix { };
  };
  opam = callPackage ./ocaml/opam.nix { inherit pkgs; };
}
