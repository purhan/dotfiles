"GENERAL SETTINGS
syntax on
set number
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
set clipboard=unnamedplus
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set updatetime=250
set title
set belloff=all

"KEYBINDINGS
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
map <C-v> pi
map <S-End> v$
nmap <S-j> 10j
nmap <S-k> 10k
imap <C-v> <Esc>pi
map <C-z> <Esc>u
map <C-y> <Esc><C-r>i
map <C-a> ggVG
map <C-c> "+y
imap <silent><C-s> <Esc>:w<CR>
map <silent><C-s> <Esc>:w<CR>
map <silent><C-w> <C-C>:bd<CR>
map <silent><C-q> <C-C>:q!<CR>
map <silent><C-O> <Esc>:tabnew#<CR>
map <silent><C-R> <Esc>:source ~/.vimrc<CR>


" VUNDLE PLUGINS
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'dracula/vim',{'name':'dracula'}
Plugin 'rakr/vim-one'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'preservim/nerdtree'
Plugin 'dense-analysis/ale'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ycm-core/YouCompleteMe'
" Plugin 'Chiel92/vim-autoformat'   -----> sudo apt-get install astyle (for cpp)
call vundle#end()


" PLUGIN PREFERENCES
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = 'L'
filetype plugin indent on
let g:NERDTreeWinPos = "right"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
nmap <C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1


" THEMING
set termguicolors
colorscheme dracula
set background=dark
hi Normal guibg=NONE ctermbg=NONE


" CHANGE CURSOR SHAPE BASED ON MODE
" (Only works on VTE-based terminal)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
