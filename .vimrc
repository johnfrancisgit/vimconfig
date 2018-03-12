" Vundle plugin manager
" #####################

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins to be automatically installed with Vundle plugin manager
" (plugins are automatically downloaded from github)
" we use jedi-vim for code completion because rope (included in python-mode)
" sucks
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
" Bundle 'klen/python-mode'
" Bundle 'davidhalter/jedi-vim'
Bundle 'kien/ctrlp.vim'
" Note that syntastic requires flake8 or pylint to be pip-installed
" Plugin 'scrooloose/syntastic'
" type F7 to run flake8 on a buffer
Plugin 'nvie/vim-flake8'
" show indentation: activate with <leader>ig
Plugin 'nathanaelkane/vim-indent-guides'
" PEP8 indent
Plugin 'hynek/vim-python-pep8-indent'

" git integration
" plugin that shows a git diff in the gutter (sign column)
Plugin 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'

" Javascript
" Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
" Plugin 'ternjs/tern_for_vim'

" Colorschemes galore
" Bundle 'flazz/vim-colorschemes'
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" General stuff
" #############

" set desired colorscheme
" colorscheme molokai
set background=dark
colorscheme gruvbox
let g:gruvbox_italic = 1
" let g:gruvbox_contrast_dark = 'hard'


" Set clipboard to global - allows you to copy between terminals 
set clipboard=unnamedplus

" Show line numbers
set number

syntax on
" no line wrapping
set nowrap
" size of a hard tabstop
set tabstop=4
" size of an "indent"
set shiftwidth=4
" always uses spaces instead of tab characters
set expandtab
set encoding=utf-8
" allow use of mouse"
set mouse=a

" show tabs
set list
set listchars=tab:>-

" Will hightlight word under cursor when * is pressed
" * goes to next occurrence, # to previous occurrence
set hlsearch

" automatically change window's cwd to file's dir
set autochdir

" code folding (press 'za' to toggle)
set foldmethod=indent
set foldlevel=99
" enable folding with spacebar
nnoremap <space> za

" F5 removes all trailing whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" make backspaces more powerfull
set backspace=indent,eol,start

" filetype specific stuff
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2

" remap Ctrl+j and Ctrl+k
map <C-J> <C-E>
map <C-K> <C-Y>

" capital W saves a file 
command! W write

" ruler at column 80                                                            
set colorcolumn=80 

" Highlight cursor line when in insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Set Python ipdb breakpoint
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

" NERD_tree config
" ################
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$', 'pycache__$', '\.gz$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
autocmd VimEnter * NERDTree /home/jm/workspace/
" map <F3> :NERDTreeToggle<CR>
" nnoremap <F3> :NERDTreeToggle /home/rg/workspace/<CR>


" python-mode config
" ##################

" vim needs to be compiled with python3
" let g:pymode_python = 'python3'
" disable rope (sucks) => use jedi-vim instead for code completion
" let g:pymode_rope = 0
" " enable setting breakpoints
" let g:pymode_breakpoint = 1
" " set breakpoints by typing \b
" let g:pymode_breakpoint_bind = '<leader>b'
" " Manually set ipdb breakpoint command (leave empty for automatic detection)
" let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # ### BREAKPOINT'
" " maximum line length
" let g:pymode_options_max_line_length = 79
" " hide 'line too long', 'too many local variables', 'unnecessary parens',
" " '... is too complex' errors
" let g:pymode_lint_ignore = "E501,R0914,C0301,C0325,C901"
" " use Python3 syntax => vim needs to be compiled with python3: vim --version | grep python
" " let g:pymode_python = 'python3'
" " set code checkers (possible values: `pylint`, `pep8`, `mccabe`, `pep257`,
" " `pyflakes`)
" let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8', 'mccabe']
" pylint is very strict, you may want to deactivate it :-)
" let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']

" syntastic config
" ################
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']

" powerline plugin
" => sudo pip3 install powerline-status
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" python with virtualenv support
py3 << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
