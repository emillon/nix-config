{ pkgs }:
let
  version = "0.5.0";
  src = pkgs.fetchFromGitHub {
    owner = "tarides";
    repo = "okra";
    rev = version;
    hash = "sha256-TVBkRACAQP7qfSPnoJRiayXoC+jloghi64nfWzheJdg=";
  };
  okra-lib = pkgs.ocamlPackages.buildDunePackage {
    pname = "okra-lib";
    version = version;
    inherit src;
    duneVersion = "3";
    propagatedBuildInputs = with pkgs.ocamlPackages; [
      calendar
      csv
      get-activity-lib
      gitlab
      omd
    ];
  };
  okra-vim-env = "OKRA_VIM";
in {
  inherit okra-vim-env;
  okra-vim-conf = ''
    if vim.env.${okra-vim-env} ~= nil then
      vim.api.nvim_create_autocmd(
        {"BufRead", "BufNewFile"},
        { pattern = {"*.md"},
          callback = function ()
            vim.g.syntastic_markdown_checkers = {"okra"}
          end
        })
    end
  '';
  okra-bin = pkgs.ocamlPackages.buildDunePackage {
    meta.mainProgram = "okra";
    duneVersion = "3";
    inherit (okra-lib) version src;
    pname = "okra";
    propagatedBuildInputs = with pkgs.ocamlPackages; [
      cmdliner
      cohttp-lwt-unix
      dune-build-info
      okra-lib
      ppx_deriving_yaml
      xdg
    ];
  };
  okra-vim = pkgs.vimUtils.buildVimPlugin {
    name = "okra";
    inherit src;
  };
}
