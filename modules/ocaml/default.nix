{ pkgs, ... }:
let
  cramGrammar =
    pkgs.tree-sitter.buildGrammar {
      language = "cram";
      version = "0.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "tjdevries";
        repo = "tree-sitter-cram";
        rev = "8cb450dfc5548b1aed2be5b3cd735c123b6fa6a8";
        hash = "sha256-CcLbZyHNKLA7NoQ3SLWEBCh5Y/dmzcSGQjs6iCrCFVY=";
      };
    };
  duneGrammar = pkgs.tree-sitter.buildGrammar {
    language = "dune";
    version = "0.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "emillon";
      repo = "tree-sitter-dune";
      rev = "c0360304e7d049e8657f40bc871deef1d37a2396";
      hash = "sha256-mPIDX3l3/Koq7JkoOebz4B1J98qtnu/XB7nB76ZnSls=";
    };
    generate = true;
  };
  mldGrammar = pkgs.tree-sitter.buildGrammar {
    language = "mld";
    version = "0.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "emillon";
      repo = "tree-sitter-mld";
      rev = "ecfc4678394e5cfe6881e33fb410b4ae024cdbe9";
      hash = "sha256-ugPLhg9P3dtM+7c3DzjJIR2vgJn9jN4Bo+U0HwMMnM0=";
    };
    generate = true;
  };
in
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p:
        [
          p.menhir
          p.ocaml
          p.ocaml-interface
        ]))
    ] ++ map pkgs.neovimUtils.grammarToPlugin [ cramGrammar duneGrammar mldGrammar ]
    ;
    extraConfig = builtins.readFile ./nvim.vim;
    extraLuaConfig = builtins.readFile ./nvim.lua;
  };

  programs.opam = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };
}
