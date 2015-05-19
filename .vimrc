"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       5.0 - 29/05/12 15:43:36
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Set encoding type
set encoding=utf8
"scriptencoding utf-8

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Always display line numbers
set nu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

colorscheme alpenwasser
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4


" Linebreak on 120 characters
set lbr
set tw=240

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" toggle invisibles
map <leader>l :set list!<CR>

" custom symbols for invisibles
set listchars=tab:➤\ ,eol:¬

""""""""""""""""""""""""""""""
" => Indentaion by File Type
""""""""""""""""""""""""""""""
if has("autocmd")
	filetype on

    " These filetypes are fussy about indentation
	autocmd FileType make setlocal ts=8 sts=4 sw=8 noexpandtab
	autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

    " Personal Preferences
    autocmd FileType c      setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType h      setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType cpp    setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType php    setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType txt    setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType css    setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType html   setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType perl   setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType python setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType json   setlocal ts=8 sts=8 sw=8 expandtab
endif

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <Space>j <C-W>j
map <Space>k <C-W>k
map <Space>h <C-W>h
map <Space>l <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Splits window horizontally with current buffer's path
map <leader>sh :split<c-r>=expand("%:p:h")<cr>/
" Splits window vertically with current buffer's path
map <leader>sv :vsplit<c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l 
set statusline=%F\                  "File path
set statusline+=%m\                 "modified flag
set statusline+=%{&ff}\ \           "file type
set statusline+=%=                  "left/right separator
set statusline+=Column\             "text
set statusline+=%v\ \ \             "column number
set statusline+=Line\               "text
set statusline+=%l/%L\ \ \          "cursor line/total lines
set statusline+=\ %P                "percent through file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Jump to beginning of line, regardless if non-blank or not
map 00 <HOME>

" Remap <Esc> and save to 'jk'
:imap jk <Esc>:w<CR>

" Remap <Esc> to 'jl'
:imap jl <Esc>

" Split a line into two lines before cursor position
" Source: http://stackoverflow.com/questions/624821/vim-split-line-command
:nnoremap K i<CR><Esc>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
" WHITELIST for deletion of trailing whitespace
" DO NOT use this command for every filetype. Some filetypes will break
" upon removal of trailing whitespace (.e.g. vimscript)
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.php :call DeleteTrailingWS()
autocmd BufWrite *.pl :call DeleteTrailingWS()
autocmd BufWrite *.pm :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.css :call DeleteTrailingWS()
autocmd BufWrite *.tex :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

map <leader>e :!%<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
" map <leader>q :e ~/buffer<cr>
" Quickly quit
map <leader>q :quit<cr>
map <leader>qq :quitall<cr>
" Quickly force-quit
map <leader>` :quit!<cr>
map <leader>`` :quitall!<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" format the current paragraph to 80 columns, justified
" vmap par :!par -jgw80<CR>
nmap <leader>a :.!par -ejgw78T4<CR>
vmap <leader>a :!par -ejgw78T4<CR>
nmap <leader>f :.!par -ejgw60T8<CR>
vmap <leader>f :!par -ejgw60T8<CR>

" LaTeX
map <leader>lt :!ltmko -f % -o<CR>
map <leader>ltd :!ltmko -f % -d<CR>
map <leader>ltc :!ltmko -f % -co<CR>

" nowrap
map <leader>nw :set nowrap!<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LaTeX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Replace Umlauts with their LaTeX counterparts:
map <leader>u :call Umlauts()<CR><CR>

function! Umlauts()
    :%s/Ä/\\\"A/gI 
    :%s/Ö/\\\"O/gI
    :%s/Ü/\\\"U/gI 
    :%s/ü/\\\"u/gI 
    :%s/ä/\\\"a/gI
    :%s/ö/\\\"o/gI
endfunction 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IDE Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd VimEnter * TlistOpen
autocmd VimEnter * vertical resize 40
autocmd VimEnter * wincmd p " move cursor to next buffer
autocmd VimEnter * NERDTree
autocmd VimEnter * vertical resize 40
autocmd VimEnter * wincmd p

let g:NERDTreeWinPos = "right"

" autocmd BufEnter * NERDTreeMirror
" autocmd TabEnter * NERDTreeMirror

autocmd TabEnter * TlistOpen
autocmd TabEnter * vertical resize 40
autocmd TabEnter * wincmd p
autocmd TabEnter * NERDTree
autocmd TabEnter * vertical resize 40
autocmd TabEnter * wincmd p

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_echo_current_error=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_aggregate_errors=1
let g:syntastic_id_checkers=1
let g:syntastic_python_checkers=['python', 'pyflakes']
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol="E>"
let g:syntastic_warning_symbol="W>"
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_sh_checkers = ['sh']

let g:SuperTabDefaultCompletionType = 'context'
autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
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
