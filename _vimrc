" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

execute pathogen#infect()
"set t_Co=256
"syntax enable
"if (has("termguicolors"))
  "set termguicolors
"endif

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
  colorscheme OceanicNext
else
  colorscheme desert
endif

filetype plugin indent on

set whichwrap+=<,>,h,l,[,]
set incsearch

"colorscheme desert
set number relativenumber
set autoindent 
set cindent
set ignorecase smartcase
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab

nnoremap <F2> :args *.cpp <bar> tab all <CR> 
nnoremap <M-p> :args *.cpp <bar> tab all <CR> 


"enable visual block mode using ctrl-v
"nnoremap <C-v> "+p
vnoremap <C-v> "+p
inoremap <C-v> <ESC>"+p A

inoremap jj <ESC>
vnoremap ii <ESC>

inoremap <C-c> <ESC> "+yy I
vnoremap <C-c> "+y
nnoremap <C-c> "+yy

"quick comment
nnoremap <silent><C-m> :<S-Left>exe "<S-Right>normal! ".comment<CR>
nnoremap <silent><C-n> :<S-Left>exe "<S-Right>normal! ".uncomment<CR>


"open terminal and return focus to editor/close terminal
nnoremap <expr> <silent><M-v> (len(term_list())==0) ? ':terminal ++rows=10 <CR><C-l>j' :':call term_sendkeys(term_list()[0],"exit\<lt>CR>")<CR>'

set twk=<C-l>
nnoremap <C-l> <C-w>

autocmd filetype java let comment='I//'
autocmd filetype java let uncomment='^xx'
autocmd filetype cpp let comment='I//'
autocmd filetype cpp let uncomment='^xx'
autocmd filetype python let comment='I#'
autocmd filetype python let uncomment='^x'
autocmd filetype perl let comment='I#'
autocmd filetype perl let uncomment='^x'

autocmd filetype java nnoremap <F5> :w <bar> !javac % && java -enableassertions %:r <CR>
autocmd filetype python nnoremap <F5> :w <bar> !python % <CR>
autocmd filetype perl nnoremap <F5> :w <bar> !perl % <CR>
autocmd filetype go nnoremap <F5> :w <bar> !go build % && %:r <CR>



"C-v to paste input && C-c to terminate(by default)
tnoremap <C-v> <C-l>"+
tnoremap <M-v> exit<CR>

autocmd filetype cpp nnoremap <silent><F5> :w <bar> call term_sendkeys(term_list()[0],"g++ -ulimit -Wall -Wno-unused-result -std=c++14 ".expand('%')." -o ".expand('%:r')." && ".expand('%:r')."\<lt>CR>")<CR><C-w>k

autocmd filetype cpp nnoremap <silent><F6> :w <bar> call term_sendkeys(term_list()[0],"g++ -ulimit -Wall -Wno-unused-result -std=c++14 -O2 ".expand('%')." -o ".expand('%:r')." && ".expand('%:r')."\<lt>CR>")<CR><C-w>k

autocmd filetype cpp nnoremap <silent><F7> :w <bar> call term_sendkeys(term_list()[0],"g++ -ulimit -Wall -Wno-unused-result -std=c++14 -O2 ".expand('%')." -o ".expand('%:r')."\<lt>CR>")<CR><C-w>k

"autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++14 % -o %:r && %:r <CR>

"autocmd filetype cpp nnoremap <F6> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++14   -O2   % -o %:r && %:r <CR>

"autocmd filetype cpp nnoremap <F7> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++14 % -o %:r<CR>

autocmd filetype cpp nnoremap <M-r> :w <bar>  call term_sendkeys(term_list()[0],"g++ -ulimit -Wall -Wno-unused-result -std=c++14 ".expand('%')." -o ".expand('%:r')." && ".expand('%:r')."\<lt>CR>")<CR><C-w>k

autocmd filetype cpp nnoremap <M-o> :w <bar> call term_sendkeys(term_list()[0],"g++ -ulimit -Wall -Wno-unused-result -std=c++14 -O2 ".expand('%')." -o ".expand('%:r')." && ".expand('%:r')."\<lt>CR>")<CR><C-w>k

autocmd filetype cpp nnoremap <M-c> :w <bar> call term_sendkeys(term_list()[0],"g++ -ulimit -Wall -Wno-unused-result -std=c++14 -O2 ".expand('%')." -o ".expand('%:r')."\<lt>CR>")<CR><C-w>k

inoremap ;; <Esc>/<++><CR>"_c4l

"for loop snippet
autocmd filetype cpp inoremap ;fi for(int i =<++> ; i < <++>; i++){<CR><++><CR>} <Esc>/<++><CR>"_c4l 
autocmd filetype cpp inoremap ;fj for(int j =<++> ; j < <++>; j++){<CR><++><CR>} <Esc>/<++><CR>"_c4l
autocmd filetype cpp inoremap ;fk for(int k =<++> ; k < <++>; k++){<CR><++><CR>} <Esc>/<++><CR>"_c4l 
autocmd filetype cpp inoremap ;# #include <<++>>

inoremap {<CR> {<CR><CR>}<Esc>kcc
