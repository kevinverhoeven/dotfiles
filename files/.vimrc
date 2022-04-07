set paste
set spell
set spellcapcheck=

execute pathogen#infect()
syntax on
filetype plugin indent on
color desert

" Set the 80 column line break
"set colorcolumn=80
"highlight ColorColumn ctermbg=7 guibg=#2c2d27

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

" json formatting
function! FormatJSON()
  :%!python -m json.tool
endfunction

" create directory if not exist with :W
function! s:WriteCreatingDirs()
  let l:file=expand("%")
  if empty(getbufvar(bufname("%"), '&buftype')) && l:file !~# '\v^\w+\:\/'
    let dir=fnamemodify(l:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
  write
endfunction
command! W call s:WriteCreatingDirs()
