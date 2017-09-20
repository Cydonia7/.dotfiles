" Plugins {{{
call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-sensible' " Sensible defaults for Vim
    Plug 'godlygeek/csapprox' " Allow to use GUI vim themes
    Plug 'daylerees/colour-schemes', { 'rtp': 'vim' } " Many color schemes
    Plug 'mattn/emmet-vim' " Fast HTML generation
    Plug 'ervandew/supertab' " Allows to use YCM and Ultisnips with Tab
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' } " Smart autocompletion
    Plug 'SirVer/ultisnips' " Complete snippets
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finder
    Plug 'scrooloose/syntastic' " Linting
    Plug 'scrooloose/nerdtree' " Tree-based directory view
    Plug 'airblade/vim-gitgutter' " Git gutter
    Plug 'StanAngeloff/php.vim' " Up-to-date syntax
    Plug 'tpope/vim-surround' " Handle surroundings
    Plug 'tpope/vim-fugitive' " Git wrapper
    Plug 'arnaud-lb/vim-php-namespace' " Use statements in PHP
    Plug 'janko-m/vim-test' " Vim test runner
    Plug 'tpope/vim-dispatch' " Dispatch commands asynchronously
call plug#end()
" }}}

" Ultisnips / YCM compatibility using Supertab {{{
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips/'
let g:UltiSnipsSnippetDirectories = [ "UltiSnips" ]
let g:UltiSnipsEditSplit = "vertical"
" }}}

" Basic editor config {{{
colorscheme zacks
set sidescroll=1 " Allows smooth-scrolling for long lines
let g:is_posix=1 " Tell Vim we are in a POSIX terminal for better colors
set lazyredraw
set number relativenumber
set cursorline
let mapleader = ","
let maplocalleader = "\\"
set path+=**
set tags+=tags,tags.vendors
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" Tab configuration
set shiftround
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set scrolloff=15
" }}}

" Keyboard configuration {{{
" Nerdtree
nnoremap <Leader>n :NERDTreeToggle<CR>

" Buffer resizing
nnoremap <Leader>+ :vertical res +5<CR>
nnoremap <Leader>- :vertical res -5<CR>

" Buffer navigation
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>l :wincmd l<CR>

nnoremap <Leader>v <C-W>v
nnoremap <Leader>s <C-W>s
nnoremap <Leader>d <C-W>q

" Edition helpers
" Move lines up / down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" Beginning / end of line
nnoremap H ^
nnoremap L $
" Delete a line
nnoremap <C-d> dd
inoremap <C-d> <ESC>ddi
" Set current word to uppercase
nnoremap <C-u> viwU<C-o>e<C-o>l
inoremap <C-u> <C-o>h<C-o>viwU<C-o>e<C-o>l
" Edit vimrc
nnoremap <Leader>x ZZ
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<cr>
" Exit insert mode
inoremap jk <esc>

" Faster operator movements
onoremap p i(
onoremap np :<c-u>normal! f(vi(<cr>
onoremap nsq :<c-u>normal! 2f'vi'<cr>

" Abbreviations
" iabbrev adn and
" }}}

" Fuzzy-finding (FZF) {{{
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
" }}}

" Syntastic {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
" }}}

" Status line {{{
set statusline=
set statusline=%{fugitive#statusline()}\  " Git status
set statusline+=%t         " Path to the file
set statusline+=\ %y         " Filetype
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines
" }}}

" File-specific settings {{{
augroup filetype_php
    autocmd!
    autocmd FileType php nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType php let test#php#phpunit#executable = 'docker-compose run --rm tools ./vendor/bin/simple-phpunit'
    autocmd FileType php nnoremap <buffer> <localleader>r :TestNearest<cr>
    autocmd FileType php nnoremap <buffer> <localleader>t :TestFile<cr>
    autocmd FileType php nnoremap <buffer> <localleader>y :TestSuite<cr>
    autocmd FileType php nnoremap <buffer> <localleader>l :TestLast<cr>
    autocmd FileType php nnoremap <buffer> <localleader>v :TestVisit<cr>
    autocmd FileType php setlocal nowrap
    autocmd FileType php iabbrev <buffer> return NOPENOPENOPE
    autocmd FileType php iabbrev <buffer> rt return
    autocmd FileType php hi link phpDocTags phpInclude
    autocmd FileType php hi link phpDocTags phpInclude
    autocmd FileType php :syn match phpDocTags "@\%([^( ]*\)" containedin=phpDocComment nextgroup=phpDocParam,phpDocIdentifier skipwhite contained
    function! IPhpInsertUse()
        call PhpInsertUse()
        call feedkeys('a',  'n')
    endfunction
    autocmd FileType php inoremap <localleader>u <Esc>:call IPhpInsertUse()<CR>
    autocmd FileType php noremap <localleader>u :call PhpInsertUse()<CR>
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevelstart=0
augroup END

autocmd BufRead,BufNewFile *.html.twig set filetype=html

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i '''' "/' . f . '/d" "' . tagfilename . '"' " TODO : This is Mac-specific, make it cross-platform
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --PHP-kinds=cfit ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction

autocmd BufWritePost *.php call UpdateTags()
" }}}

