{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    tree-sitter-cram-src = {
      url = "github:tjdevries/tree-sitter-cram";
      flake = false;
    };
    tree-sitter-dune-src = {
      url = "github:emillon/tree-sitter-dune";
      flake = false;
    };
    tree-sitter-mld-src = {
      url = "github:emillon/tree-sitter-mld";
      flake = false;
    };
  };

  outputs =
    { self
    , flake-utils
    , home-manager
    , nixpkgs
    , tree-sitter-cram-src
    , tree-sitter-dune-src
    , tree-sitter-mld-src
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (
            final: prev:
              let
                callPackage = prev.callPackage;
              in
              {
                tree-sitter = prev.tree-sitter.override {
                  extraGrammars = {
                    cram.src = tree-sitter-cram-src;
                    dune = {
                      src = tree-sitter-dune-src;
                      generate = true;
                    };
                    mld = {
                      src = tree-sitter-mld-src;
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
