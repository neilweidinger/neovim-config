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
Plug 'easymotion/vim-easymotion' " quicly jump around using quick hotkeys

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
let mapleader = " " " set leader key to space
nmap <leader>v :edit $MYVIMRC<CR>
" reload vimrc
nmap <leader>sv :source $MYVIMRC<CR>

" set colorscheme/use :colors nameofscheme to quickly try out a different one
colorscheme Monokai
" airline theme, use :AirlineTheme nameoftheme to quicly try out a different one
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

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
nnoremap <CR> :noh<CR><CR>

" to make consistent with L (moves cursor to bottom)
nmap zl zb

" remap joining two lines since J is mapped to switching buffers above
nnoremap <Leader>J J





map <Leader> <Plug>(easymotion-prefix)

map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)





" NERDTree Settings

" toggle NERDTree
" nnoremap <silent> <Leader>f :NERDTreeToggle<CR>
" quickly find current file in NERDTree
" nnoremap <silent> <Leader>h :NERDTreeFind<CR>
" change focus back to NERDTree
" nnoremap <silent> <Leader><S-f> :NERDTreeFocus<CR>
" automatically delete buffer of file that was just deleted using NERDTree
" let NERDTreeAutoDeleteBuffer = 1
" show line numbers in NERDTree
" let NERDTreeShowLineNumbers = 1

" ranger.vim mappings
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
