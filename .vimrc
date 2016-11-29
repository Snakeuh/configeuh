" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

"==============================================================================
"   Extensions
"==============================================================================

"------------------------------------------------------------------------------
"   Pathogen
"------------------------------------------------------------------------------

call pathogen#infect()
call pathogen#helptags()

"------------------------------------------------------------------------------
"   Syntastic
"------------------------------------------------------------------------------

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 2
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1

"------------------------------------------------------------------------------
"   TagBar
"------------------------------------------------------------------------------

" nnoremap <C-n> :TagbarToggle<CR>

"------------------------------------------------------------------------------
"   YouCompleteMe
"------------------------------------------------------------------------------

" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

"==============================================================================
"   Search mode
"==============================================================================

"------------------------------------------------------------------------------
"   Settings
"------------------------------------------------------------------------------

" Ignore case
set ignorecase

" Highlight previous search
set hlsearch

" Do not search while typing
set noincsearch

"------------------------------------------------------------------------------
"   Mappings
"------------------------------------------------------------------------------

" Block searching
vnoremap // y/<C-R>"<CR>

" No highlight
" nnoremap <C-L> :nohl<CR><C-L>

"==============================================================================
"   Command Mode
"==============================================================================

"------------------------------------------------------------------------------
"   Settings
"------------------------------------------------------------------------------

" Ctrl+v

set virtualedit=block

" Opposite of Shift-J
" nnoremap <C-J> ciW<CR><Esc>:if match( @", "^\\s*$") < 0<Bar>exec "norm P-$diw+"<Bar>endif<CR>

"------------------------------------------------------------------------------
"   Mappings
"------------------------------------------------------------------------------

" Remove EX mode
"unmap Q

" Formating
" map Q gq

" Enter whithout insert mode
nmap <A-o> o<Esc>k

"==============================================================================
"   Insert Mode
"==============================================================================

"------------------------------------------------------------------------------
"   Settings
"------------------------------------------------------------------------------

" Tab Settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"------------------------------------------------------------------------------
"   Mappings
"------------------------------------------------------------------------------

""" PageUp/Down

map <PageUp> k
map <PageDown> j
imap <PageUp> <UP>
imap <PageDown> <DOWN>

"------------------------------------------------------------------------------
"   Special characters
"------------------------------------------------------------------------------

""" Tabs

" Ignore in makefiles
autocmd FileType make setlocal noexpandtab

"==============================================================================
"   Environment
"==============================================================================

"------------------------------------------------------------------------------
"   Settings
"------------------------------------------------------------------------------

""" Buffers

" Ask confirmation before closing a modified buffer
set confirm

" Do not save the buffer automatically
set noautowriteall
set noautowrite

" No hidden buffers
set nohidden

" Clipboard buffer
" set clipboard=unnamed

""" Mouse
" No mouse
set mouse=

""" Audio

" No beep
set visualbell
set t_vb=

""" Command line

" Show the current 'combot' in the command line
set showcmd

" Redraw only when necessary
set lazyredraw

" Show matching bracket
set showmatch

"------------------------------------------------------------------------------
"   Folding
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"   Splits
"------------------------------------------------------------------------------

" Move split tiles
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""" Settings
set splitbelow
set splitright

"------------------------------------------------------------------------------
"   Tabs
"------------------------------------------------------------------------------

""" Settings
" Maximum number of tab pages
set tabpagemax=100

