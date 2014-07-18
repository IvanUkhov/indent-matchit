" Indent MatchIt
"
" Original version:
" Author: Johannes Tanzler (http://www.vim.org/account/profile.php?user_id=223)
" Source: http://www.vim.org/scripts/script.php?script_id=290
"
" Current version:
" Author: Ivan Ukhov (https://github.com/IvanUkhov)
" Source: https://github.com/IvanUkhov/ruby-matchit
"
" When you hit `%`, the cursor jumps to the nearest line that has the same
" indentation as the current one. The direction of the jump is determined
" based on the first word of the current line: if it begins with `end`,
" the search goes upwards and downwards otherwise.
"
" The original behavior of `%` with respect to parentheses, brackets, and
" braces is preserved.
"
function! IndentMatchIt()
  if strpart(getline("."), col(".")-1, 1) =~ '(\|)\|{\|}\|\[\|\]'
    normal! %
    return
  endif

  normal ^
  silent! let current_word = expand('<cword>')

  if current_word == ""
    return
  endif

  let current_line = line(".")
  let spaces = strlen(matchstr(getline("."), "^\\s*"))

  if current_word =~ '\<end'
    let move = 'k'
    let stop = 1
  else
    let move = 'j'
    let stop = line("$")
  end

  while 1
    exe 'normal ' . move
    if strlen(matchstr(getline("."), "^\\s*")) == spaces
      \ && getline(".") !~ "^\\s*$"
      \ && getline(".") !~ "^#"

      normal ^
      break
    elseif line(".") == stop
      exe 'normal ' . current_line . 'G'
      break
    endif
  endwhile
endfunction

nnoremap % :call IndentMatchIt()<CR>
