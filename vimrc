if &compatible
  set nocompatible
endif
if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('morhetz/gruvbox')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('w0rp/ale')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('Chiel92/vim-autoformat')
  call minpac#add('ervandew/supertab')
  call minpac#add('SirVer/ultisnips')
  call minpac#add('honza/vim-snippets')
  call minpac#add('jremmen/vim-ripgrep')
  call minpac#add('gorkunov/smartpairs.vim')
  call minpac#add('junegunn/fzf', {'do': './install --all'})
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('alok/notational-fzf-vim')
  call minpac#add('skywind3000/asyncrun.vim')
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('godlygeek/tabular')
  call minpac#add('plasticboy/vim-markdown')
  call minpac#add('elzr/vim-json')
  call minpac#add('dhruvasagar/vim-table-mode')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('tpope/vim-surround')
  call minpac#add('lervag/vimtex')
  call minpac#add('Glench/Vim-Jinja2-Syntax')

  if has('nvim')
    call minpac#add('Shougo/deoplete.nvim')
    call minpac#add('zchee/deoplete-go', {'do': 'silent! !make'})
    call minpac#add('zchee/deoplete-jedi')
  endif
endif

filetype off
filetype plugin indent on
set ttyfast " indicates fast terminal connection

if !has('nvim')
  set ttymouse=xterm2 " enable mouse
  set ttyscroll=3
endif

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
" When at 3 spaces and I hit >>, go to 4, not 5.
set shiftround " use multiple of shiftwidth
set expandtab  " use space for tab
set smarttab

set noerrorbells
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

" color
syntax enable
set t_Co=256

let g:gruvbox_contrast_dark = 'soft'
set background=dark
colorscheme gruvbox

augroup filetypedetect
  command! -nargs=* -complete=help Help vertical belowright help <args>
  autocmd FileType help wincmd L

  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=2 sw=2
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2

  autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
  autocmd FileType gitcommit setlocal spell nolist textwidth=72
  autocmd FileType c,cpp setlocal sts=4 ts=4 sw=4 shiftround
  " Remove trailing white spaces on save
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

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

let mapleader=","
" :map and :noremap are recursive and non-recursive versions of mappings
" for example
" :map j gg
" :map Q j
" :noremap W j
" j and Q will be mapped to gg and W will be mapped to j because j will not be
" expanded for non-recursive mappings
" Ref: https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping

nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>
nnoremap <leader>s <C-w>w
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>
nnoremap <leader><space> :nohlsearch<CR>
" Close all but the current one
nnoremap <leader>o :only<CR>
" Center the screen
nnoremap <space> zz

" Source (reload configuration)
nnoremap <silent> <F5> :source $MYVIMRC<CR>

nnoremap <F6> :setlocal spell! spell?<CR>

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

" Act like D and C
nnoremap Y y$

" moving up and down by function, unfolding current function and fold the rest
noremap [[  [[zMzvz.
noremap ]]  ]]zMzvz.

" disable it at the moment
nnoremap Q <Nop>

vnoremap < <gv
vnoremap > >gv

" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
if !has('gui_running')
  set notimeout
  set ttimeout
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Escaping
imap jk <Esc>

" word count in tex
function! WC()
  let filename = expand("%")
  let cmd = "detex " . filename . " | wc -w | perl -pe 'chomp; s/ +//;'"
  let result = system(cmd)
  echo result . " words"
endfunction

" compile and view latex
" nnoremap <leader>c :w<CR>:!rubber --pdf --warn all %<CR>
" nnoremap <leader>v :!evince %:r.pdf &<CR><CR>

" Plugin settings here.
" ale
let g:ale_linters = {
\   'c': [],
\   'cpp': [],
\   'python': ['flake8'],
\}
let g:ale_fixers = [
\   'remove_trailing_lines',
\   'isort',
\   'ale#fixers#generic_python#BreakUpLongLines',
\   'yapf',
\]
let g:ale_lint_delay = 1000
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <Leader>ts :ALEToggle<CR>
nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<CR>

" fzf
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

nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>f :Buffers<CR>
nnoremap <silent> <Leader>l :Files ~/Dropbox/Log<CR>

" notational-fzf-vim
let g:nv_search_paths = ['~/Dropbox/Log']
nnoremap <silent> <c-l> :NV<CR>

" vim-autoformat
nnoremap <leader>= :Autoformat<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="horizontal"
let g:ultisnips_python_style = 'sphinx'
let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/Dropbox/mysnippets']

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_conceal = 0

" vim-jason
let g:vim_json_syntax_conceal = 0

" asyncrun
nnoremap <F9> :call <SID>compile_and_run()<CR>
let g:asyncrun_open = 15
function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    endif
endfunction
" c++
" map <F9> :w<cr>:!g++ % -g && (ulimit -c unlimited; ./a.out) <cr>
" map <F10> :w<cr>:!g++ % -g && (ulimit -c unlimited; ./a.out < ~/input.txt) <cr>
" map <F12> :!gdb ./a.out -c core <CR>

" fugitive
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>

" deoplete and neocomplete
if has('nvim')
  let g:python_host_prog = '/home/dai/virtualenvs/neovim2/bin/python'
  let g:python3_host_prog = '/home/dai/virtualenvs/neovim3/bin/python'
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
  let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
  let g:deoplete#sources#go#align_class = 1
endif

" vinegar
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" table-mode | <Leader>tm table mode toggle
let g:table_mode_corner='|'

" vim-sneak
let g:sneak#label = 1

" :MDY 06/14/18
command! MDY :norm! i<C-R>=strftime("%m/%d/%y")<CR>
" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
