" Plugins {{{
  call plug#begin('~/.config/nvim/plugged')
    Plug 'tpope/vim-fugitive'

    " Colorschemes 
    Plug 'ap/vim-css-color'
    Plug 'ayu-theme/ayu-vim'
    Plug 'endel/vim-github-colorscheme'
    Plug 'morhetz/gruvbox'
    Plug 'fenetikm/falcon'
    Plug 'rakr/vim-one'
    Plug 'cocopon/iceberg.vim/'
    Plug 'acarapetis/vim-colors-github'
    "-----

    Plug '/usr/local/bin/fzf'
    Plug 'alok/notational-fzf-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'edkolev/tmuxline.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mattn/emmet-vim'
    Plug 'mcchrish/nnn.vim'
    Plug 'metakirby5/codi.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rhysd/git-messenger.vim'
    Plug 'tomtom/tcomment_vim'               " file-type sensible comments
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'svermeulen/vim-yoink'
    Plug 'honza/vim-snippets'
    Plug 'vifm/vifm.vim'

    " Language
    Plug 'sheerun/vim-polyglot'
    Plug 'MaxMEllon/vim-jsx-pretty'
    Plug 'alampros/vim-styled-jsx'
    " --------


  call plug#end()
" }}}

" Set Declarations {{{
  filetype indent on
  filetype plugin indent on

  highlight Comment cterm=italic

  let g:nv_search_paths =['~/Google Drive/Notes']
  let g:nv_create_note_key = 'ctrl-x'
  " let g:python_host_prog='/usr/bin/python'
  let g:python3_host_prog='/usr/local/bin/python3'
  hi SpellBad gui=undercurl guisp=red term=undercurl cterm=undercurl

  " set shellcmdflag=-ic                              " make Vim’s :! shell behave like your command prompt.
                                                    " https://stackoverflow.com/a/4642855/10926788
  set autoread                                      " if file changes outside of vim, redraw buffer
  set splitright
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
  set nomodeline
  set noshowmode
  set noswapfile
  set number
  set relativenumber
  set rtp+=/usr/local/opt/fzf
  set ruler
  set shiftwidth=2
  set showcmd
  set smartcase
  set smartindent
  set softtabstop=4
  set tabstop=4
  set termguicolors
  set timeoutlen=300
  set undofile
  set wildignorecase                                " case insensitive filename completion
  set visualbell
  set wrap
  syntax enable

  " Misspellings
  iabbrev improt import
" }}}

" Mappings {{{
  let mapleader=','

  let g:rg_highlight='true'
  let g:rg_derive_root='true'

  nmap tt :call helpers#SwapTestFile()<CR>
  nnoremap 0 ^
  nnoremap <leader><space> :b#<CR>    " switch to last buffer
  nnoremap <leader>N :NV<CR>
  nnoremap <leader>O :call helpers#DeleteHiddenBuffers()<CR>
  nnoremap <leader>e :e ~/.config/nvim/init.vim<CR>
  nnoremap <leader>n :nohl<CR>
  nnoremap <leader>o :only<CR>
  nnoremap <leader>q :bd<CR>
  nnoremap <leader>t<leader> :tabn<CR>
  nnoremap <leader>tn :tabnew<CR>
  nnoremap <leader>z :Goyo<CR>
  nnoremap <space> za                 " toggle folding
  nnoremap Q @@ " replay last macro
  nnoremap gV `[v`]                   " highlight last inserted text
  nnoremap j gj
  nnoremap k gk
  nnoremap z<space> zO                " open all folds under cursor

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

  " nnoremap <leader>gs :Gstatus<CR>
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  vmap <CR> <Plug>(LiveEasyAlign)

  " list matches
  " can be achieved with [I /]I
  nnoremap <leader>lm :vim // %<CR>:copen<CR>
  nnoremap ff :Format<CR>
" }}}

" FZF {{{
  nnoremap <c-b> :Buffers<CR>
  nnoremap <c-f> :Files<CR>

  let $FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git --type f'
  let $FZF_DEFAULT_OPTS = ''
  let g:fzf_buffers_jump = 1
  inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)

  command! -bang -nargs=* RgFzf
    \ call fzf#vim#grep(
    \   'rg --column --hidden --line-number --no-heading --color=always --pretty --smart-case '
    \ . <q-args>, 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  let g:fzf_commits_log_options = '--format="%C(white)%h%>(15,trunc)%C(blue)%aN%>(15,trunc)%C(yellow)%ar %C(green)%s"'
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let g:fzf_colors = {
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Keyword'],
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
        \ 'header':  ['fg', 'Comment'] }
  " }}}

