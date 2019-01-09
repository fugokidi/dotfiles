call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'alok/notational-fzf-vim'
Plug 'jremmen/vim-ripgrep'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END
call plug#end()

" Basic settings
set ttyfast " indicates fast terminal connection
set laststatus=2 " always show statusline
set encoding=utf-8
set autoread " when the file is changed outside, not yet in vim, read it again
set autoindent
" infer the indentation of the next line
set smartindent
" copy the indentation structure of current line to the next line
set copyindent
set backspace=indent,eol,start " make backspace as backspace
set hlsearch   " highlight searches
set incsearch  " incremental searching
set tabstop=2 " the width of the tab character
set shiftwidth=2 " the amount of space to be shifted in indentation
set softtabstop=2 " fine tune the amount of space to be inserted/deleted
set shiftround " use multiple of shiftwidth
set expandtab  " use space for tab
set smarttab
set noerrorbells
set visualbell
set t_vb=
silent! set ttymouse=xterm2
set mouse=a                     "Enable mouse mode
set number                        " show number ruler
set showcmd " show partial command in the last line of the screen
set noswapfile
set nobackup
set equalalways
set splitbelow
set splitright
set hidden " switch buffer without saving
set autowrite                " Automatically save before :next, :make etc.
set noshowmatch              " Do not show matching brackets by flickering
set nocursorcolumn
set nocursorline
set ignorecase " ignore case for searching
set smartcase  " do case-sensitive if there's a capital letter
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set completeopt=menu,menuone
set pumheight=10             " Completion window max size
set lazyredraw " redraw only when the commands are typed
set list " see the difference between tabs and space and trailing blanks
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮
set fillchars+=vert:│
set virtualedit=block " allow virtual editing in visual block mode
set nojoinspaces " don't insert 2 spaces after a .,?,! with a join command
set diffopt=filler,vertical " start diff mode with vertical split
set foldlevelstart=99 " no folds closed when starting to edit
set formatoptions+=1j " don't break a line after a one-letter word and correct comment joining
set nostartofline " keep the cursor on the same column
set timeoutlen=500
"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus
" ~/.viminfo needs to be writable and readable
set viminfo='200
if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif
set grepprg=rg\ --vimgrep
syntax enable
set t_Co=256
let g:gruvbox_contrast_dark = 'soft'
set background=dark
colorscheme gruvbox
" from junegunn
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'
  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()
" proper syntax highlighting for shell scripts
let g:is_posix = 1

" NAVIGATION
" :map and :noremap are recursive and non-recursive versions of mappings
" for example
" :map j gg
" :map Q j
" :noremap W j
" j and Q will be mapped to gg and W will be mapped to j because j will not be
" expanded for non-recursive mappings
" Ref: https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
" from junegunn
nnoremap <tab>   <C-w>w
nnoremap <S-tab> <C-w>W
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" from fatih
nnoremap <leader>o :only<CR>
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv
" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz
" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_
" moving up and down by function, unfolding current function and fold the rest
noremap [[  [[zMzvz.
noremap ]]  ]]zMzvz.
" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

" MAPPINGS
let mapleader=","
nnoremap <leader>n :NERDTreeToggle<cr>

" Save and Quit
inoremap <silent> <C-s> <C-o>:execute("wall \| nohlsearch")<cr>
nnoremap <silent> <C-s> :execute("wall \| nohlsearch")<cr>
inoremap <C-q> <C-o>:wqall!<cr>
nnoremap <C-q> :wqall!<cr>
nnoremap <leader>q :q!<cr>
nnoremap <leader>w :w!<cr>
nnoremap \q :nohlsearch<cr>:call clearmatches()<cr>

nnoremap <silent> <F5> :source $MYVIMRC<CR>

" yank a line, act like D and C
nnoremap Y y$
" disable it at the moment
nnoremap Q <Nop>

vnoremap < <gv
vnoremap > >gv

" Escaping
inoremap jk <esc>
cnoremap jk <C-c>
vnoremap <C-q> <esc>

" word count in tex, don't remember from where I stole it.
function! WC()
  let filename = expand("%")
  let cmd = "detex " . filename . " | wc -w | perl -pe 'chomp; s/ +//;'"
  let result = system(cmd)
  echo result . " words"
endfunction

" fzf
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>f :Buffers<CR>
nnoremap <silent> <Leader>l :Files ~/Dropbox/Log<CR>

" notational-fzf-vim
let g:nv_search_paths = ['~/Dropbox/Log']
let g:nv_create_note_window = 'edit'
nnoremap <silent> <c-l> :NV<CR>

" :Date
command! Date :norm! i<C-R>=strftime("%y/%m/%d")<CR>
