{ home-manager, nixgl, nixpkgs, system }:
let
  username = "etienne";
  common = import ./modules/common.nix { inherit system; };
  dev = import ./modules/dev.nix { inherit pkgs; };
  x11 = import ./modules/x11.nix { inherit pkgs; };
  wayland = import ./modules/wayland.nix { inherit pkgs; };
  media = { home.packages = with pkgs; [ yt-dlp ]; };
  work = { home.packages = [ pkgs.ocamlPackages.okra.okra-bin ]; };
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [ (import ./overlay) nixgl.overlay (import ./nixglize.nix) ];
  };
  config = modules:
    home-manager.lib.homeManagerConfiguration { inherit modules pkgs; };
in {
  packages = {
    homeConfigurations = {
      "${username}@delpech" =
        config [ common dev media x11 wayland ./machines/delpech.nix work ];
      ${username} = config [ common dev ];
    };
  };
}
