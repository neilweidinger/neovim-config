set nocompatible
let g:polyglot_disabled = [] " Necessary to put this at very top for some reason (https://github.com/sheerun/vim-polyglot#troubleshooting)


" ================ PLUGINS ====================

" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" Declare the list of plugins.
Plug 'jiangmiao/auto-pairs' " Automatically close brackets etc.
Plug 'vim-airline/vim-airline' " Airline status bar
Plug 'vim-airline/vim-airline-themes' " Themes for airline
Plug 'rafaqz/ranger.vim' " Use ranger as a file explorer within vim
Plug 'easymotion/vim-easymotion' " Quickly jump around using quick hotkeys
Plug 'tpope/vim-surround' " Quickly manipulate surrounding delimeters
Plug 'ap/vim-css-color' " Preview CSS colors in source code
Plug 'EinfachToll/DidYouMean' " Prevents vim from opening up fresh empty files when there are multiple files w similar names
Plug 'tpope/vim-commentary' " Plugin for comments
Plug 'lervag/vimtex' " Stuff for latex
Plug 'KeitaNakamura/tex-conceal.vim' " Latex conceal
Plug 'christoomey/vim-tmux-navigator' " Easy switching between tmux panes when inside of vim
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense in vim
Plug 'crusoexia/vim-monokai' " Monokai color theme
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic highlighting for C/C++
Plug 'liuchengxu/vista.vim' " Tagbar like replacement using LSP
Plug '/usr/local/opt/fzf' " Add homebrew installed fzf to neovim runtime
Plug 'junegunn/fzf.vim' " Vim wrapper for fzf
Plug 'mbbill/undotree' " Undo tree viewer
Plug 'tpope/vim-obsession' " Automatically save vim sessions so that tmux can restore them when restarting
Plug 'rust-lang/rust.vim' " Really only used to auto run rustfmt on buffer save
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-slash' " Unhighlight search after moving cursor
" Icons for tabline, ALWAYS LOAD THIS PLUGIN LAST
Plug 'ryanoasis/vim-devicons'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" To prevent autocmd pileup
" https://vi.stackexchange.com/q/9455
augroup NeilAutocmdGroup
    autocmd!
augroup END

" ================ COLORS AND THEMES ====================

" Set up custom highlight colors for misspelled words
" https://vi.stackexchange.com/a/18298
" Try undercurl in alacritty instead when supported: https://github.com/alacritty/alacritty/pull/4660
augroup MyHighlightColors
    autocmd!
    autocmd ColorScheme *
        \ highlight SpellBad
        \   gui=bold guifg=#ffffff guibg=#e73c50 " white foreground, red background
    autocmd ColorScheme *
        \ highlight SpellLocal
        \   gui=bold guifg=#ffffff guibg=#d9b92e " white foreground, gold background
    autocmd ColorScheme *
        \ highlight SpellRare
        \   gui=bold guifg=#ffffff guibg=#1ddb1d " white foreground, green background
augroup END

