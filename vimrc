" Filip Hlasek (fhlasek) <filip@bluevisionlabs.com>
" Github page: https://github.com/fhlasek/.vim
"      __  _      _                    _
"     / _|| |__  ( |  __ _  ___   ___ | | __
"    | |_ |  _ \ | | / _` |/ __| / _ \| |/ /
"    |  _|| | | || || (_| |\__ \|  __/|   <
"    |_|  |_| |_||_| \__,_||___/ \___||_|\_\
"               _
"       __   __(_) _ __ ___   _ __  ___
"       \ \ / /| || '_ ` _ \ | '__|/ __|
"        \ V / | || | | | | || |  | (__
"         \_/  |_||_| |_| |_||_|   \___|
"

set nocompatible   " Vim is more useful without Vi compatibility
set backspace=eol,start,indent
set incsearch      " incremental search while typing
set hlsearch       " highlight all matches
set history=200    " how many entries may be stored in the history
set showcmd        " show command in the last line of the screen
set tabstop=2      " the width of the <TAB> character
set expandtab      " <TAB> is replaced by spaces
set shiftwidth=2   " affects what happens when you press >>, << or ==
set smartindent    " automatically insert a level of indentation in some cases
set autoindent     " copy the indentation from the previous line
set spelllang=en   " language used by spell check
set encoding=utf-8
set fileencodings=utf8,cp1250,latin2
set mouse=ar       " mouse enabled in all modes
set number         " display line numbers
set cursorline     " highlight the screen line of the cursor
set ruler          " show the line and column number
set laststatus=2   " the last window will always have a status line
set t_Co=256       " enable 256 colors
set scrolloff=5    " the number of lines to keep above and below the cursor
set splitbelow     " open new horizontal split panes to bottom
set splitright     " open new vertical split panes to right

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on

" gray colors: (black) 232, ..., 255 (white)
highlight Normal        ctermfg=255   ctermbg=232
highlight LineNr        ctermfg=241   ctermbg=234
highlight CursorLine                  ctermbg=233 cterm=NONE
highlight CursorLineNr  ctermfg=11
highlight SpellBad                    ctermbg=52
highlight SpellCap                    ctermbg=88
highlight Search                      ctermbg=245
highlight Comment       ctermfg=27
highlight Directory     ctermfg=27
highlight Pmenu         ctermfg=250   ctermbg=235
highlight PmenuSel      ctermfg=254   ctermbg=237
highlight DiffAdd                     ctermbg=10  cterm=bold
highlight DiffChange                  ctermbg=236
highlight DiffDelete                  ctermbg=88
highlight DiffText                    ctermbg=17  cterm=bold

" display invisible characters (tab must consist of two characters)
set list listchars=tab:>-,trail:.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" don't expand tabs in Makefiles and Dockerfiles
autocmd FileType make setlocal noexpandtab
autocmd BufNewFile,BufRead Dockerfile setlocal noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" I don't want to type <SHIFT>; aka : (one of the most common command)
nmap ; :

" hotkey for showing / hiding line numbers
nmap , :set invnumber<CR>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" split pane horizontally or vertically
map <Bar> :vsplit<Return>
map -     :split<Return>

" auto 'set paste' and 'set nopaste' (other option is to set pastetoggle=<F2>)
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" pane switching
map <Tab> <C-W>w

" buffer switching
nnoremap [C :bnext<CR>
nnoremap [D :bprevious<CR>
nmap = :b

" tabs switching
nmap <S-Left> :tabprevious<Return>
nmap <S-Right> :tabnext<Return>
imap <S-Left> <Esc>:tabprevious<Return>
imap <S-Right> <Esc>:tabnext<Return>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim plugins - included using Pathogen
if !empty(globpath(&runtimepath, 'bundle/vim-pathogen/autoload/pathogen.vim'))
  runtime bundle/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect()
  filetype plugin indent on
endif

if exists("g:loaded_pathogen")

  " NerdTree
  if &runtimepath =~ 'nerdtree'
    highlight def link NERDTreeRO NERDTreeFile
    let NERDTreeShowBookmarks=1
    " hotkeys for showing / hiding NerdTree
    nmap § :NERDTreeFocus<CR>
    nmap \\ :NERDTreeToggle<CR>
  endif

  " Syntastic
  if &runtimepath =~ 'syntastic'
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_enable_signs = 0

    let g:syntastic_python_flake8_exec = 'python3'
    let g:syntastic_python_flake8_args = ['-m', 'flake8']
    let g:syntastic_python_checkers=['python3', 'py3kwarn']
    let g:ycm_python_binary_path = '/usr/local/bin/python3'
  endif

  " Airline
  if &runtimepath =~ 'vim-airline'
    let g:airline_powerline_fonts=1
    let g:airline_symbols=get(g:, 'airline_symbols', {})
    let g:airline_symbols.maxlinenr=''
    let g:airline_symbols.linenr=''
    if !empty(globpath(&runtimepath, 'autoload/airline/themes/single_dark.vim'))
      let g:airline_theme='single_dark'
    endif
    " show the list of buffers
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#fnamemod = ':t' " show just the filename
    " set 'Airline friendly' font
    set guifont=Meslo\ LG\ M\ for\ Powerline:h11
  endif

  " YouCompleteMe
  if &runtimepath =~ 'YouCompleteMe'
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_goto_buffer_command = 'vertical-split'
    nnoremap f :YcmCompleter GoToDeclaration<Return>
    set completeopt-=preview " don't show preview on autocompletion
  endif

endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" load machine specific configuration
if filereadable(expand("~/.vimlocal.vim"))
  source ~/.vimlocal.vim
endif
