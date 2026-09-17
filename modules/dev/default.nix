{ lib, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./nvim.nix
    ./zsh.nix
    ./homebrew.nix
    ./secretive.nix
    ./bat.nix
  ];

  programs.gh = {
    enable = true;
    settings = {
      telemetry = "disabled";
      aliases.my = "pr list --author @me";
    };
  };

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
