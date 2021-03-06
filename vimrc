" ============================================================================ "
" vimrc                                                                        "
" ============================================================================ "
"
"  Author: alpenwasser, webmaster@alpenwasser.net
"  Date: December 2016
"        December 2017

set shell=/bin/sh

" ---------------------------------------------------------------------------- "
" Vundle                                                                       "
" ---------------------------------------------------------------------------- "
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'severin-lemaignan/vim-minimap'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'troydm/easytree.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'ervandew/matchem'
"Plugin 'tomtom/tcomment_vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'machakann/vim-highlightedyank'
Plugin 'terryma/vim-multiple-cursors'
Bundle 'matze/vim-move'
"Plugin 'unblevable/quick-scope'
"Plugin 'sjurgemeyer/vim-tabspace'
"Plugin 'ScreenShot'
"Plugin 'google/vim-syncopate'
Bundle 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'dag/vim-fish'


call vundle#end()            " required
filetype plugin indent on    " required


" ---------------------------------------------------------------------------- "
" Other Plugin Stuff (Non-Vundle)                                              "
" ---------------------------------------------------------------------------- "
let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_confirm_extra_conf = 0

let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger="<s-cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"let g:SuperTabCrMapping = 0


" ---------------------------------------------------------------------------- "
" General Options                                                              "
" ---------------------------------------------------------------------------- "
syntax enable
set history=1000
set encoding=utf8
set nobackup
set nowb
set noswapfile
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set ffs=unix,dos,mac
map y <Plug>(highlightedyank)

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Return to last edit position when opening files -------- "
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close -------------- "
set viminfo^=%


" ---------------------------------------------------------------------------- "
" User Interface                                                               "
" ---------------------------------------------------------------------------- "

if has("gui_running")
    "colorscheme corporation
    colorscheme badwolf
else
    colorscheme gruvbox
    set background=dark
endif

set tw=1024
set ruler
set nu
set wildmenu
set listchars=tab:➤\ ,eol:¬

" Do not display button bar in gvim
set guioptions-=T
set so=4

" Always Show the Status Line
set laststatus=2

" Don't redraw while executing macros (good performance config)
set lazyredraw

map <space>e :EasyTreeToggle<cr>

" Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='kalisi'

" Set GVim Font ------------------------------------------ "
if has("gui_running")
    if has("gui_gtk2")
        set guifont=Source\ Code\ Pro\ for\ Powerline\ Regular\ 11
    elseif has("gui_gtk3")
        set guifont=Source\ Code\ Pro\ for\ Powerline\ Regular\ 11
  endif
endif


" ---------------------------------------------------------------------------- "
" Keyboard Shortcuts                                                           "
" ---------------------------------------------------------------------------- "
let mapleader   = ";"
let g:mapleader = ";"

" Movement ---------------------------------------------- "
" Move to first non-blank character on line
map 0 ^
" Jump to beginning of line, regardless if non-blank or not
map 00 <HOME>
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" Wrapping long lines or not
map <leader>nw :set nowrap!<CR>
" PageUp/PageDown
map <Space>f :call smooth_scroll#down(&scroll, 10, 2)<CR>
map <Space>d :call smooth_scroll#up(&scroll, 10, 2)<CR>

" Split a line into two lines before cursor position ----- "
" Source: http://stackoverflow.com/questions/624821/vim-split-line-command
:nnoremap K i<CR><Esc>

" General ------------------------------------------------ "
nmap <leader>w :w!<CR>
nmap <leader>l :set list!<CR>
imap jk <Esc>:w<CR>
imap jl <Esc>

" Moving between windows --------------------------------- "
nmap <Space>j <C-W>j
nmap <Space>k <C-W>k
nmap <Space>h <C-W>h
nmap <Space>l <C-W>l

" Quickly quit ------------------------------------------- "
map <leader>q :quit<CR>
map <leader>qq :quitall<CR>
" Quickly force-quit ------------------------------------- "
map <leader>` :quit!<CR>
map <leader>`` :quitall!<CR>

" Paragraph Formatting with Par -------------------------- "
nmap <leader>a :.!par -ejgw78T4<CR>
vmap <leader>a :!par -ejgw78T4<CR>
nmap <leader>f :.!par -ejgw60T4<CR>
vmap <leader>f :!par -ejgw60T4<CR>

" Toggle paste mode ON and OFF --------------------------- "
nmap <leader>pp :setlocal paste!<cr>

" Vim-Multiple-Cursors ----------------------------------- "
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-l>'


" Because leader has been mapped to ;, remap it to ' ----- "
nnoremap ' ;


" ---------------------------------------------------------------------------- "
" Coding                                                                       "
" ---------------------------------------------------------------------------- "

" Indentation, Tabs etc. --------------------------------- "
set expandtab
set ai   "Auto indent
set si   "Smart indent
set wrap "Wrap lines
set sw=4
set ts=4


if has("autocmd")
    filetype on

    " These filetypes are fussy about indentation
    autocmd FileType make     setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType automake setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml     setlocal ts=4 sts=4 sw=4 expandtab

    " Personal Preferences
    autocmd FileType c      setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType h      setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType cpp    setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType php    setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType txt    setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType css    setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType html   setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType perl   setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType json   setlocal ts=8 sts=8 sw=8 expandtab
    autocmd FileType tex    setlocal ts=4 sts=4 sw=4 expandtab
endif

" Force Syntax Highlighting for LaTeX Class Files -------- "
au BufReadPost *.cls set filetype=tex
" same for tikz files
au BufReadPost *.tikz set filetype=tex

" General ------------------------------------------------ "
nmap <Space>m :!make<CR>

" LaTeX -------------------------------------------------- "
function! Umlauts()
    :%s/Ä/\\\"A/gI
    :%s/Ö/\\\"O/gI
    :%s/Ü/\\\"U/gI
    :%s/ü/\\\"u/gI
    :%s/ä/\\\"a/gI
    :%s/ö/\\\"o/gI
endfunction


" ---------------------------------------------------------------------------- "
" Buffers, Splits, Tabs etc.
" ---------------------------------------------------------------------------- "

set splitright

map <leader>tq :tabclose<cr>
map <leader>tn :tabnew<cr>

map <leader>bd :Bclose<cr>

" Opens a new buffer with the current buffer's path
map <leader>e :edit <c-r>=expand("%:p:h")<cr>/
" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Splits window horizontally with current buffer's path
map <leader>sh :split<c-r>=expand("%:p:h")<cr>/
" Splits window vertically with current buffer's path
map <leader>sv :vsplit<c-r>=expand("%:p:h")<cr>/

" Splits window horizontally with current buffer
map <space>sh :new<cr>
" Splits window vertically with current buffer
map <space>sv :vnew<cr>

" Don't Close Window When Deleting a Buffer -------------- "
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


" ---------------------------------------------------------------------------- "
" Crap Which Has To Be At The End Or Else Shit Will Break
" ---------------------------------------------------------------------------- "
set cursorline
nmap <leader>c :set cursorline! cursorcolumn!<cr>
nmap <leader>cl :set cursorline!<cr>
nmap <leader>cc :set cursorcolumn!<cr>


map <leader>m :MinimapToggle<cr>
