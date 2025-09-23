{ lib, pkgs, ... }:
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
    initContent =
      let
        initZsh = lib.mkOrder 1000 (builtins.readFile ./init.zsh);
        # Workaround for https://github.com/NixOS/nix/issues/3616
        macFix = lib.mkAfter (
          lib.optionalString pkgs.stdenv.isDarwin ''
            [[ ! $(command -v nix) && -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]] && source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
          ''
        );
      in
      lib.mkMerge [ initZsh macFix ];
  };
}
