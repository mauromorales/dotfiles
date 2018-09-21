" Plugins
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
" IDE like functionality
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug '907th/vim-auto-save'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gabesoft/vim-ags'
" Ruby plugins 
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
Plug 'vim-scripts/Specky', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'haml', 'eruby'] }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
" Go plugins 
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': ':make' }
" Elixir plugins
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
" Misc plugins
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-markdown'
Plug 'vimwiki/vimwiki'
Plug 'elzr/vim-json'
call plug#end()

" Vim config
set nocompatible
filetype plugin indent on
syntax on
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
set background=dark
colorscheme solarized
set relativenumber
set noshowmode

" IDE like Config
" deoplete.nvim recommend
set completeopt+=noselect

" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/local/bin/python3'
" Skip the check of neovim module
let g:python3_host_skip_check = 1

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1
" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:go_gocode_autobuild = 1
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <Leader>ct :!ripper-tags -R --exclude=vendor<CR>
nnoremap <Leader>ag :Ags
nnoremap <Leader>agw yiw :Ags <C-r>0<CR>
nnoremap <Leader>agl :AgsLast<CR>
nnoremap <Leader>agq :AgsQuit<CR>
let g:ags_enable_async = 1

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
let g:lightline.active = { 'right':  [
		    \            [ 'linter_errors', 'linter_warnings', 'linter_ok' ],
        \            [ 'lineinfo' ],
		    \            [ 'percent' ],
		    \            [ 'fileformat', 'fileencoding', 'filetype' ] 
        \            ] }

let g:ale_fixers = {
      \   'ruby': ['rubocop'],
      \}
let g:ale_fix_on_save = 1

" Ruby Config
augroup filetype_ruby
    autocmd!
    autocmd Filetype ruby set softtabstop=2
    autocmd Filetype ruby set sw=2
    autocmd Filetype ruby set ts=2
    autocmd Filetype ruby set expandtab
augroup END

" RSpec.vim mappings
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rn :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" Golang
nnoremap <Leader>giw yiw :GoImport <C-r>0<CR>

