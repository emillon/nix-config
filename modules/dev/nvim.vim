let mapleader=","
let maplocalleader=","
nnoremap <silent> <C-p> <cmd>Telescope git_files<cr>
nmap <LocalLeader>f :Neoformat<cr>
colorscheme catppuccin
inoremap jk <esc>
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
let g:merlindir = trim(system('dirname $(command -v ocamlmerlin)')) . "/../share/merlin/vim"
if isdirectory(g:merlindir)
execute "set rtp+=" . g:merlindir
"execute "helptags " . g:merlindir . "/doc"
endif
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_rst_checkers = ['sphinx']
set sw=4
set expandtab
set ignorecase
set smartcase
set signcolumn=yes:1
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
