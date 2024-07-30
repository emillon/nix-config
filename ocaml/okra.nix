{ pkgs }:
let
  src = pkgs.fetchurl {
    url = "https://github.com/tarides/opam-repository/raw/master/packages/okra/okra.3.1.0/okra-3.1.0.tbz";
    hash = "sha256-5x/YkBCUR4Ffe9gfg/sImQ+e8DDj9D3938qT1rVFz6U=";
  };
  okra-lib = pkgs.ocamlPackages.buildDunePackage {
    pname = "okra-lib";
    version = "3.1.0";
    inherit src;
    duneVersion = "3";
    propagatedBuildInputs = with pkgs.ocamlPackages; [
      calendar
      csv
      fpath
      get-activity-lib
      gitlab
      omd
    ];
  };
  okra-vim-env = "OKRA_VIM";
in
{
  inherit okra-vim-env;
  okra-vim-conf = ''
    if vim.env.${okra-vim-env} ~= nil then
      vim.api.nvim_create_autocmd(
        {"BufRead", "BufNewFile"},
        { pattern = {"*.md"},
          callback = function ()
            vim.g.syntastic_markdown_checkers = {"okra"}
            vim.g.syntastic_markdown_okra_args = "lint --short -e"
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
