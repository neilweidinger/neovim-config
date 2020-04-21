set nocompatible

" ================ PLUGINS ====================
" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" Declare the list of plugins.
Plug 'jiangmiao/auto-pairs' " Automatically close brackets etc.
Plug 'vim-airline/vim-airline' " Airline status bar
Plug 'vim-airline/vim-airline-themes' " Themes for airline
Plug 'justinmk/vim-syntax-extra' " Better highlighting for C
Plug 'rafaqz/ranger.vim' " Use ranger as a file explorer within vim
Plug 'easymotion/vim-easymotion' " Quickly jump around using quick hotkeys
Plug 'tpope/vim-surround' " Quickly manipulate surrounding delimeters
Plug 'neovimhaskell/haskell-vim' " Haskell syntax highlighting and formatting
Plug 'majutsushi/tagbar' " Tagbar to quickly jump around code
Plug 'pangloss/vim-javascript' " JavaScript syntax highlighting
Plug 'mxw/vim-jsx' " JSX syntax highlighting
Plug 'ap/vim-css-color' " Preview CSS colors in source code
Plug 'EinfachToll/DidYouMean' " Prevents vim from opening up fresh empty files when there are multiple files w similar names
Plug 'tpope/vim-commentary' " Plugin for comments
Plug 'lervag/vimtex' " Stuff for latex
Plug 'KeitaNakamura/tex-conceal.vim' " Latex conceal
Plug 'christoomey/vim-tmux-navigator' " Easy switching between tmux panes when inside of vim
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense in vim
Plug 'PontusPersson/pddl.vim' " PDDL syntax highlighting
Plug 'crusoexia/vim-monokai' " Monokai color theme

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" ================ COLORS AND THEMES ====================

" syntax highlighting color theme
colorscheme monokai
" idk if these two lines are necessary, but just in case
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" airline theme, use :AirlineTheme nameoftheme to quicly try out a different one
let g:airline_theme='luna_neil'
" enable powerline arrows
let g:airline_powerline_fonts=1
" show buffers in top tabline
let g:airline#extensions#tabline#enabled=1
" show buffer numbers in top tabline
let g:airline#extensions#tabline#buffer_nr_show=1


" ================ GENERAL CONFIG ====================

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

let g:vimtex_view_method="skim"
" let g:vimtex_view_general_viewer='/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options='-r @line @pdf @tex'
set conceallevel=2
let g:tex_conceal='abdmg'

" idk what this really does but it speeds up vim (highlight matching pair was
" slow)
" let g:loaded_matchparen=20
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2

" stuff for tabs
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Backspace through anything in insert mode
set backspace=indent,eol,start

" Show matches while seraching
set incsearch

" Highlight search matches
set hlsearch

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

" for color stuff, idk not really sure what exactly this does tbh
set termguicolors

" disable cursor styling
set guicursor=

" switches between relative and absolute numbering depending on mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set wildmenu            " visual autocomplete for command menu
syntax enable           " enable syntax highlighting

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif


" ================ MAPPINGS ====================

" set leader key to space
let mapleader=" "
" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nmap <leader>v :edit $MYVIMRC<CR>
" reload vimrc
nmap <leader>sv :source $MYVIMRC<CR>

" remapping necessary for above function
nnoremap <silent> <C-u> :call ScrollQuarter('up')<CR>
nnoremap <silent> <C-e> :call ScrollQuarter('down')<CR>

" control y now performs control u
nnoremap <C-y> <C-u>

" Quick jumping between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Quick jumping between buffers
nmap J :bp<CR>
nmap K :bn<CR>

" Quickly go to buffer [n]
nmap <Leader>o :ls<CR>:b<Space>
" Quickly close buffer
nmap <Leader>c :bd<CR>

" Move by wrapped line unless a count is specified, in which case it behaves normally
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Press enter to clear highlighting for previous search
nnoremap <Leader><CR> :noh<CR>

" remap joining two lines since J is mapped to switching buffers above
nnoremap <Leader>J J

" toggle for tagbar
nnoremap <silent> ;; :TagbarToggle<CR>

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

" ranger.vim mappings
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@


" ================ COC.VIM Settings ====================

let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-vimtex',
  \ 'coc-sh',
  \ 'coc-python',
  \ 'coc-clangd',
\ ]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Show documentation for keyword under cursor in new window
nnoremap <silent> U :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>

" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" Switch header/source file in C/C++
nnoremap <silent> <space>h  :<C-u>CocCommand clangd.switchSourceHeader<cr>


" ================ OTHERS ====================

autocmd Filetype json let g:indentLine_enabled=0

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
