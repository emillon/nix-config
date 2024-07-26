final: prev:
let
  callPackage = prev.callPackage;
in
{
  tree-sitter = prev.tree-sitter.override {
    extraGrammars = {
      cram = {
        src = prev.fetchFromGitHub {
          owner = "tjdevries";
          repo = "tree-sitter-cram";
          rev = "8cb450dfc5548b1aed2be5b3cd735c123b6fa6a8";
          hash = "sha256-CcLbZyHNKLA7NoQ3SLWEBCh5Y/dmzcSGQjs6iCrCFVY=";
        };
      };
      dune = {
        src = prev.fetchFromGitHub {
          owner = "emillon";
          repo = "tree-sitter-dune";
          rev = "a601bd0e718000db8358c279534763d6fccf7bc5";
          hash = "sha256-d75kpn//MZ2OZw9dElUCzeldBTwU7NIpMYGPvizz0oo=";
        };
        generate = true;
      };
    };
  };
  ocamlPackages = prev.ocamlPackages // {
    get-activity-lib = callPackage ./ocaml/get-activity.nix { };
    gitlab = callPackage ./ocaml/gitlab.nix { };
    okra = callPackage ./ocaml/okra.nix { };
  };
}
