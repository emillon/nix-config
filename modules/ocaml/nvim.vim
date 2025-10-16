let g:merlindir = trim(system('dirname $(command -v ocamlmerlin)')) . "/../share/merlin/vim"
if isdirectory(g:merlindir)
execute "set rtp+=" . g:merlindir
"execute "helptags " . g:merlindir . "/doc"
endif
let g:syntastic_ocaml_checkers = ['merlin']
