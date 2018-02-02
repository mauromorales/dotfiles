" Plugins
call plug#begin('~/.vim/plugged')
" IDE like functionality
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug '907th/vim-auto-save'
" Ruby plugins 
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
Plug 'vim-scripts/Specky', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'haml', 'eruby'] }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
call plug#end()

" Vim config
set nocompatible
filetype plugin indent on
syntax on
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" IDE like Config
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>tt :TagbarToggle<CR>

" Ruby Config
:autocmd Filetype ruby set softtabstop=2
:autocmd Filetype ruby set sw=2
:autocmd Filetype ruby set ts=2
