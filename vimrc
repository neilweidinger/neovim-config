set number relativenumber
set ruler

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" keeps three lines visible when scrolling and cursor is at edge of window
set scrolloff=3

" function so that control e and y scroll by an eight of window height, not line by line
function! ScrollQuarter(move)
    let height=winheight(0)

    if a:move == 'up'
        let key="\<C-Y>"
    else
        let key="\<C-E>"
    endif

    execute 'normal! ' . height/8 . key
endfunction

" remapping necessary for above function
nnoremap <silent> <C-y> :call ScrollQuarter('up')<CR>
nnoremap <silent> <C-e> :call ScrollQuarter('down')<CR>

" switches between relative and absolute numbering depending on mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set wildmenu            " visual autocomplete for command menu
syntax enable           " enable syntax highlighting

" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
let mapleader = "," " set leader key to comma <,>
nmap <leader>v :edit $MYVIMRC<CR>

" remap to easily switch between tabs
nnoremap <C-j> :tabp<cr> 
nnoremap <C-k> :tabn<cr>
