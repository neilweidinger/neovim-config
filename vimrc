set nocompatible

" ================ Plugins ====================
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'jiangmiao/auto-pairs' " automatically close brackets etc.
Plug 'vim-airline/vim-airline' " airline status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes' " colorschemes for vim
Plug 'felixhummel/setcolors.vim' " make switching between colorschemes temporarily easy (use :colors colorschemename)
Plug 'yggdroot/indentline' " show indent lines
Plug 'justinmk/vim-syntax-extra' " better highlighting for C
" Plug 'scrooloose/nerdtree' " NERDTree
" Plug 'Xuyuanp/nerdtree-git-plugin' " NERdTree git plugin
Plug 'rafaqz/ranger.vim' " Use ranger as a file explorer within vim
Plug 'easymotion/vim-easymotion' " quickly jump around using quick hotkeys
Plug 'tpope/vim-surround' " quickly manipulate surrounding delimeters
Plug 'mattn/emmet-vim' " for html expansion, don't really use
Plug 'neovimhaskell/haskell-vim' " Haskell syntax highlighting and formatting
Plug 'majutsushi/tagbar' " tagbar to quickly jump around code

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" ================ Leader Key ====================
" set leader key to space
let mapleader = " "
" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nmap <leader>v :edit $MYVIMRC<CR>
" reload vimrc
nmap <leader>sv :source $MYVIMRC<CR>


" ================ Colors and Themes ====================
" set colorscheme/use :colors nameofscheme to quickly try out a different one
colorscheme Monokai
" airline theme, use :AirlineTheme nameoftheme to quicly try out a different one
let g:airline_theme='luna_neil'
" enable powerline arrows
let g:airline_powerline_fonts = 1
" show buffers in top tabline
let g:airline#extensions#tabline#enabled = 1
" show buffer numbers in top tabline
let g:airline#extensions#tabline#buffer_nr_show = 1

" ================ General Config ====================
" indent guides for indentline plugin
let g:indentLine_char = '|'

" stuff for tabs
set autoindent
set smartindent
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

" ignore case for searches
set ignorecase
" when upper case character is typed in search, serach becomes case sensitive
set smartcase

" keeps three lines visible when scrolling and cursor is at edge of window
set scrolloff=3

" set numbers on side and ruler
set number relativenumber
set ruler

" open new split panes to right and bottom
set splitbelow
set splitright

" redraw only when we need to
set lazyredraw

" so that we can ESC out of insert mode quicker
set timeoutlen=1000 ttimeoutlen=0

" so that Tagbar can detect filetype
filetype on

" use mouse to move cursor position and scroll
set mouse=nirc

" function so that control e and y scroll by specified % of window height, not line by line
function! ScrollQuarter(move)
    let height=winheight(0)

    if a:move == 'up'
        let key="\<C-Y>"
    else
        let key="\<C-E>"
    endif

    execute 'normal! ' . height/6 . key
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

" Quick jumping between splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Quick jumping between buffers
nmap J :bp<CR>
nmap K :bn<CR>
" Quickly jump to buffer [n]
nmap <Leader>o :b
" Quickly close buffer
nmap <Leader>c :bd<CR>

" Move normally between wrapped lines
nmap j gj
nmap k gk

" Press enter to clear highlighting for previous search
nnoremap <CR> :noh<CR>

" remap joining two lines since J is mapped to switching buffers above
nnoremap <Leader>J J



" easymotion mappings

" no need to press leader twice to activate easymotion
map <Leader> <Plug>(easymotion-prefix)

" motions like f and t use easymotion by default and only work for current line
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

" use leader / to use easymotion search
map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)

autocmd Filetype json let g:indentLine_enabled = 0


"  NERDTree Settings
" 
"  toggle NERDTree
" nnoremap <silent> <Leader>f :NERDTreeToggle<CR>
"  quickly find current file in NERDTree
" nnoremap <silent> <Leader>h :NERDTreeFind<CR>
"  change focus back to NERDTree
" nnoremap <silent> <Leader><S-f> :NERDTreeFocus<CR>
"  automatically delete buffer of file that was just deleted using NERDTree
" let NERDTreeAutoDeleteBuffer = 1
"  show line numbers in NERDTree
" let NERDTreeShowLineNumbers = 1

" ranger.vim mappings
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