" Syntax highlighting color theme
colorscheme monokai
" Idk if these two lines are necessary, but just in case
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" Airline theme, use :AirlineTheme nameoftheme to quicly try out a different one
let g:airline_theme='luna_neil'
" Enable powerline arrows
let g:airline_powerline_fonts=1
" Show buffers in top tabline
let g:airline#extensions#tabline#enabled=1
" Show buffer numbers in top tabline
let g:airline#extensions#tabline#buffer_nr_show=1
" Disable airline whitespace extension
let g:airline#extensions#whitespace#enabled = 0
" Disable default airline obsession integration (indicator wasn't in desired section)
let g:airline#extensions#obsession#enabled = 0
" Add ObsessionStatus to airline status manually
" AirlineInit stuff: https://github.com/vim-airline/vim-airline/issues/777#issuecomment-627520759
function! AirlineInit()
    let g:airline_section_c = '%<%{ObsessionStatus(''TRACKED'', '''')} %f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#%#__accent_bold#%{airline#util#wrap(airline#extensions#coc#get_status(),0)}%#__restore__#'
endfunction
autocmd NeilAutocmdGroup User AirlineAfterInit call AirlineInit()

" Use built-in neovim highlight on yank
autocmd NeilAutocmdGroup TextYankPost * silent! lua vim.highlight.on_yank()


" ================ GENERAL CONFIG ====================

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

let g:vimtex_view_method="skim"
" let g:vimtex_view_general_viewer='/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options='-r @line @pdf @tex'
set conceallevel=2
let g:tex_conceal='abdmg'
let g:tex_flavor = 'latex'
" Close vimtex quickfix window after resuming editing
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

" Used to pass the `-shell-escape` option to latexmk, needed for Latex minted
" package (for dissertation)
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-shell-escape',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Idk what this really does but it speeds up vim (highlight matching pair was
" slow)
" let g:loaded_matchparen=20
let g:matchparen_timeout = 2
let g:matchparen_insert_timeout = 2

" Enable auto rustfmt on save
let g:rustfmt_autosave = 1

" Don't enable vim-sensible shipped with polyglot
let g:polyglot_disabled = ['sensible']

" Stuff for tabs
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Backspace through anything in insert mode
set backspace=indent,eol,start

" Show matches while searching
set incsearch

" Highlight search matches
set hlsearch

" Allow switching and closing buffers without writing them to file first
set hidden

" Ignore case for searches
set ignorecase

" Infer case when doing keyword completion
set infercase

" Ignore case when completing file names and directories
set wildignorecase

" When upper case character is typed in search, search becomes case sensitive
set smartcase

" Keeps three lines visible when scrolling and cursor is at edge of window
set scrolloff=3

" Set numbers on side and ruler
set number relativenumber
set ruler

" Cursorline that automatically disappears when switching windows
set cursorline
autocmd NeilAutocmdGroup WinEnter * setlocal cursorline
autocmd NeilAutocmdGroup WinLeave * setlocal nocursorline

" Open new split panes to right and bottom
set splitbelow
set splitright

" Redraw only when we need to
set lazyredraw

" So that we can ESC out of insert mode quicker
set timeoutlen=1000 ttimeoutlen=0

" So that Tagbar can detect filetype (on)
" Required for rust.vim (plugin indent)
filetype plugin indent on

" Use mouse to move cursor position and scroll
set mouse=nirc

" For color stuff, idk not really sure what exactly this does tbh
set termguicolors

" Disable cursor styling
set guicursor=

" Allow vim to use system clipboard by default
set clipboard+=unnamed
"
" Visual autocomplete for command menu
set wildmenu

" Popup menu transparency
set pumblend=25

" Live substitution with preview window
set inccommand=split

" Persistent undo (undo history is preserved after quitting vim and reopening)
set undofile

" Set default line wrapping to 100 characters
set textwidth=100

" Treat dash separated words as a text object
autocmd NeilAutocmdGroup FileType tex set iskeyword+=-
" Treat colon separeted words as a text object (I really don't know why this is
" subtractive vs additive for dash's)
autocmd NeilAutocmdGroup FileType tex set iskeyword-=:
" Turn on spell checking in tex files
autocmd NeilAutocmdGroup FileType tex setlocal spell spelllang=en_us
" Wrap lines when writing latex
autocmd NeilAutocmdGroup FileType tex set textwidth=80

" Enable syntax highlighting
syntax enable

" Switches between relative and absolute numbering depending on mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd NeilAutocmdGroup BufLeave * call AutoSaveWinView()
    autocmd NeilAutocmdGroup BufEnter * call AutoRestoreWinView()
endif

" Make vim recognize .conf files as the config FileType
autocmd NeilAutocmdGroup BufEnter,BufRead *.conf setf config


" ================ FUNCTIONS ====================

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

" Function so that scroll amount specified by % of window height, not absolute line amount
function! ScrollQuarter(move)
    let height=winheight(0)

    if a:move == 'up'
        let key="\<C-Y>"
    else
        let key="\<C-E>"
    endif

    execute 'normal! ' . height/6 . key
endfunction

function! SaveClosedWindow()
    let g:closedBuffer = bufname()
endfunction

function! ReopenClosedWindow()
    let result = input("Open ". g:closedBuffer . " in (n)ormal (v)split, or (s)plit ? (n/v/s) : ")

    if empty(result) || (result !=# 'v' && result !=# 's' && result !=# 'n')
        return
    endif

    if result ==# 'v'
        execute "vsplit"
    elseif result ==# 's'
        execute "split"
    endif

    execute 'b ' . g:closedBuffer
endfunction


" ================ MAPPINGS ====================

" Set leader key to space
let mapleader=" "
" Opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nmap <leader>v :edit $MYVIMRC<CR>
" Reload vimrc
nmap <leader>sv :source $MYVIMRC<CR>

" Remapping necessary for scroll amount function
nnoremap <silent> <C-u> :call ScrollQuarter('up')<CR>
nnoremap <silent> <C-d> :call ScrollQuarter('down')<CR>

" Allow for easy cursor movement in insert mode
" Need to first disable <C-h> mapping from AutoPairs plugin, since plugins are loaded after .vimrc
" and AutoPairs by default defines a <C-h> mapping
" See mappings for a key binding in insert mode: verbose imap <C-h>
let g:AutoPairsMapCh = 0
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Open most recently closed buffer
autocmd NeilAutocmdGroup WinClosed * call SaveClosedWindow()
nnoremap <silent> <leader><C-t> :call ReopenClosedWindow() <CR>

" Quick jumping between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Quickly resize windows
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

" Make separator between vertical splits solid line (space character at end!)
set fillchars+=vert:\ 

" Quick jumping between buffers
nmap <silent> J :bp<CR>
nmap <silent> K :bn<CR>

" Quickly close buffer
nmap <silent> <Leader>c :bd<CR>

" Move by wrapped line unless a count is specified, in which case it behaves normally
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')

" Remap joining two lines since J is mapped to switching buffers above
nnoremap <Leader>J J

" Quickly switch between current and previous buffers
nnoremap <Leader><Leader> <c-^>

" Strip trailing whitespace
nnoremap <Leader>s :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Toggle undo tree viewer
nnoremap <Leader>u :UndotreeToggle<CR>
" Automatically switch focus to undo tree viewer when opened
let g:undotree_SetFocusWhenToggle = 1

" No need to press leader twice to activate easymotion
map <Leader> <Plug>(easymotion-prefix)

" Motions like f and t use easymotion by default and only work for current line
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)

" Use leader / to use easymotion search
map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)

" Ranger.vim mappings
map <leader>rr :RangerEdit<cr>
map <leader>rv :RangerVSplit<cr>
map <leader>rs :RangerSplit<cr>
map <leader>rt :RangerTab<cr>
map <leader>ri :RangerInsert<cr>
map <leader>ra :RangerAppend<cr>
map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@


" ================ COC.NVIM ====================

let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-vimtex',
  \ 'coc-sh',
  \ 'coc-python',
  \ 'coc-clangd',
  \ 'coc-rust-analyzer',
\ ]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

set shortmess=lnxoOtTFA

" Show documentation for keyword under cursor in new window
nnoremap <silent> U :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename
nmap <silent> <leader>rn <Plug>(coc-rename)

" Manage extensions.
nnoremap <silent> <leader>e :<C-u>CocList extensions<cr>

" Show all diagnostics.
nnoremap <silent> <leader>a :<C-u>CocList diagnostics<cr>

" Switch header/source file in C/C++
nnoremap <silent> <leader>h :<C-u>CocCommand clangd.switchSourceHeader<cr>

" Toggle rust-analyzer inlay hints
nnoremap <silent> <leader>i :<C-u>CocCommand rust-analyzer.toggleInlayHints<cr>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" ================ VISTA ====================

let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
  \ 'h': 'coc',
  \ 'c': 'coc',
  \ 'hpp': 'coc',
  \ 'cpp': 'coc',
  \ 'json': 'coc',
  \ 'css': 'coc',
  \ 'sh': 'coc',
  \ }

" Sidebar width
let g:vista_sidebar_width = 45

" Control speed of blinking when jumping to source line of tag
let g:vista_blink = [2, 150]

" Highlight entire line in Vista window since precise highlighting was
" glitching out
let g:vista_highlight_whole_line = 1

" When hovering over a tag in Vista window automatically scroll to that tag in
" the source window
let g:vista_echo_cursor_strategy='scroll'

" Icon indents
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Toggle for Vista
nnoremap <silent> ;; :Vista!!<CR>

" Automatically close Vista window if source window is closed
autocmd NeilAutocmdGroup bufenter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif


" ================ FZF.VIM ====================

" Quickly find files tracked by git in the directory tree
nmap <C-p> :GFiles --recurse-submodules<CR>
"
" Quickly find all files (including ones not tracked by git) in the directory tree
nmap <Leader>p :Files<CR>

" Quickly go to buffer [n]
nmap <Leader>o :Buffers<CR>

" Quickly search through help pages
nmap <Leader>H :Helptags<CR>

" Quickly grep through files in directory tree
nmap <Leader>g :Rg<CR>

" Exit out of fzf buffer faster when using the escape key
autocmd! NeilAutocmdGroup FileType fzf tnoremap <buffer> <esc> <c-c>

" Key bindings to open fzf result in horizontal or vertical split
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Make fzf pop up in a window
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6 } }

" Make fzf ripgrep mode only search inside of files; don't search file paths
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
