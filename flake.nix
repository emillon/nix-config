{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "etienne";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ./overlay.nix) ];
      };
      common = {
        home.stateVersion = "22.11";
        home.username = "etienne";
        home.homeDirectory = "/home/etienne";
        programs.home-manager.enable = true;
      };
      dev = import ./dev.nix { inherit pkgs; };
      x11 = import ./x11.nix { inherit pkgs; };
      wayland = import ./wayland.nix { inherit pkgs; };
      media = { home.packages = with pkgs; [ yt-dlp ]; };
      work = { home.packages = [ pkgs.ocamlPackages.okra.okra-bin ]; };
    in {
      homeConfigurations = {
        "${username}@delpech" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ common dev media x11 wayland ./delpech.nix work ];
        };
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ common dev ];
        };
      };
    };
}
