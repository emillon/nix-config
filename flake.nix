{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
  };

  outputs = { flake-utils, home-manager, nixgl, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (import ./overlay)
            nixgl.overlay
            (import ./overlay/nixglize.nix)
          ];
        };
      in {
        packages.homeConfigurations =
          (import ./home.nix) { inherit home-manager pkgs; };
        devShells.okra = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.ocamlPackages.okra.okra-bin ];
          shellHook = "export ${pkgs.ocamlPackages.okra.okra-vim-env}=1";
        };
      });
}
