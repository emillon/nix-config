{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    ffmpeg-concat = {
      url = "github:emillon/ffmpeg-concat";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    { self
    , ffmpeg-concat
    , flake-utils
    , home-manager
    , nixpkgs
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import ./overlay.nix { inherit ffmpeg-concat; }) ];
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