""" Tabs to splits
function! VspN()
  tabnext
  let var = expand('%')
  tabclose
  tabprevious
  execute "vsplit" . var
endfunction
function! VspP()
  tabprevious
  let var = expand('%')
  tabclose
  tabnext
  execute "vsplit" . var
endfunction
function! SpN()
  tabnext
  let var = expand('%')
  tabclose
  tabprevious
  execute "split" . var
endfunction
function! SpP()
  tabprevious
  let var = expand('%')
  tabclose
  tabnext
  execute "split" . var
endfunction

command Tabvspp  call VspP()
command Tabvsp   call VspN()
command Tabspp   call SpP()
command Tabsp    call SpN()

" Diff tabs
function! DVspN()
  call VspN()
  windo diffthis
endfunction
function! DVspP()
  call VspP()
  windo diffthis
endfunction
function! DSpN()
  call SpN()
  windo diffthis
endfunction
function! DSpP()
  call SpP()
  windo diffthis
endfunction

command DiffTabNext       call DVspP()
command DiffTabPrevious   call DVspN()
command DiffVTabNext      call DSpP()
command DiffVTabPrevious  call DSpN()

" Move tab
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>
nnoremap <S-F8> :tabmove +1<CR>
nnoremap <S-F7> :tabmove -1<CR>

"==============================================================================
"   StatusBar
"==============================================================================

"------------------------------------------------------------------------------
"   Functions
"------------------------------------------------------------------------------
function! IsFugitive()
    let l:path = expand('%')
    if l:path == ""
        return ""
    endif
    if split(l:path,":")[0] == "fugitive"
        set nomodifiable
        set ro
        return "F"
    endif
    return ""
endfunction

function! IsModified()
    if !&modifiable
        return "[" . IsFugitive() ."-]"
    elseif &mod
        return "[" . IsFugitive() ."+]"
    endif
    return "[" . IsFugitive() ." ]"
endfunction

"------------------------------------------------------------------------------
"   Constants
"------------------------------------------------------------------------------
set noruler
set laststatus=2
set statusline=

"------------------------------------------------------------------------------
"   Left
"------------------------------------------------------------------------------

set statusline+=%{IsModified()}:    " Modified? / Readonly ?
set statusline+=%-60.60F            " File Path

"------------------------------------------------------------------------------
"   Right
"------------------------------------------------------------------------------
set statusline+=%=                  " Right side
set statusline+=%03c\ :%03v\        " XXX
set statusline+=%04l/%04L[%P]       " Current line / Total lines

"==============================================================================
"   Cosmetic
"==============================================================================

syntax on
syntax enable

"------------------------------------------------------------------------------
"   Settings
"------------------------------------------------------------------------------

" Obvious
set number
set relativenumber

" Tab menu
set wildmenu
set wildmode=list:longest

"------------------------------------------------------------------------------
"   Colors
"------------------------------------------------------------------------------

" Background
set background=dark
colors jellybeans
"colorscheme solarized
"colorscheme mustang

" Columns
set colorcolumn=80

"------------------------------------------------------------------------------
"   Highlighting
"------------------------------------------------------------------------------
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
:autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
:autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
:autocmd InsertLeave * match ExtraWhitespace /\s\+$/

":highlight Goil_RightCommand ctermbg=blue guibg=blue
":syntax region Goil_Command start="/if/" end="/end/"
":autocmd BufWinEnter * match Goil_Command /if/
":autocmd InsertEnter * match Goil_Command /if/
":autocmd InsertLeave * match Goil_Command /if/

" :highlight HighlightTab ctermbg=blue guibg=blue
" :match HighlightTab /\t\+/
" :autocmd BufWinEnter * match HighlightTab /\t\+/
" :autocmd InsertLeave * match HighlightTab /\t\+/

:autocmd BufWinLeave * call clearmatches()

"------------------------------------------------------------------------------
"   Invisible characters
"------------------------------------------------------------------------------
set list
set listchars=tab:▸·,nbsp:⏎

"------------------------------------------------------------------------------
"   Tools
"------------------------------------------------------------------------------

" Autocorrect
map <silent> <F9> "<Esc>:silent setlocal spell! spelllang=fr<CR>"

" Type ?
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"==============================================================================
"   Abandonned
"==============================================================================

"let ccvar = '*'
"
"" Center and comment
"function! CenterComment()
"    execute 's/\(.*\)/\' . g:ccvar . '&\' . g:ccvar . '/'
"    noh
"endfunction
"
"function! SetCenterComment()
"    let g:ccvar = nr2char(getchar())
"endfunction
"
"map <C-n> :call CenterComment()<CR>
"map <C-w> :call SetCenterComment()<CR>

"==============================================================================
"   Unsorted
"==============================================================================

nnoremap j gj
nnoremap k gk

nnoremap gV `[v`]




