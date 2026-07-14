"==============================================================================
" General Settings
"==============================================================================

" Keep track of where our Vim settings directory is.
let $VIMHOME = expand("<sfile>:p:h")

"------------------------------------------------------------------------------
" Appearance
"------------------------------------------------------------------------------

set background=dark                  " Use dark colorschemes
colorscheme koehler

syntax enable                        " Enable syntax highlighting

set number                           " Show line numbers
set colorcolumn=130                  " Draw a guide at column 130
set nowrap                           " Do not wrap long lines

set ruler                            " Always show cursor position
set laststatus=2                     " Always display the status line
set title                            " Set the terminal title
set showcmd                          " Show partially entered commands
set mouse=a                          " Enable mouse support

"------------------------------------------------------------------------------
" Editing
"------------------------------------------------------------------------------

set nocompatible                     " Disable old Vi compatibility

set backspace=indent,eol,start       " Make Backspace behave normally
set whichwrap+=<,>,[,],h,l           " Allow cursor keys to wrap lines

set autoindent                       " Copy indentation from previous line
set copyindent

set tabstop=4                        " Display tabs as four spaces
set shiftwidth=4                     " Indentation width
set softtabstop=4                    " Backspace over expanded tabs
set expandtab                        " Convert tabs to spaces

set foldmethod=syntax                " Fold based on syntax
set foldlevelstart=100               " Open all folds by default

set scrolloff=5                      " Keep 5 lines visible around the cursor

set hidden                           " Allow switching buffers without saving

"------------------------------------------------------------------------------
" Files
"------------------------------------------------------------------------------

set nobackup                         " Do not create backup files
set nowritebackup
set noswapfile

set undodir=$VIMHOME/undo            " Persistent undo directory
set undofile

set history=20                       " Command history length

set fileformats=unix,dos,mac         " Support Unix, DOS, and Mac files

"------------------------------------------------------------------------------
" Searching
"------------------------------------------------------------------------------

set hlsearch                         " Highlight search results
set ignorecase                       " Ignore case...
set smartcase                        " ...unless uppercase is used
set incsearch                        " Incremental searching

set tags=tags;/                      " Search upward for tags files

set cscopetag                        " Search cscope and ctags
set csto=0                           " Search cscope before ctags

"------------------------------------------------------------------------------
" Completion
"------------------------------------------------------------------------------

set omnifunc=syntaxcomplete#Complete
set completeopt=menu,longest

set wildmode=list:full
set wildmenu

"------------------------------------------------------------------------------
" Formatting
"------------------------------------------------------------------------------

set lazyredraw                       " Redraw only when necessary
set formatoptions+=r                 " Continue comments on Enter

"------------------------------------------------------------------------------
" Clipboard
"------------------------------------------------------------------------------

set clipboard=unnamedplus            " Use the system clipboard

"------------------------------------------------------------------------------
" Optional whitespace visualization
"------------------------------------------------------------------------------

"set list                            " Show whitespace characters
"set listchars=tab:>-,trail:-

"------------------------------------------------------------------------------
" Cursor
"------------------------------------------------------------------------------

highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

"==============================================================================
" Keyboard Mappings
"==============================================================================

"------------------------------------------------------------------------------
" Leader key
"------------------------------------------------------------------------------

let mapleader=" "

"------------------------------------------------------------------------------
" Quick Escape
"------------------------------------------------------------------------------

inoremap jj <Esc>

"------------------------------------------------------------------------------
" Move by display lines
"------------------------------------------------------------------------------

nnoremap j gj
nnoremap k gk

"------------------------------------------------------------------------------
" Folding
"------------------------------------------------------------------------------

nnoremap zz <Esc>za

"------------------------------------------------------------------------------
" Keep visual selection while indenting
"------------------------------------------------------------------------------

vnoremap < <gv
vnoremap > >gv

"------------------------------------------------------------------------------
" Toggle search highlighting
"------------------------------------------------------------------------------

nnoremap <Leader>h :set hlsearch!<CR>

" Re-enable highlighting for new searches.
noremap * :set hlsearch<CR>:nohlsearch<CR>*
noremap / :set hlsearch<CR>:nohlsearch<CR>/
noremap ? :set hlsearch<CR>:nohlsearch<CR>?

"------------------------------------------------------------------------------
" Insert blank lines without entering Insert mode
"------------------------------------------------------------------------------

nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

"------------------------------------------------------------------------------
" Toggle line numbers
"------------------------------------------------------------------------------

nnoremap <Leader>n :set number!<CR>

"==============================================================================
" Terminal Cursor
"==============================================================================

" Use a line cursor in Insert mode and a block cursor elsewhere.
"
" Reference:
"   Ps = 0  -> blinking block
"   Ps = 1  -> blinking block (default)
"   Ps = 2  -> steady block
"   Ps = 3  -> blinking underline
"   Ps = 4  -> steady underline
"   Ps = 5  -> blinking bar
"   Ps = 6  -> steady bar

let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
