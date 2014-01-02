" Pathogen
execute pathogen#infect()

" Basic vim configuration
syntax on
filetype plugin indent on
let mapleader = ","

" Basic editing
set number
set nocompatible
set noignorecase
set autoindent
set shiftwidth=4 
set softtabstop=4
set tabstop=4
set expandtab 
set smarttab 
set tw=0

" Molokai with 256 colors
let g:rehash256 = 1
colorscheme molokai
set background=dark
set t_Co=256

" Airline
set laststatus=2
set ttimeoutlen=50
let g:airline_theme='bubblegum'
let g:airline_detect_whitespace=0

" Tmux integration
let g:tmuxline_preset = 'tmux'
let g:tmuxline_powerline_separators = 0

" Nerdtree
map <Leader>n :NERDTreeToggle<CR>

" Buffer resizing
nmap <Leader>+ :vertical res +5<CR>
nmap <Leader>- :vertical res -5<CR>

" Buffer navigation
nmap <Leader>k :wincmd k<CR>
nmap <Leader>j :wincmd j<CR>
nmap <Leader>h :wincmd h<CR>
nmap <Leader>l :wincmd l<CR>

" Syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': ['html'] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
map <Leader>m :Errors<CR>

" Fugitive
nmap <Leader>gs :Gstatus<CR>
