{ lib, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./nvim.nix
    ./zsh.nix
    ./homebrew.nix
    ./secretive.nix
  ];

  home.packages = with pkgs; [ gh ];

  programs.tmux.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };
  programs.bat.enable = true;

  programs.zsh.initContent = lib.mkOrder 1000 ''
    export LS_COLORS=$(${lib.getExe pkgs.vivid} generate catppuccin-mocha)
  '';

  programs.fd.enable = true;
  programs.ripgrep.enable = true;
}
