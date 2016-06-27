 "l Environment {
     " Basics {
         set nocompatible        " must be first line
         set background=dark     " Assume a dark background
     " }

     " Windows Compatible {
         " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
         " across (heterogeneous) systems easier. 
         if has('win32') || has('win64')
           set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
         endif
     " }
     
     " Setup Vim plugins via Vundle {
         filetype off
         set rtp+=~/.vim/bundle/Vundle.vim
         call vundle#begin()

         " This is the Vundle package, which can be found on GitHub.
         " For GitHub repos, you specify plugins using the
         " 'user/repository' format.  We include Vundle itself to
         " ensure it is always updated.
         Plugin 'gmarik/Vundle.vim'

         " Various other plugins
         "Plugin 'vim-scripts/cscope.vim'
         Plugin 'vim-scripts/autoload_cscope.vim'
         " Don't use the autoload cscope plugin's menus.
         let g:autoscope_menus = 0
         Plugin 'bling/vim-airline'
         Plugin 'vim-scripts/taglist.vim'
         Plugin 'Valloric/YouCompleteMe'
         "Global config for YCM
         let g:ycm_global_ycm_extra_conf = '/vagrant/cookbooks/vim-setup/.ycm_extra_conf.py'
         Plugin 'simplyzhao/cscope_maps.vim'
         Plugin 'tpope/vim-fugitive'
         Plugin 'rhysd/vim-clang-format'

         " Colorschemes
         Bundle 'tomasr/molokai'
         call vundle#end()
     " }

 " }
 
 " General {
     set background=dark         " Assume a dark background
     if !has('win32') && !has('win64')
         set term=$TERM       " Make arrow and other keys work
     endif
     filetype plugin indent on   " Automatically detect file types.
     syntax on                   " syntax highlighting
     set mouse=a                 " automatically enable mouse usage
     "set autochdir              " always switch to the current file directory.. Messes with some plugins, best left commented out
     " not every vim is compiled with this, use the following line instead
     " If you use command-t plugin, it conflicts with this, comment it out.
      "autocmd BufEnter \* if bufname("") !\~ "\^\\[A-Za-z0-9\\]\*://" | lcd %:p:h | endif
     scriptencoding utf-8

     " set autowrite                  " automatically write a file when leaving a modified buffer
     set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
     set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
     set virtualedit=onemore         " allow for cursor beyond last character
     set history=100                 " Store a ton of history (default is 20)
     "set spell                       " spell checking on      
     " Setting up the directories {
         set backup                      " backups are nice ...
         " Moved to function at bottom of the file
         "set backupdir=$HOME/.vimbackup//  " but not when they clog .
         "set directory=$HOME/.vimswap//     " Same for swap files
         "set viewdir=$HOME/.vimviews//  " same for view files
         
         "" Creating directories if they don't exist
         "silent execute '!mkdir -p $HVOME/.vimbackup'
         "silent execute '!mkdir -p $HOME/.vimswap'
         "silent execute '!mkdir -p $HOME/.vimviews'
         au BufWinLeave \* silent! mkview  "make vim save view (state) (folds, cursor, etc)
         au BufWinEnter \* silent! loadview "make vim load view (state) (folds, cursor, etc)
     " }
 " }

 " Vim UI {
     "color desert                 " load a colorscheme
     set tabpagemax=15               " only show 15 tabs
     set showmode                    " display the current mode

     set cursorline                  " highlight current line
     """hi cursorline guibg=\#333333     " highlight bg color of current line
     """hi CursorColumn guibg=\#333333   " highlight cursor

     if has('cmdline_info')
         set ruler                   " show the ruler
     """   set rulerformat=%30(%=\\:b%n%y%m%r%w\\ %l,%c%V\\ %P%) " a ruler on steroids
         set showcmd                 " show partial commands in status line and
                                     " selected characters/lines in visual mode
     endif

     if has('statusline')
         set laststatus=2 " tell VIM to always put a status line in, even if there is only one window

         " Broken down into easily includeable segments
         set statusline=%<%f\\   " Filename
         set statusline+=%w%h%m%r " Options
         """set statusline+=%{fugitive\#statusline()} "  Git Hotness
         """set statusline+=\\ [%{&ff}/%Y]            " filetype
         """set statusline+=\\ [%{getcwd()}]          " current dir
         "set statusline+=\\ [A=\\%03.3b/H=\\%02.2B] " ASCII / Hexadecimal value of char
         """set statusline+=%=%-14.(%l,%c%V%)\\ %p%%  " Right aligned file nav info
     endif

     set backspace=indent,eol,start  " backspace for dummys
     set linespace=0                 " No extra spaces between rows
     set nu                          " Line numbers on
     set showmatch                   " show matching brackets/parenthesis
     set incsearch                   " find as you type search
     set hlsearch                    " highlight search terms
     set winminheight=0              " windows can be 0 line high 
     set ignorecase                  " case insensitive search
     set smartcase                   " case sensitive when uc present
     set wildmenu                    " show list instead of just completing
     set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
     set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
     set scrolljump=5                " lines to scroll when cursor leaves screen
     set scrolloff=3                 " minimum lines to keep above and below cursor
     """set foldenable                  " auto fold code
     set gdefault                    " the /g flag on :s substitutions by default
     set list
     set listchars=tab:>.,trail:.,extends:\#,nbsp:. " Highlight problematic whitespace

 " }

 " Formatting {
     set nowrap                      " wrap long lines
     set autoindent                  " indent at the same level of the previous line
     set shiftwidth=4                " use indents of 4 spaces
     set expandtab                   " tabs are spaces, not tabs
     set tabstop=4                   " an indentation every four columns
     set softtabstop=4               " let backspace delete indent
     "set matchpairs+=<:>                " match, to be used with % 
     set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
     "set comments=sl:/\*,mb:\*,elx:\*/  " auto format comment blocks
     " Remove trailing whitespaces and \^M chars
     autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\\\s\\\\+$","","")'))
 " } 
 
" set the search scan to wrap lines
set wrapscan

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash

" Make command line two lines high
set ch=2

" set visual bell -- I hate that damned beeping
set vb

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

" Don't update the display while executing macros
set lazyredraw

" Show the current mode
set showmode

" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
" set guioptions=acg

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=1000

" Enable folding
" set foldenable
" set foldmethod=syntax

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Disable encryption (:X)
set key=

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 80 chars
set textwidth=80

" get rid of the silly characters in window separators
set fillchars=""

" Change the current working directory whenever you open a file,
" switch buffers, delete a buffer or open/close a window
set autochdir

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

" Turn off that stupid highlight search
nmap <silent> <leader>n :set invhls<CR>:set hls?<CR>

" Show all available VIM servers
nmap <silent> <leader>ss :echo serverlist()<CR>

" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line(".")<leader>col("."),1),"name")
            \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
            \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
            \ . ">"<CR>

" set text wrapping toggles
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" Run the command that was just yanked
nmap <silent> <leader>rc :@"<cr>

" Maps to make handling windows a bit easier
noremap <silent> <leader>h :wincmd h<CR>
noremap <silent> <leader>j :wincmd j<CR>
noremap <silent> <leader>k :wincmd k<CR>
noremap <silent> <leader>l :wincmd l<CR>
noremap <silent> <leader>sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> <leader>s8 :vertical resize 83<CR>
noremap <silent> <leader>cj :wincmd j<CR>:close<CR>
noremap <silent> <leader>ck :wincmd k<CR>:close<CR>
noremap <silent> <leader>ch :wincmd h<CR>:close<CR>
noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
noremap <silent> <leader>cc :close<CR>
noremap <silent> <leader>cw :cclose<CR>
noremap <silent> <leader>ml <C-W>L
noremap <silent> <leader>mk <C-W>K
noremap <silent> <leader>mh <C-W>H
noremap <silent> <leader>mj <C-W>J
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>

" Buffer commands
noremap <silent> <leader>bd :bd<CR>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh

" Highlight all instances of the current word under the cursor
nmap <silent> ^ :setl hls<CR>:let @/="<C-r><C-w>"<CR>

" Search the current file for what's currently in the search
" register and display matches
nmap <silent> <leader>gs
            \ :vimgrep /<C-r>// %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the word under the cursor and display matches
nmap <silent> <leader>gw
            \ :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Search the current file for the WORD under the cursor and display matches
nmap <silent> <leader>gW
            \ :vimgrep /<C-r><C-a>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:set nohls<CR>

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|set nohls<cr>

" Delete all buffers
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" I don't like it when the matching parens are automatically highlighted
" let loaded_matchparen = 1

" special 'save my session and exit' binding
nmap <F11> <Esc>:wa<CR>:mksession! ~/.vimsession<CR>:qa<CR>
nmap <F12> <Esc>:source ~/.vimsession<CR>

" Regenerate cscope database.  Make sure you're in the root directory of your
" project when running this!
nmap <F11> :!find `pwd` -type f -name "*.c" -o -name "*.h" -o -name "*.cpp" > cscope.files<CR>
  \:!cscope -b -i cscope.files -f cscope.out 2>/dev/null<CR>
  "\:!export CSCOPE_DB ="`pwd`/cscope.out"<CR>  
  "\:cs reset<CR>

" Launch BufExplorer
nnoremap <silent> <leader>b :BufExplorer<CR>

"-----------------------------------------------------------------------------
" Taglist Plugin
"-----------------------------------------------------------------------------
" Automatically update the taglist to include newly edited files. 
let Tlist_Auto_Update = 1

" Close the Taglist after selecting a tag
let Tlist_Close_On_Select = 1

" Open the window on the right hand side
let Tlist_Use_Right_Window = 1

" Change the width of the Taglist
let Tlist_WinWidth = 50

" Show the tags in the current buffer only
let Tlist_Show_One_File = 1

" Key bindings
nnoremap <silent> <F6> :TlistShowTag<CR>
nnoremap <silent> <F7> :TlistShowPrototype<CR>

" This binding is dependent on Tlist_Use_Right_Window
nnoremap <silent> <F8> :TlistToggle<CR>:wincmd l<CR>

"-----------------------------------------------------------------------------
" ctags location
"-----------------------------------------------------------------------------
if has('win32') || has('win64')
    "For Windows, ctags file is in an expected location
    set tags=C:\tools\vim_scripts\tags
else
    "For Linux, traverse up the directory to find the ctags file
    set tags=tags;
end

"-----------------------------------------------------------------------------
" clang-format for Vim setup
"-----------------------------------------------------------------------------
map <C-I> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<cr>
imap <C-I> <c-o>:pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<cr>

"-----------------------------------------------------------------------------
" Fix constant spelling mistakes
"-----------------------------------------------------------------------------
iab teh       the
iab Teh       The
iab taht      that
iab Taht      That
iab alos      also
iab Alos      Also
iab aslo      also
iab Aslo      Also
iab becuase   because
iab Becuase   Because
iab bianry    binary
iab Bianry    Binary
iab bianries  binaries
iab Bianries  Binaries
iab charcter  character
iab Charcter  Character
iab charcters characters
iab Charcters Characters
iab exmaple   example
iab Exmaple   Example
iab exmaples  examples
iab Exmaples  Examples
iab shoudl    should
iab Shoudl    Should
iab seperate  separate
iab Seperate  Separate
iab fone      phone
iab Fone      Phone

"-----------------------------------------------------------------------------
" My command line abbrevs
"-----------------------------------------------------------------------------
cabbrev junk e d:/temp/junk.txt

"-----------------------------------------------------------------------------
" Functions
"-----------------------------------------------------------------------------
function! RunSystemCall(systemcall)
    let output = system(a:systemcall)
    let output = substitute(output, "\n", '', 'g')
    return output
endfunction

function! Cleanup()
    set ff=unix
    %s/\s*$//
    ''
    %s/\t/    /g
    ''
endfunction

"-----------------------------------------------------------------------------
" My keymaps
"-----------------------------------------------------------------------------
map <silent> <F2> :call Cleanup()<CR>
map! <silent> <F2> :call Cleanup()<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>

"-----------------------------------------------------------------------------
" Neovim terminal bindings 
"-----------------------------------------------------------------------------
:tnoremap <Esc> <C-\><C-n>
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
    " GUI is running or is about to start.
    "set guifont=Droid\ Sans\ Mono:h10:cANSI
    set guifont=Droid\ Sans\ Mono
    " Maximize gvim window.
    "set lines=999 columns=999
    set lines=90 columns=170
    colorscheme molokai
elseif has("nvim")
    " nvim settings 
    set guifont=Droid\ Sans\ Mono
    " Maximize gvim window.
    "set lines=999 columns=999
    set lines=90 columns=170
    colorscheme molokai
else
    " This is console Vim.
    if exists("+lines")
        set lines=70
    endif
    if exists("+columns")
        set columns=150
    endif
    " colorschem desert
endif
:nohls

