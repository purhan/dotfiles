"GENERAL SETTINGS
syntax on
set autoread
set clipboard=unnamedplus
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set updatetime=25
set title
set belloff=all
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
set nocompatible
filetype off

" PLUGIN PREFERENCES
nmap <C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

