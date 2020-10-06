function! s:VimRTempMaxWin() abort
  VimRMakeSessionTemporary    " The tools, tool buttons and window settings are not persisted
  VimRHideTools
  VimRMaximizeWindow
endfunction
command! -nargs=0 VimRTempMaxWin call s:VimRTempMaxWin()

function! s:VimRDifDiff() abort
  VimRTempMaxWin
  sleep 500m        " Yes, ugly, but I could not find a better solution.
  normal o          " Select the first file (again) to resize the panes.
endfunction
command! -nargs=0 VimRDirDiff call s:VimRDirDiff()
