set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7
set nowrap
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set clipboard+=unnamedplus
filetype indent on      " load filetype-specific indent files

vmap <C-c> "+y
nmap <C-v> P
nmap <F8> :TagbarToggle<CR>
nmap <Tab> <C-w>w
nmap <S-Tab> <C-w>W
inoremap jk <esc>
nnoremap ,<space> :nohlsearch<CR>
noremap <F6> :NERDTreeRefreshRoot<CR> :NERDTreeToggle<CR>

call plug#begin('~/.vim/plugged')

Plug 'sainnhe/edge'
Plug 'junegunn/seoul256.vim'
Plug 'https://github.com/colepeters/spacemacs-theme.vim'
Plug 'https://github.com/beikome/cosme.vim'
Plug 'https://github.com/axvr/photon.vim'
Plug 'https://github.com/sts10/vim-pink-moon'

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"let g:seoul256_background = 236
if (has("termguicolors"))
  set termguicolors
endif
set background=dark
colorscheme spacemacs-theme

"---TagbarToggle---"
" Компактный вид у тагбара     
let g:tagbar_compact = 1  
" Отк. сортировка по имени у тагбара (мне хронология важнее) 
let g:tagbar_sort = 0
let g:tagbar_show_data_type = 1
let g:tagbar_width = 25

"---NERDTree---"
" Показывать скрытые файлы и папки в NERDTree  
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 25

"---coc---"
"https://github.com/neoclide/coc.nvim/issues/2088
let g:coc_global_extensions = [
            \'coc-css',
            \'coc-json',
            \'coc-tsserver',
            \'coc-pyright',
            \'coc-go',
            \'coc-ccls'
            \]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
