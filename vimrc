" .vimrc - vim configuration file
"
" Jonathan Toppins <jtoppins@users.sourceforge.net>
"

"" Must be first
if has('vim_starting')
	set nocompatible      " Use Vim settings
endif

"************************
"" Functions
"************************
"" Linux kernel spacing requirements
function SetLinuxKernelSpacing()
	set noexpandtab       " don't expand tabs to spaces
	set shiftwidth=8
	set softtabstop=8
	set ts=8
	set smarttab
endfunction

"************************
"" Encoding
"************************
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"************************
"" Tab settings
"************************
set backspace=indent,eol,start   " more powerful backspacing
call SetLinuxKernelSpacing()
set smarttab

"************************
"" Editor Defaults
"************************
set updatetime=200
set history=500		" keep 500 lines of command line history
set hidden		" Hide buffers when they are abandoned
set showcmd		" Show (partial) command in status line.
set autowrite		" Automatically save before commands like :next and
			"  :make
set autoread
set mouse=a		" Enable mouse usage (all modes)
" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
set nomodeline
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set fileformats=unix,dos,mac
set shell=/bin/sh

"" Visual Settings
syntax on
set lazyredraw
set showmatch		" Show matching brackets.
set ruler		" show the cursor position all the time
set scrolloff=2
set laststatus=2

"" Searching
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	set hlsearch
endif
set incsearch		" Incremental search
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc. Also load indent files, to
	" automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event
	" handler (happens when dropping a file on gvim).
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif

	augroup END
else
	set autoindent		" always set autoindenting on
endif " has("autocmd")

" Only do this part when compiled with support for cscope.
if has("cscope")
	set cscopetag           " map CTRL-] to search cscope db, see help tags
	set cscopetagorder=0    " search cscope db first then tags db
	set cscopeverbose       " print message when adding csc db fails
endif " has("cscope")

"************************
"" Theme Settings
"************************
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
colorscheme desert

"************************
"" Plugin Settings
"************************

"" vim-airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_close_button = 1 " 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = 'T'      " tabs label
let g:airline#extensions#tabline#buffers_label = 'B'   " buffers label
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 1    " show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
"let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 1       " enable tab numbers
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks =
	\  [ 'indent', 'trailing', 'long', 'mixed-indent-file', 'conflicts' ]
let g:airline_skip_empty_sections = 1

"" NERDTree
let g:NERDTreeMinimalUI = 1
let g:nerdtree_tabs_focus_on_files = 1
noremap <F2> :NERDTreeToggle<CR>
nnoremap <silent> <F3> :NERDTreeFind<CR>

"" ALE
let g:ale_completion_enabled = 1

"************************
"" Load Plugins
"************************

" Load all optional packages that we want the ability to selecte between
" like 'syntastic' and 'ale'
packadd minibufexpl.vim
packadd ale

" Load all plugins now.
packloadall

" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
