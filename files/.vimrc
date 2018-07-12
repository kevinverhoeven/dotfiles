execute pathogen#infect()
syntax on
filetype plugin indent on
:color desert
" Change to the directory the file in your current buffer is in
au BufEnter * if &buftype != "nofile" && isdirectory(expand("%:p:h"))
\ | lcd %:p:h | endif

" in-editor repl
nnoremap <C-w>r :ConqueTermVSplit lein repl<CR>
nnoremap <C-w>R :ConqueTermSplit lein repl<CR>
nnoremap <C-w>f :ConqueTermVSplit lein figwheel dev<CR>
nnoremap <C-w>F :ConqueTermSplit lein figwheel dev<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 1

" syntax highlighting
augroup filetypedetect
    au! BufNewFile,BufRead *.clj setf clojure
augroup END

" auto-complete
let g:SuperTabDefaultCompletionType="context"
au FileType clojure let b:SuperTabCompletionContexts =
  \ ['ClojureContext'] + g:SuperTabCompletionContexts
function! ClojureContext()
  let curline = getline('.')
  let cnum = col('.')
  let synname = synIDattr(synID(line('.'), cnum - 1, 1), 'name')
  if curline =~ '(\S\+\%' . cnum . 'c' && synname !~ '\(String\|Comment\)'
    return "\<c-x>\<c-o>"
  endif
endfunction

