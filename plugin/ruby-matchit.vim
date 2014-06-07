" Ruby MatchIt
"
" Author: Johannes Tanzler (http://www.vim.org/account/profile.php?user_id=223)
" Source: http://www.vim.org/scripts/script.php?script_id=290
" Modified: June 7, 2014 by Ivan Ukhov (https://github.com/IvanUkhov)
"
" When you hit `%`, the cursor jumps to the nearest line that has the same
" indentation as the current one. The direction of the jump is determined
" based on the first word of the current line: if it is `end`, the search
" goes upwards and downwards otherwise.
"
function! s:RubyMatchIt()
  " Preserve the default behavior for parentheses, brackets and braces
  if strpart(getline("."), col(".")-1, 1) =~ '(\|)\|{\|}\|\[\|\]'
    normal \\\\\
    return
  endif

  normal ^
  silent! let current_word = expand('<cword>')

  if current_word == ""
    return
  endif

  let current_line = line(".")
  let spaces = strlen(matchstr(getline("."), "^\\s*"))

  if current_word =~ '\<end\>'
    let move = 'k'
  else
    let move = 'j'
  end

  while 1
    exe 'normal ' . move
    if strlen(matchstr(getline("."), "^\\s*")) == spaces
      \ && getline(".") !~ "^\\s*$"
      \ && getline(".") !~ "^#"

      normal ^
      break
    elseif line(".") == 1
      exe 'normal ' . current_line . 'G'
      break
    endif
  endwhile
endfunction

nnoremap <buffer> \\\\\ %
nnoremap <buffer> % :call <SID>RubyMatchIt()<CR>
