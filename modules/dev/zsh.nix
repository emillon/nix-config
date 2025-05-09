{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    history = {
      save = 100000;
      size = 100000;
    };
    shellAliases = {
      ls = "ls -F --color=auto";
      ":e" = "vim";
      ":q" = "exit";
    };
    initContent = lib.mkOrder 1000 (builtins.readFile ./init.zsh);
  };
}
