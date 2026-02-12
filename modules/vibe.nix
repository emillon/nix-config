{pkgs, ...}:
{
  home.packages = [ pkgs.mistral-vibe ];
  programs.claude-code.enable = true;
}
