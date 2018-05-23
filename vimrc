set number relativenumber
set ruler

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
