call plug#begin()

Plug 'kshenoy/vim-signature'
Plug 'vimwiki/vimwiki'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'stephpy/vim-php-cs-fixer'

call plug#end()

set nocompatible | filetype indent plugin on | syn on
set encoding=utf-8
set runtimepath+=/usr/bin/vam

set nobackup
set incsearch
set ignorecase
set smartcase
set showcmd
set showmatch
set hlsearch
set history=1000

" vim wildmenu
set wildmenu
"set wildignore=*.docx,*.jpg,*.png,*.gif

" vim folding
" zo -> open single fold
" zc -> close fold
" zR -> open all folds
" zM -> close all folds
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" undo after closing files
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" Theme
set background=dark
set nu

set mouse=vic
"let &t_SI="\e[5 q"
"let &t_EI="\e[2 q"

" atalho buffers
nnoremap <Leader>b :buffers<CR>:buffer<Space>

if has('gui_running')
    colorscheme dracula
    set guifont=Source\ Code\ Pro\ Medium\ 12
    "set guioptions-=T
endif

"set cursorline
nnoremap <Leader>l :set cursorline!<CR>

" Close preview/draft window
nnoremap <Leader>c :pclose<cr>

" Pdf View
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

" Indentation config
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set cindent

inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

let g:UltiSnipsExpandTrigger="<c-j>"

" NERDTree config
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let g:NERDTreeChDirMode = 2

" vim-startify config
let g:startify_bookmarks = [
			\ { 'g': '~/git' },
			\ { 'v': '~/.vimrc' },
			\ ]

" vim-project config
let g:project_enable_welcome = 1
let g:project_use_nerdtree = 1

" Compilation
autocmd FileType cpp nnoremap <leader>ç :!g++ -lm -lcrypt -O2 -std=c++11 -pipe -DONLINE_JUDGE %<CR>
autocmd FileType c nnoremap <leader>ç :!gcc -lm -lcrypt -O2 -pipe -DONLINE_JUDGE %<CR>
if has('gui_running')
    autocmd FileType cpp nnoremap <leader>; :!xterm -e "time ./a.out; read"<CR><CR>
    autocmd FileType cpp nnoremap <leader>. :!xterm -e "for f in %:r.*.test; do echo \"TEST: $f\"; time ./a.out < $f; done; read"<CR><CR>
else
    autocmd FileType cpp nnoremap <leader>; :!./a.out<CR>
    autocmd FileType cpp nnoremap <leader>~ :!time ./a.out<CR>
    autocmd FileType cpp nnoremap <leader>. :!for f in %:r.*.test; do echo "TEST: $f"; ./a.out < $f; done<CR>
endif

" Boolean options mapper (map key to toggle opt)
function MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
"command -nargs=+ MapToggle call MapToggle(<f-args>)
"MapToggle <KEY> [BOOLEAN-OPTION]

" Spellchecking
autocmd FileType wiki set spell
autocmd FileType markdown,md set spell
set spelllang=pt_br

