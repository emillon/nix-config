final: prev:
let pkgs = prev;
in {
  ocamlPackages = prev.ocamlPackages // {
    get-activity-lib = import ./get-activity.nix { inherit pkgs; };
    gitlab = import ./gitlab.nix { inherit pkgs; };
    omd = import ./omd.nix { inherit pkgs; };
    okra = import ./okra.nix { pkgs = final.pkgs; };
  };
  opam = import ./opam.nix { inherit pkgs; };
}
