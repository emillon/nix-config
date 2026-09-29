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
    let
      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [ (import ./overlay.nix) ];
        config.allowUnfree = true;
      };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
      let pkgs = pkgsFor system; in
      {
        formatter = pkgs.nixpkgs-fmt;
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.just
            pkgs.prek
          ];
        };
      })
    // {
      homeConfigurations =
        (import ./home.nix) { inherit home-manager pkgsFor; };
    };
}
