" Plugins {{{
  call plug#begin('~/.config/nvim/plugged')

    " Colorschemes
    Plug 'morhetz/gruvbox'
    Plug 'fenetikm/falcon'
    Plug 'cocopon/iceberg.vim/'
    Plug 'ajmwagar/vim-deus'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'luochen1990/rainbow'
    Plug 'srcery-colors/srcery-vim'
    Plug 'cideM/yui'
    Plug 'pgdouyon/vim-yin-yang'
    "-----

    Plug '/usr/local/bin/fzf'
    Plug 'alok/notational-fzf-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'edkolev/tmuxline.vim'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mattn/emmet-vim'
    Plug 'mcchrish/nnn.vim'
    Plug 'metakirby5/codi.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rhysd/git-messenger.vim'
    Plug 'svermeulen/vim-yoink'
    Plug 'tomtom/tcomment_vim'               " file-type sensible comments
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'

    Plug 'tpope/vim-eunuch'
    Plug 'liuchengxu/eleline.vim'
    Plug 'liuchengxu/vista.vim'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mhinz/vim-startify'

    " Language
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'alampros/vim-styled-jsx'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax' 
    Plug 'rafcamlet/nvim-luapad'
    Plug 'sheerun/vim-polyglot'
    Plug 'othree/javascript-libraries-syntax.vim'
    Plug 'honza/vim-snippets'
    " --------

  call plug#end()
" }}}

" Set Declarations {{{
  filetype indent on
  filetype plugin indent on

  highlight Comment cterm=italic

  let g:nv_search_paths =['~/Google Drive/Notes']
  let g:nv_create_note_key = 'ctrl-x'
  let g:python3_host_prog='/usr/local/bin/python3'
  hi SpellBad gui=undercurl guisp=red term=undercurl cterm=undercurl

  " set shellcmdflag=-ic                              " make Vim’s :! shell behave like your command prompt.
                                                    " https://stackoverflow.com/a/4642855/10926788
  set autoread                                      " if file changes outside of vim, redraw buffer
  set splitright
  set previewheight=8
  set diffopt+=vertical
  set encoding=utf8
  set expandtab
  set foldmethod=syntax
  set formatoptions+=j                              " delete comment character when joining commented lines
  set gdefault                                      " set global flag as default for :substitute
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set hidden                                        " enable multiple unsaved buffers to be maintained
  set ignorecase
  set inccommand=nosplit
  set laststatus=2                                  " always show the statusline
  set lazyredraw
  set linebreak
  set listchars=tab:>-,trail:~,extends:>,precedes:<,eol:↩
  set mouse=a
  set nofoldenable
  " set nomodeline
  set noshowmode
  set noswapfile
  " set number  " -- the line number is in the bottom right
  set relativenumber
  set rtp+=/usr/local/opt/fzf
  set ruler
  set shiftwidth=2
  set showcmd
  set smartcase
  set smartindent
  set softtabstop=2
  set tabstop=2
  set termguicolors
  set timeoutlen=300
  set undofile
  set wildignorecase                                " case insensitive filename completion
  set visualbell
  set nowrap
  syntax enable

  " Misspellings
  iabbrev improt import
  iabbrev lgo log
" }}}

