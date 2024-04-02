{ system }: {
  home.stateVersion = "22.11";
  home.username = "etienne";
  home.homeDirectory =
    if system == "aarch64-darwin" then "/Users/etienne" else "/home/etienne";
  programs.home-manager.enable = true;
}
