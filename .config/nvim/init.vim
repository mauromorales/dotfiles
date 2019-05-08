" Plugins
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'endel/vim-github-colorscheme'
Plug 'fatih/molokai'
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
Plug 'tpope/vim-eunuch'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/gem-browse'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'matze/vim-move'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'ruanyl/vim-gh-line'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'gabesoft/vim-ags'
" Ruby plugins 
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
Plug 'vim-scripts/Specky', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'haml', 'eruby'] }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
Plug 'danchoi/ri.vim'
" Go plugins 
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': ':make' }
" JS plugins
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Elixir plugins
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
" Misc plugins
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
" Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()

" Vim config
set nocompatible
filetype plugin indent on
syntax on


set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set nonumber
set norelativenumber
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set autowrite
set autoread
set shiftround
set title
set linebreak
set colorcolumn=+1
set diffopt+=vertical


language en_US
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>cfp :let @* = expand("%")<cr>
set background=light
colorscheme solarized
" set number
" set noshowmode
au VimResized * :wincmd =
autocmd Filetype gitcommit setlocal spell textwidth=72
set backup
set noswapfile
set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set scrolloff=3
set hlsearch
set autowrite

nnoremap <leader>sbl :set background=light<CR>
nnoremap <leader>sbd :set background=dark<CR>
nnoremap <leader>ppj :%!ruby -r json -e 'puts JSON.pretty_generate(JSON.parse(ARGF.read))'<CR>

" IDE like Config
" deoplete.nvim recommend
set completeopt+=noselect
let g:ale_completion_enabled = 1
let g:ale_linter_aliases = {'pandoc': 'markdown'}

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
nnoremap <Leader>ct :!ripper-tags -R --exclude=vendor --exclude=node_modules<CR>
nnoremap <Leader>ag :Ags
nnoremap <Leader>agw yiw :Ags <C-r>0<CR>
nnoremap <Leader>agl :AgsLast<CR>
nnoremap <Leader>agq :AgsQuit<CR>
nnoremap <Leader>gf :vsplit <cfile><CR>
map <Leader>en :cnext<CR>
map <Leader>ep :cprevious<CR>
nnoremap <leader>ec :cclose<CR>

let g:ags_enable_async = 1

let g:lightline = {
      \ 'colorscheme': 'PaperColor'
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

let g:ale_fixers = {}
let g:ale_fix_on_save = 0

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Ruby Config
let g:ale_fixers.ruby = ['rubocop']
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

" Golang Config
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd FileType go nmap <leader>i  :GoImport <C-r>0<CR>
autocmd FileType go nmap <leader>a  :GoAlternate<CR>

" HTML Config
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
"let g:ale_fixers.html = ['tidy']

" JS Config
let g:javascript_plugin_flow = 1
let g:ale_fixers.javascript = ['eslint']
"let g:ctrlp_custom_ignore = '/node_modules\|/DS_Store\|/git'


" Misc Config

" Extensions
function! HTML2Markdown()
  call inputsave()
  let url = input('URL: ')
  call inputrestore()
  let markdown = system('pandoc -s -r html ' . url . ' -t markdown-smart')
endfunction

function! AddBookmark()
  call inputsave()
  let url = input('URL: ')
  call inputrestore()
  call inputsave()
  let fileName = input('Save to: ')
  call inputrestore()
  call system('pandoc -s -r html ' . url . ' -t markdown-smart -o ~/Dropbox/src/mrls/_bookmarkS/' . fileName)
endfunction

function! Convert2HTML()
  call system('pandoc -s --highlight-style tango -o ~/tmp/index.html ' . @%)
  call system('open ~/tmp/index.html')
endfunction

let g:pandoc#syntax#codeblocks#embeds#langs = ["Ruby", "javascript", "Go", "sh"]

augroup pandocHighlight
  autocmd!
  autocmd FileType pandoc syn region markdownHighlight matchgroup=htmlMarkTag start=/<mark>/ end=/<\/mark>/ concealends
  autocmd FileType pandoc hi link markdownHighlight Mark
  autocmd FileType pandoc hi Mark ctermbg=186 ctermfg=235
augroup END