" Linters + Formatters {{{
  " primitive html auto-format
  vnoremap <leader>x JV:s/>\s*</>\r</<CR>


  autocmd FileType yaml setl foldmethod=indent
  autocmd FileType conf setl foldmethod=marker
" }}}

" LightLine + Tmuxline {{{
function! s:setLightlineColorscheme(name)
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfun

function! s:lightlineColorschemes(...)
  return join(map(
        \ globpath(&rtp,"autoload/lightline/colorscheme/*.vim",1,1),
        \ "fnamemodify(v:val,':t:r')"),
        \ "\n")
endfun

com! -nargs=1 -complete=custom,s:lightlineColorschemes LightlineColorscheme
      \ call s:setLightlineColorscheme(<q-args>)

let g:lightline = {
    \   'colorscheme': 'gruvbox',
    \   'active': {
    \     'left': [ [ 'mode',      'paste',        'gitbranch', 'blame'    ],
    \               [ 'cocstatus', 'readonly',     'modified',  'filename' ] ],
    \     'right':  [ ['filetype',  'fileencoding', 'lineinfo',  'percent'  ],
    \                 [ 'blame' ]],
    \   },
    \   'component_function': {
    \     'cocstatus': 'coc#status',
    \     'gitbranch': 'helpers#GetTicketNumber',
    \     'blame': 'LightlineGitBlame'
    \   },
    \ }


function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

let g:tmuxline_powerline_separators=0

let g:tmuxline_preset = {
    \   'a'    : ['#(git rev-parse --abbrev-ref HEAD | cut -d  - -f1,2)'],
    \   'win'  : ['#I',                   '#W'],
    \   'cwin' : ['#I',                   '#W'],
    \   'x'    : ['#(tmux-spotify-info)', '#S']}
" }}}

" NnnPicker{{{
  " Floating window (neovim)
  function! s:layout()
    let buf = nvim_create_buf(v:false, v:true)

    let height = &lines - (float2nr(&lines / 3))
    let width = float2nr(&columns - (&columns * 2 / 3))

    let opts = {
          \ 'relative': 'editor',
          \ 'row': 2,
          \ 'col': 8,
          \ 'width': width,
          \ 'height': height
          \ }

    call nvim_open_win(buf, v:true, opts)
  endfunction

  let g:nnn#layout = 'call ' . string(function('<SID>layout')) . '()'
  let g:nnn#set_default_mappings = 0
  let g:nnn#command = 'nnn -H'
  nnoremap <leader><cr> :NnnPicker '%:p:h'<CR>
" }}}

" tmux navigation compatibility {{{
  " Intelligently navigate tmux panes and Vim splits using the same keys.
  " See https://sunaku.github.io/tmux-select-pane.html for documentation.
  let progname = substitute($VIM, '.*[/\\]', '', '')
  set title titlestring=%{progname}\ %f\ +%l\ #%{tabpagenr()}.%{winnr()}
  if &term =~ '^screen' && !has('nvim') | exe "set t_ts=\e]2; t_fs=\7" | endif
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
  set rnu
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

source ~/.local/dotfiles/nabn/nvim/coc-user-config.vim

" Misc {{{
  let g:vim_json_syntax_conceal = 1
  let g:nv_use_short_pathnames=1
  let ayucolor='mirage' " mirage | light | dark

  let g:gruvbox_contrast_dark='hard'
  " let g:gruvbox_italic=1
  colorscheme gruvbox

  " prevent opening 1 when I mean :e!
  au BufNew 1 throw 'You meant to :e! but did :e1'

  " From garyBernhardt's vimrc
  " Jump to the last cursor position unless it is
  " invalid or in an event handler
  au bufreadpost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " map <up>     :resize          -5<cr>
  " map <down>   :resize          +5<cr>
  " map <left>   :vertical resize -5<cr>
  " map <right>  :vertical resize +5<cr>

  " Show tabs and trailing whitespace
  set list listchars=tab:>>,trail:~
  if has('multi_byte')
      set listchars=tab:»»,trail:•
      set fillchars=vert:┃ showbreak=↪
  endif

  nmap <c-n> <plug>(YoinkPostPasteSwapBack)
  nmap <c-p> <plug>(YoinkPostPasteSwapForward)
  nmap p <plug>(YoinkPaste_p)
  nmap P <plug>(YoinkPaste_P)

  " sort imports
  nnoremap <leader>s viB:sort<cr>
  vnoremap <leader>s :sort<cr>

  nnoremap <leader>cs :CocCommand git.chunkStage<cr>
  nnoremap <leader>ci :CocCommand git.chunkInfo<cr>
  nnoremap <leader>cu :CocCommand git.chunkUndo<cr>

  set showtabline=2
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      \,a:blinkwait700-blinkoff400-blinkon250-Cursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175
" }}}

command! Scratch lua require'tools'.makeScratch()
