# Ruby MatchIt
A [Vim](http://www.vim.org) plug-in that allows one to jump between the
beginning and ending of a block of code based on indentation.

## How does it work?
When you hit `%`, the cursor jumps to the nearest line that has the same
indentation as the current one. The direction of the jump is determined
based on the first word of the current line: if it is `end`, the search
goes upwards and downwards otherwise.

## Why does it exist?
By default, `%` is only capable of C-like jumps including parentheses,
brackets, and braces; it does not know Ruby.
The script was written by
[Johannes Tanzler](http://www.vim.org/account/profile.php?user_id=223),
and its original version can be found
[here](http://www.vim.org/scripts/script.php?script_id=290).
In contrast to the original version, the current version does not try to
detect any other keywords rather than `end`, which is especially advantageous
when working with various DSLs like the one of
[RSpec](https://github.com/rspec/rspec).
