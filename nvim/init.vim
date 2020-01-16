" Plugins {{{
  call plug#begin('~/.config/nvim/plugged')
    Plug '/usr/local/bin/fzf'
    Plug 'metakirby5/codi.vim'
    Plug 'alok/notational-fzf-vim'
    Plug 'ap/vim-css-color'
    Plug 'ayu-theme/ayu-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'edkolev/tmuxline.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mattn/emmet-vim'
    Plug 'mcchrish/nnn.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'reedes/vim-colors-pencil'
    Plug 'rhysd/git-messenger.vim'
    Plug 'tomtom/tcomment_vim'               " file-type sensible comments
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'

    Plug 'prurigro/vim-polyglot-darkcloud'
    Plug 'MaxMEllon/vim-jsx-pretty'
  call plug#end()
" }}}

" Set Declarations {{{
  filetype indent on
  filetype plugin indent on

  highlight Comment cterm=italic

  let g:nv_search_paths =['~/Google Drive/Notes']
  let g:nv_create_note_key = 'ctrl-x'
  let g:python_host_prog='/usr/bin/python'
  let g:python3_host_prog='/usr/local/opt/python@3.8/bin/python3'
  hi SpellBad gui=undercurl guisp=red term=undercurl cterm=undercurl

  set shellcmdflag=-ic                              " make Vim’s :! shell behave like your command prompt.
                                                    " https://stackoverflow.com/a/4642855/10926788
  set autoread                                      " if file changes outside of vim, redraw buffer
  set diffopt+=vertical
  set encoding=utf8
  set expandtab
  set foldmethod=syntax
  set formatoptions+=j                              " delete comment character when joining commented lines
  set gdefault                                      " set global flag as default for :substitute
  set grepprg=rg\ --vimgrep\ --no-heading
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
  nnoremap <leader>y :<C-u>CocList -A normal yank<cr>

  command! -nargs=+ Rg silent grep! <args> | copen 7

  nnoremap <leader>A :RgFzf<space>
  nnoremap <leader>a :Rg<space>
  nnoremap <leader>af :RgFzf<space>
  nnoremap <leader>y :<C-u>CocList -A normal yank<cr>

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
" }}}

" CoC {{{
  inoremap <silent><expr> <c-space> coc#refresh()
  set updatetime=300
  " set shortmess+=c

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
  nmap <silent> <leader>di <Plug>(coc-diagnostic-info)
  nmap <silent> <leader>ca <Plug>(coc-codeaction)
  xmap <silent> la <Plug>(coc-codeaction-selected)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> rn <Plug>(coc-rename)

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
    autocmd FileType typescript,json,javascript,javascriptreact setl formatexpr=CocAction('formatSelected')
  augroup end

  command! -nargs=0 Format :call CocAction('format')
  " command! -nargs=0 AutoFix :CocCommand tsserver.executeAutofix
  " command! -nargs=0 OrganiseImports :CocCommand tsserver.organizeImports
  " map ff ::AutoFix<CR>:OrganiseImports<CR>:Format<CR>

  " navigate chunks of current buffer
  nmap [c <Plug>(coc-git-prevchunk)
  nmap ]c <Plug>(coc-git-nextchunk)
  " show chunk diff at current position
  nmap gs <Plug>(coc-git-chunkinfo)
  " show commit contains current position
  nmap gc <Plug>(coc-git-commit)
  " create text object for git chunks
  omap ig <Plug>(coc-git-chunk-inner)
  xmap ig <Plug>(coc-git-chunk-inner)
  omap ag <Plug>(coc-git-chunk-outer)
  xmap ag <Plug>(coc-git-chunk-outer)
"}}}

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

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

let g:lightline = {
    \   'colorscheme': 'ayu',
    \   'active': {
    \     'left': [ [ 'mode',      'paste', 'gitbranch', 'blame'],
    \               [ 'cocstatus', 'readonly', 'modified', 'filename' ] ],
    \   'right':  [ [  'filetype', 'blame', 'fileencoding', 'lineinfo', 'percent' ],
    \               ],
    \   },
    \   'component_function': {
    \     'cocstatus': 'coc#status',
    \     'gitbranch': 'helpers#GetTicketNumber',
    \     'blame': 'LightlineGitBlame'
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
  let g:nnn#layout = { 'right': '~20%' }
  let g:nnn#set_default_mappings = 0
  let g:nnn#command = 'nnn -H'
  nnoremap <leader><cr> :NnnPicker<cr>
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

" Misc {{{
  let g:vim_json_syntax_conceal = 1
  let g:nv_use_short_pathnames=1
  let ayucolor='mirage' " mirage | light | dark

  colorscheme ayu

  " prevent opening 1 when I mean :e!
  au BufNew 1 throw 'You ment to :e! but did :e1'

  au VimLeave * set guicursor=a:underline
" }}}
