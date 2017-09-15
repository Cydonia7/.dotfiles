call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-sensible' " Sensible defaults for Vim
    Plug 'godlygeek/csapprox' " Allow to use GUI vim themes
    Plug 'daylerees/colour-schemes', { 'rtp': 'vim' } " Many color schemes
    Plug 'mattn/emmet-vim' " Fast HTML generation
    Plug 'ervandew/supertab' " Allows to use YCM and Ultisnips with Tab
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " Smart autocompletion
    Plug 'SirVer/ultisnips' " Complete snippets
    Plug 'honza/vim-snippets' " Base snippets
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finder
    Plug 'scrooloose/syntastic' " Linting
    Plug 'scrooloose/nerdtree' " Tree-based directory view
    Plug 'airblade/vim-gitgutter' " Git gutter
    Plug 'StanAngeloff/php.vim' " Up-to-date syntax
    Plug 'tpope/vim-surround' " Handle surroundings
call plug#end()

" Make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

set sidescroll=1 " Allows smooth-scrolling for long lines
let g:is_posix=1 " Tell Vim we are in a POSIX terminal for better colors

" Tab configuration
set shiftround
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Basic editor config
colorscheme zacks
set lazyredraw
set number relativenumber
set cursorline
let mapleader = ","
set path+=**

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

" Edition helpers
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Options for specific file types
au BufRead,BufNewFile *.html.twig set filetype=html

" FZF config
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'
nnoremap <C-t> :FZF<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

" Doctrine annotations
hi link phpDocTags phpInclude

