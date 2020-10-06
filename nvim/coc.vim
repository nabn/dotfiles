" ==================================
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" ============================================

set updatetime=300
set shortmess+=c

hi coc_err_hi ctermfg=1 ctermbg=15
sign define coc_err numhl=coc_err_hi
sign place 1 line=2 name=coc_err

verbose inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

xmap <silent> la <Plug>(coc-codeaction-selected)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

command! -nargs=? Fold   :call     CocAction('fold', <f-args>)
command! -nargs=0 Format :call     CocAction('format')

nmap <silent> ep <Plug>(coc-diagnostic-prev)
nmap <silent> en <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
nmap tt :CocList symbols<CR>

" coc-git
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" nnoremap <leader>gs :<C-u>CocList --normal gstatus<CR>
nnoremap <leader>ci :CocCommand git.chunkInfo<cr>
nnoremap <leader>cs :CocCommand git.chunkStage<cr>
nnoremap <leader>cu :CocCommand git.chunkUndo<cr>
nnoremap <leader>cl :CocList 
nnoremap <leader>cc :CocCommand 
nnoremap cc :CocCommand 
nnoremap <leader>cn :CocNext<cr>
nmap <leader>ca <Plug>(coc-codeaction-selected)
xmap <leader>ca <Plug>(coc-codeaction-selected)


" refresh completion menu
inoremap <silent><expr> <c-space> coc#refresh()

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
" }}}
