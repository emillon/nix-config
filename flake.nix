{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    ocaml = {
      url = "github:nix-ocaml/nix-overlays";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, flake-utils, home-manager, nixgl, nixpkgs, ocaml }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            ocaml.overlays.default
            nixgl.overlay
            (import ./overlay/nixglize.nix)
            (
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
            )
          ];
        };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        packages = {
          homeConfigurations =
            (import ./home.nix) { inherit home-manager pkgs; };
          okra = pkgs.ocamlPackages.okra.okra-bin;
          opam = pkgs.opam;
        };
        devShells.okra = pkgs.mkShell {
          nativeBuildInputs = [ self.packages.${system}.okra ];
          shellHook = "export ${pkgs.ocamlPackages.okra.okra-vim-env}=1";
        };
      });
}
