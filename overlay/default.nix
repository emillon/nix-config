final: prev:
let
  callPackage = prev.callPackage;
in
{
  ocamlPackages = prev.ocamlPackages // {
    get-activity-lib = callPackage ./ocaml/get-activity.nix { };
    gitlab = callPackage ./ocaml/gitlab.nix { };
    okra = callPackage ./ocaml/okra.nix { };
  };
}