" Mappings {{{
  let mapleader=','

  let g:rg_highlight='true'
  let g:rg_derive_root='true'

  " nmap tt :call helpers#SwapTestFile()<CR>
  nnoremap tt :Tags<cr>
  nnoremap bt :BTags<cr>
  nnoremap 0 ^
  nnoremap <leader><space> :b#<CR>    " switch to last buffer
  nnoremap <leader>N :NV<CR>
  nnoremap <leader>O :call helpers#DeleteHiddenBuffers()<CR>
  nnoremap <leader>e :e ~/.config/nvim/init.vim<CR>
  nnoremap <leader>n :nohl<CR>
  nnoremap <leader>o :only<CR>
  nnoremap <leader>q :bd<CR>
  nnoremap <leader>w :close<CR>
  nnoremap <leader>t<leader> :tabn<CR>
  nnoremap <leader>tn :tabnew<CR>
  nnoremap <leader>z :Goyo<CR>
  nnoremap <space> za                 " toggle folding
  nnoremap Q @@ " replay last macro
  nnoremap gV `[v`]                   " highlight last inserted text
  nnoremap j gj
  nnoremap k gk
  nnoremap z<space> zO                " open all folds under cursor

  tnoremap <Esc> <C-\><C-n>

  " default to verymagic modes (don't have to escape "{" in :s/\s{2,})
  nnoremap / /\v
  vnoremap / /\v
  cnoremap %s/ %smagic/
  cnoremap \>s/ \>smagic/
  nnoremap :g/ :g/\v
  nnoremap :g// :g//

  command! -nargs=+ Rg silent grep! <args> | copen 7

  nnoremap <leader>A :RgFzf<space>
  nnoremap <leader>a :Rg<space>
  nnoremap <leader>af :RgFzf<space>
  " nnoremap <leader>y :<C-u>CocList -A --normal yank<cr>
  vnoremap <leader>y "+y
  nnoremap <leader>y "+y
  nnoremap <leader>p "+p

  nnoremap <leader>gs :Gstatus<CR>
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  vmap <CR> <Plug>(LiveEasyAlign)

  " list matches
  " can be achieved with [I /]I
  nnoremap <leader>lm :vim // %<CR>:copen<CR>
  nnoremap ff :Format<CR>
" }}}

" Linters + Formatters + Colors {{{
" primitive html auto-format
vnoremap <leader>x JV:s/>\s*</>\r</<CR>

if has('multi_byte')
    set listchars=tab:»»,trail:•
    set fillchars=vert:┃ showbreak=↪
endif

autocmd FileType yaml setlocal foldmethod=indent
autocmd FileType vim,conf setlocal foldmethod=marker
autocmd FileType vimwiki se nowrap
" autocmd FileType javascript,javascriptreact,typescript,typescriptreact setl foldmethod=manual " use CoC :Fold command to fold
autocmd BufNewFile,BufRead *.jsx set ft=javascript.jsx
autocmd VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
autocmd VimLeave,VimSuspend * set guicursor=a:ver10

" sort imports
nnoremap <leader>s viB:sort<cr>
vnoremap <leader>s :sort<cr>

set fillchars+=vert:│
" Show tabs and trailing whitespace
set list listchars=tab:>>,trail:~

let g:tmuxline_powerline_separators=0
let g:vim_json_syntax_conceal = 1
let g:nv_use_short_pathnames=1

lua require'colorizer'.setup()


let srcery_italic=1
let g:gruvbox_italic=1
let g:gruvbox_bold=0
let g:deus_termcolors=256
colorscheme yui

let g:tmuxline_preset = {
      \ 'a':    [ 'CSP'                        ] ,
      \ 'win':  [ '#I',                   '#W' ] ,
      \ 'cwin': [ '#I',                   '#W' ] ,
      \ 'x':    [ '#(tmux-spotify-info)', '#S' ] }

  " Goyo & Limelight {{{
  function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
      silent !tmux set status off
      silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set noshowmode
    set noshowcmd
    set scrolloff=999
    set statusline="Goyo Mode"
    " set rnu
    Limelight
  endfunction

  function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
      silent !tmux set status on
      silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
  " }}}

" }}}

" NnnPicker {{{
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
  let g:nnn#set_default_mappings = 0
  let g:nnn#command = 'nnn -H'
  nnoremap <leader><cr> :NnnPicker '%:p:h'<CR>
" }}}

" Tmux navigation compatibility {{{
  " Intelligently navigate tmux panes and Vim splits using the same keys.
  " See https://sunaku.github.io/tmux-select-pane.html for documentation.
  let progname = substitute($VIM, '.*[/\\]', '', '')
  set title titlestring=%{progname}\ %f\ +%l\ #%{tabpagenr()}.%{winnr()}
  if &term =~ '^screen' && !has('nvim') | exe "set t_ts=\e]2; t_fs=\7" | endif
" }}}

" GutenTags {{{
  let g:gutentags_add_default_project_roots = 0
  let g:gutentags_project_root = ['package.json', '.git']
  let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
  let g:gutentags_generate_on_new = 1
  let g:gutentags_generate_on_missing = 1
  let g:gutentags_generate_on_write = 1
  let g:gutentags_generate_on_empty_buffer = 0
  let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
  command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

  let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]
" }}}

" Misc {{{
  " prevent opening 1 when I mean :e!
  au BufNew 1 throw 'You meant to :e! but did :e1'

  " From garyBernhardt's vimrc
  " Jump to the last cursor position unless it is
  " invalid or in an event handler
  au bufreadpost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  nmap <c-n> <plug>(YoinkPostPasteSwapBack)
  nmap <c-p> <plug>(YoinkPostPasteSwapForward)
  nmap p <plug>(YoinkPaste_p)
  nmap P <plug>(YoinkPaste_P)

  nnoremap <leader>cs :CocCommand git.chunkStage<cr>
  nnoremap <leader>ci :CocCommand git.chunkInfo<cr>
  nnoremap <leader>cu :CocCommand git.chunkUndo<cr>

  let g:vimwiki_list = [{
      \ 'path': '~/Google Drive/Notes/',
      \ 'path_html': '~/Google Drive/Notes/vim-wiki-html/',
      \ 'syntax': 'markdown', 'ext' : '.md'}]

  if has('gui_vimr')
    silent nnoremap <D-j> :!open /Applications/Alacritty.app<CR><ESC>
  endif

  source ~/.local/dotfiles/nabn/nvim/coc-user-config.vim
  source ~/.local/dotfiles/nabn/nvim/fzf.vim

" }}}


let g:eleline_powerline_fonts = 1

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:javascript_plugin_jsdoc = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"

" coc linting is slow
set updatetime=300

" experimental. paint out 
let &colorcolumn=join(range(81,999),",")
