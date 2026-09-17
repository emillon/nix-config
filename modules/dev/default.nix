{ lib, pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./gh.nix
    ./git.nix
    ./homebrew.nix
    ./nvim.nix
    ./secretive.nix
    ./zsh.nix
  ];

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

  programs.zsh.initContent = lib.mkOrder 1000 ''
    export LS_COLORS=$(${lib.getExe pkgs.vivid} generate catppuccin-mocha)
  '';

  programs.fd.enable = true;
  programs.ripgrep.enable = true;
}
