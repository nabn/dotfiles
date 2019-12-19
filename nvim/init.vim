" Plugins {{{
  call plug#begin('~/.config/nvim/plugged')
    Plug '/usr/local/bin/fzf'
    Plug 'alok/notational-fzf-vim'
    Plug 'ap/vim-css-color'
    Plug 'ayu-theme/ayu-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'edkolev/tmuxline.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'jiangmiao/auto-pairs'              " autoclose parens
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mattn/emmet-vim'
    Plug 'mcchrish/nnn.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rhysd/git-messenger.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'tomtom/tcomment_vim'               " file-type sensible comments
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
  call plug#end()
" }}}

" Set Declarations {{{
  filetype indent on
  filetype plugin indent on

  highlight Comment cterm=italic

  let g:nv_search_paths =['~/Google Drive/Notes']
  let g:nv_create_note_key = 'ctrl-x'
  let g:python_host_prog='/usr/local/bin/python3'
  hi SpellBad gui=undercurl guisp=red term=undercurl cterm=undercurl

  set shellcmdflag=-ic                              " make Vim’s :! shell behave like your command prompt.
                                                    " https://stackoverflow.com/a/4642855/10926788
  set autoread                                      " if file changes outside of vim, redraw buffer
  set diffopt+=vertical
  set encoding=utf8
  set expandtab
  set formatoptions+=j                              " delete comment character when joining commented lines
  set gdefault                                      " set global flag as default for :substitute
  set grepprg=rg\ --vimgrep\ --no-heading
  set hidden                                        " enable multiple unsaved buffers to be maintained
  set ignorecase
  set inccommand=nosplit
  set laststatus=2                                  " always show the statusline
  set lazyredraw
  set list
  set listchars=tab:>-,trail:~,extends:>,precedes:< " mark all kinds of whitespace
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
  set smartindent
  set softtabstop=4
  set tabstop=4
  set termguicolors
  set timeoutlen=300
  set undofile
  set wildignorecase                                " case insensitive filename completion
  set wrap
  syntax enable

  " Misspellings
  iabbrev improt import
" }}}

" Mappings {{{
  let mapleader=','

  let g:rg_highlight='true'
  let g:rg_derive_root='true'

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

  " nnoremap <leader>R :e!<CR>
  " command! -nargs=+ RgSource silent grep! -g '!*.spec.*' -g '!dist' <args> | copen 7
  " command! -nargs=+ RgAll silent grep! <args> | copen 7
  " nnoremap <leader>a :RgSource<space>
  " nnoremap <leader>A :RgAll<space>
  command! -nargs=+ Rgsrc silent grep! <args> src | copen 7
  nnoremap <leader>A :Rg<space>
  nnoremap <leader>a :Rgsrc<space>

  nnoremap <leader>gs :Gstatus<CR>
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  vmap <CR> <Plug>(LiveEasyAlign)

  " list matches
  " can be achieved with [I /]I
  " nnoremap <leader>lm :vim // %<CR>:copen<CR>
" }}}

" FZF {{{
  nnoremap <c-b> :Buffers<CR>
  nnoremap <c-f> :Files<CR>

  let $FZF_DEFAULT_COMMAND='fd --type f'
  let $FZF_DEFAULT_OPTS = ''
  let g:fzf_buffers_jump = 1
  inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --pretty --smart-case '
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
" }}}

" Misc {{{
  let g:gitgutter_enabled=0
  let g:gitgutter_hightlight_lines=1
  let g:gitgutter_signs=1
  let g:goyo_width=120
  let g:netrw_winsize=15
  let g:rainbow_active=1
  let g:startify_change_to_vcs_root=1
  let g:nv_use_short_pathnames=1
  let ayucolor='mirage' " mirage | light | dark
  " where 'c' can be any ASCII character. You can also use one of ¦, ┆, │, ⎸, or ▏ 
  let g:indentLine_char = '┆'

  " markdown filetype file
  au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown

  colorscheme ayu

  command! Invbg call helpers#ReverseBackground()
  noremap <leader>co :Invbg<CR>

  if has('nvim')                                    " fix for nvim on iterm
    nmap <BS> <C-W>h
  endif

  nmap tt :call helpers#SwapTestFile()<CR>

  " prevent opening 1 when I mean :e!
  au BufNew 1 throw 'You ment to :e! but did :e1'

  " restore cursor on exiting vim
  au VimLeave * set guicursor=

" }}}

" CoC {{{
  inoremap <silent><expr> <c-space> coc#refresh()
  set updatetime=300
  set shortmess+=c

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Remap keys for gotos
  nmap <silent> en <Plug>(coc-diagnostic-next)
  nmap <silent> ep <Plug>(coc-diagnostic-prev)
  nmap <slient> <leader>di <Plug>(coc-diagnostic-info)
  nmap <slient> <leader>ca <Plug>(coc-codeaction)
  xmap <silent> la <Plug>(coc-codeaction-selected)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> rn <Plug>(coc-rename)
  autocmd filetype javascript,typescript vmap gq <Plug>(coc-format-selected)
  autocmd filetype javascript,typescript nmap gq <Plug>(coc-format-selected)

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json,javascript setl formatexpr=CocAction('formatSelected')
  augroup end

  command! -nargs=0 Format :call CocAction('format')
  " command! -nargs=0 AutoFix :CocCommand tsserver.executeAutofix
  " command! -nargs=0 OrganiseImports :CocCommand tsserver.organizeImports
  " map ff ::AutoFix<CR>:OrganiseImports<CR>:Format<CR>
"}}}

" Goyo {{{
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set nowrap
  Limelight
  " ...
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
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
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
    \   'colorscheme': 'ayu',
    \   'active': {
    \     'left': [ [ 'mode',      'paste'],
    \               [ 'cocstatus', 'readonly', 'modified', 'filename' ] ]
    \   },
    \   'component_function': {
    \     'cocstatus': 'coc#status',
    \     'gitbranch': 'helpers#GetTicketNumber'
    \   },
    \ }

let g:tmuxline_powerline_separators=0

let g:tmuxline_preset = {
    \   'a'    : ['#S', '#(git rev-parse --abbrev-ref HEAD | cut -d  - -f1,2)'],
    \   'win'  : ['#I', '#W'],
    \   'cwin' : ['#I', '#W'],
    \   'y'    : ['%R', '%a', '%Y'],
    \   'z'    : '#h'}
" }}}

" NnnPicker{{{
  let g:nnn#layout = { 'left': '~20%' }
  let g:nnn#set_default_mappings = 0
  let g:nnn#command = 'nnn -H'
  nnoremap <leader><cr> :NnnPicker<cr>
" }}}
