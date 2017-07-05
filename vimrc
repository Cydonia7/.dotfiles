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
set hlsearch
set cursorline

" Specific filetype options
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.html.twig set filetype=html

" 256 colors in term
set t_Co=256
let g:rehash256 = 1

" Tomorrow
" colorscheme Tomorrow-Night

" Molokai + transparent background
set background=dark
colorscheme molokai

hi Normal ctermfg=252 ctermbg=none
hi LineNr ctermfg=239 ctermbg=none

" Airline
set laststatus=2
set ttimeoutlen=50
let g:airline_theme='bubblegum'
let g:airline_detect_whitespace=0
let g:airline_powerline_fonts = 1

" Tmux integration
let g:tmuxline_preset = 'tmux'

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

nmap <Leader>v <C-W>v
nmap <Leader>s <C-W>s
nmap <Leader>d <C-W>q

" Syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': ['html'] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
map <Leader>m :Errors<CR>

" Fugitive
nmap <Leader>gs :Gstatus<CR>

nnoremap <Leader>q :!pdflatex *.tex<CR><CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Disable readonly on write
function! g:ChmodOnWrite()
  if v:cmdbang
    silent !chmod u+w %
  endif
endfunction

autocmd BufWrite * call g:ChmodOnWrite()
