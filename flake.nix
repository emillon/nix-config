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
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
  };



  outputs =
    { self
    , flake-parts
    , ffmpeg-concat
    , flake-utils
    , home-manager
    , nixpkgs
    , import-tree
    } @ inputs:
    let
      old_stuff =
        (
          flake-utils.lib.eachDefaultSystem (system:
            let
              pkgs = import nixpkgs {
                inherit system;
                overlays = [ (import ./overlay.nix { inherit ffmpeg-concat; }) ];
                config.allowUnfree = true;
              };
            in
            {
              packages = {
                homeConfigurations =
                  (import ./home.nix) { inherit home-manager pkgs; };
              };
            }));
      new_stuff = flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules2);
    in
    new_stuff // old_stuff;
}
