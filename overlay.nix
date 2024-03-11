final: prev:
let pkgs = prev;
in {
  ocamlPackages = prev.ocamlPackages // {
    get-activity-lib = import ./ocaml/get-activity.nix { inherit pkgs; };
    gitlab = import ./ocaml/gitlab.nix { inherit pkgs; };
    omd = import ./ocaml/omd.nix { inherit pkgs; };
    okra = import ./ocaml/okra.nix { pkgs = final.pkgs; };
  };
  opam = import ./ocaml/opam.nix { inherit pkgs; };
}
