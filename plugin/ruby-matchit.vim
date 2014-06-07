" FILE: "/home/johannes/ruby.vim"
" Last Modification: "Mon, 06 May 2002 23:42:11 +0200 (johannes)"
" Additional settings for Ruby
" Johannes Tanzler, <jtanzler@yline.com>

" Matchit for Ruby: '%' {{{
"
"   This function isn't very sophisticated. It just takes care of indentation.
" (I've written it, because I couldn't extend 'matchit.vim' to handle Ruby
" files correctly (that's because everything in Ruby ends with 'end' -- no
" 'endif', 'endclass' etc.))
"
" If you're on the line `if x', then the cursor will jump to the next line
" with the same indentation as the if-clause. The same is true for a whole
" bunch of keywords -- see below for details.
"
" Since brave programmers use indentation, this will work for most of you, I
" hope. At least, it works for me. ;-)
" }}}
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
