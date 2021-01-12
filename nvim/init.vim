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
  set equalalways
  set foldmethod=indent
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
  set mouse=ar
  set nofoldenable
  " set nomodeline
  set noshowmode
  set noswapfile
  set number  " -- the line number is in the bottom right
  set relativenumber
  set rtp+=/usr/local/opt/fzf
  set ruler
  set shiftwidth=2
  set showcmd
  " set showtabline=2 " Always show tab line
  set smartcase
  set smartindent
  set softtabstop=2
  set tabstop=2
  set termguicolors
  set timeoutlen=300
  set undofile
  set wildignorecase                                " case insensitive filename completion
  set signcolumn=number

  set visualbell
  set nowrap
  " syntax enable
  set t_ti= t_te=

  " Misspellings
  iabbrev improt import
  iabbrev lgo log
" }}}

" Plugins {{{

  call plug#begin('~/.config/nvim/plugged')

    Plug '/usr/local/bin/fzf'
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'alok/notational-fzf-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'gutenye/json5.vim'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'liuchengxu/vista.vim'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'mattn/emmet-vim'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'tomtom/tcomment_vim'               " file-type sensible comments
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'vimwiki/vimwiki'

    " Colorschemes
    Plug 'morhetz/gruvbox'
    Plug 'fenetikm/falcon'
    Plug 'ayu-theme/ayu-vim'
    Plug 'ntk148v/vim-horizon'

    Plug 'norcalli/nvim-colorizer.lua'

    " Plug 'lukas-reineke/format.nvim'
    " Plug 'TimUntersberger/neofs'
    Plug 'mcchrish/nnn.vim'

  call plug#end()
" }}}

" Mappings {{{
  let mapleader=','

  let g:rg_highlight='true'
  let g:rg_derive_root='true'

  " nmap tt :call helpers#SwapTestFile()<CR>
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
  " nnoremap j gj
  " nnoremap k gk
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
  " nnoremap ff :Format<CR>
" }}}

" Linters + Formatters + Colors {{{
" primitive html auto-format
vnoremap <leader>x JV:s/>\s*</>\r</<CR>

let g:spaceline_seperate_style='none'
let g:spaceline_diagnostic_errorsign="E:"
let g:spaceline_diagnostic_warnsign="W:"
let g:spaceline_diagnostic_oksign=""

if has('multi_byte')
  set listchars=tab:»»,trail:•
  set fillchars=vert:┃ showbreak=↪
endif

autocmd BufNewFile,BufRead *.jsx setlocal ft=javascript.jsx
autocmd FileType vim,conf setlocal foldmethod=marker
autocmd FileType vimwiki setlocal nowrap
autocmd FileType yaml setlocal foldmethod=indent
autocmd VimEnter,VimResume * setlocal guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
autocmd VimLeave,VimSuspend * setlocal guicursor=a:ver10

" sort imports
nnoremap <leader>s viB:sort<cr>
vnoremap <leader>s :sort<cr>

set fillchars+=vert:│
" Show tabs and trailing whitespace
set list listchars=tab:>>,trail:~

let g:vim_json_syntax_conceal = 1
let g:nv_use_short_pathnames=1



" Colorscheme {{{
  set background=dark
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
  let g:gruvbox_italic=1
  let g:gruvbox_bold=0
  let g:gruvbox_contrast_dark='hard'
  colorscheme gruvbox
  " fix <Highlight of background seems wrong with floating window.>
  hi Quote ctermbg=109 guifg=#83a598


  " let g:oceanic_next_terminal_bold = 1
  " let g:oceanic_next_terminal_italic = 1
  " colorscheme OceanicNext

  " let g:ayucolor='mirage'
  " colo ayu
  " colo falcon
" }}}

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

" Explorer {{{
  let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
  let g:nnn#set_default_mappings = 0
  let g:nnn#command = 'nnn -H'
  nnoremap <leader><cr> :NnnPicker %:p:h<CR>
  " nnoremap <leader><cr> :CocCommand explorer
  "   \ --toggle
  "   \ --sources=buffer+,file+<CR>
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

  " toggle inline diff in fugitive
  au FileType fugitive nnoremap <space> =

  " From garyBernhardt's vimrc
  " Jump to the last cursor position unless it is
  " invalid or in an event handler
  au bufreadpost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  let g:vimwiki_list = [{
      \ 'path': '~/Google Drive/Notes/',
      \ 'path_html': '~/Google Drive/Notes/vim-wiki-html/',
      \ 'syntax': 'markdown', 'ext' : '.md'}]

  if has('gui_vimr')
    silent nnoremap <D-j> :!open /Applications/Alacritty.app<CR><ESC>
  endif

  let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

  source ~/.local/dotfiles/nvim/lua.vim
  source ~/.local/dotfiles/nvim/coc.vim
  source ~/.local/dotfiles/nvim/fzf.vim
  source ~/.local/dotfiles/nvim/redir.vim
" }}}

" Snippets {{{
  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)

  " Use <leader>x for convert visual selected code to snippet
  xmap <leader>x  <Plug>(coc-convert-snippet)
" }}}

" au FileType *.tsx BufWritePre npx tslint --fix
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
