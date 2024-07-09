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
    omd = callPackage ./ocaml/omd.nix { inherit pkgs; };
    okra = callPackage ./ocaml/okra.nix { };
    swhid_core = callPackage ./ocaml/swhid_core.nix { inherit buildDunePackage; };
    zeroinstall-solver = callPackage ./ocaml/0install-solver.nix { inherit buildDunePackage; };
    opam-0install-cudf = callPackage ./ocaml/opam-0install-cudf.nix { };
    spdx_licenses = callPackage ./ocaml/spdx_licenses.nix { };
  };
  opam = callPackage ./ocaml/opam.nix { inherit buildDunePackage; };
}
