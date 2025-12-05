{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , flake-utils
    , home-manager
    , nixpkgs
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      formatter = pkgs.nixpkgs-fmt;
      packages = {
        homeConfigurations =
          (import ./home.nix) { inherit home-manager pkgs; };
      };
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.just
        ];
      };
    });
}
