{ lib, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.email = lib.mkDefault "me@emillon.org";
      user.name = "Etienne Millon";
      url = {
        "git@github.com:".pushInsteadOf = "https://github.com/";
        "git@gist.github.com:".pushInsteadOf = "https://gist.github.com/";
      };
      merge.conflictstyle = "diff3";
      commit.verbose = true;
      pull.ff = "only";
      rerere.enabled = true;
      interactive.singlekey = true;
      init.defaultBranch = "main";
    };
  };
}
