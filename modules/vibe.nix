{pkgs, ...}:
{
  home.packages = [ pkgs.mistral-vibe ];

  programs.claude-code.enable = true;
  home.sessionVariables = {
    ANTHROPIC_MODEL = "claude-opus-4-5@20251101";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "claude-haiku-4-5@20251001";
  };
}
