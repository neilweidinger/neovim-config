" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" let g:AirlineTheme='papercolor'
" let g:airline_powerline_fonts = 1
" let g:airline_solarized_bg='dark'
" set t_Co=256

" set colorscheme/use :colors nameofscheme to quickly try out a different one
colorscheme Monokai

" stuff for tabs
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Backspace through anything in insert mode
set backspace=indent,eol,start

set incsearch " Show matches while seraching
set hlsearch " Highlight search matches

" keeps three lines visible when scrolling and cursor is at edge of window
set scrolloff=3

" set numbers on side and ruler
set number relativenumber
set ruler

" function so that control e and y scroll by specified % of window height, not line by line
function! ScrollQuarter(move)
    let height=winheight(0)

    if a:move == 'up'
        let key="\<C-Y>"
    else
        let key="\<C-E>"
    endif

    execute 'normal! ' . height/14 . key
endfunction

" remapping necessary for above function
nnoremap <silent> <C-u> :call ScrollQuarter('up')<CR>
nnoremap <silent> <C-e> :call ScrollQuarter('down')<CR>

" control y now performs control u
nnoremap <C-y> <C-u>

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
