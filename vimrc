" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'jiangmiao/auto-pairs' " automatically close brackets etc.
Plug 'vim-airline/vim-airline' " airline status bar
Plug 'flazz/vim-colorschemes' " colorschemes for vim
Plug 'felixhummel/setcolors.vim' " make switching between colorschemes temporarily easy (use :colors colorschemename)
Plug 'yggdroot/indentline' " show indent lines
Plug 'justinmk/vim-syntax-extra' " better highlighting for C
Plug 'scrooloose/nerdtree' " NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin' " NERdTree git plugin

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
let mapleader = "," " set leader key to comma <,>
nmap <leader>v :edit $MYVIMRC<CR>

" set colorscheme/use :colors nameofscheme to quickly try out a different one
colorscheme Monokai

" indent guides
let g:indentLine_char = '|'

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

" allow switching and closing buffers without writing them to file first
set hidden

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

" remap to easily switch between tabs
nnoremap <C-j> :tabp<CR>
nnoremap <C-k> :tabn<CR>
"
" Move normally between wrapped lines
nmap j gj
nmap k gk

" NERDTree Settings

" toggle NERDTree
nnoremap <silent> <Leader>f :NERDTreeToggle<CR>
" quickly find current file in NERDTree
nnoremap <silent> <Leader>h :NERDTreeFind<CR>
nnoremap <silent> <Leader><S-f> :NERDTreeFocus<CR>
" automatically delete buffer of file that was just deleted using NERDTree
let NERDTreeAutoDeleteBuffer = 1
" show line numbers in NERDTree
let NERDTreeShowLineNumbers = 1
