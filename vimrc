set number relativenumber
set ruler

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" switches between relative and absolute numbering depending on mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set wildmenu            " visual autocomplete for command menu
syntax enable

" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
let mapleader = ","
nmap <leader>v :edit $MYVIMRC<CR>

" remap to easily switch between tabs
nnoremap <C-j> :tabp<cr> 
nnoremap <C-k> :tabn<cr>
