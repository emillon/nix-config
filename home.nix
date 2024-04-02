{ home-manager, nixgl, nixpkgs, system }:
let
  username = "etienne";
  common = {
    home.stateVersion = "22.11";
    home.username = "etienne";
    home.homeDirectory =
      if system == "aarch64-darwin" then "/Users/etienne" else "/home/etienne";
    programs.home-manager.enable = true;
  };
  dev = import ./dev.nix { inherit pkgs; };
  x11 = import ./x11.nix { inherit pkgs; };
  wayland = import ./wayland.nix { inherit pkgs; };
  media = { home.packages = with pkgs; [ yt-dlp ]; };
  work = { home.packages = [ pkgs.ocamlPackages.okra.okra-bin ]; };
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [ (import ./overlay.nix) nixgl.overlay (import ./nixglize.nix) ];
  };
in {
  packages = {
    homeConfigurations = {
      "${username}@delpech" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ common dev media x11 wayland ./machines/delpech.nix work ];
      };
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ common dev ];
      };
    };
  };
}
