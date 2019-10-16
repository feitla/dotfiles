" Syntax
syntax enable
filetype plugin indent on

" Theme
set t_Co=256
hi Search       ctermfg=255 ctermbg=124 guifg=white   guibg=red
hi Folded       ctermfg=255 ctermbg=232 guifg=#a0a8b0 guibg=#384048
hi Visual       ctermfg=15  ctermbg=236 guifg=#faf4c6 guibg=#3c414c

hi StatusLine   ctermfg=88  ctermbg=15  guifg=#a0a8b0 guibg=#384048
hi StatusLineNC ctermfg=238 ctermbg=15  guifg=#444444 guibg=#444444
hi VertSplit    ctermfg=238 ctermbg=238 guifg=#444444 guibg=#444444 term=reverse cterm=reverse

hi ErrorMsg     ctermfg=15  ctermbg=88  guifg=#a0a8b0 guibg=#384048
hi PreProc      ctermfg=229             guifg=#faf4c6               term=underline
hi Function     ctermfg=15                                          cterm=bold
hi SpellCap     ctermfg=15  ctermbg=236
hi Todo         ctermfg=16 ctermbg=11

" Swap is just a PITA, tbh
set noswapfile

" Delay when using lead keys, default=1000
set timeoutlen=400

" Ignore common big directories of files I'll never Ctrl+P
set wildignore+=**/node_modules
set wildignore+=**/tmp/cache
set wildignore+=**/vendor/assets

" Statusline
set statusline=%f[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

set sel=inclusive
set sw=2          " Shiftwidth
set ts=2          " Tabstop
set ai            " Autoindent
set nowrap        " No wrapping
set et            " Expand tab
set nu            " Line numbers
set ic            " Ignore case
set ls=2          " Always display statusbar (laststatus)
set hls           " Always highlight searches
set is            " Incremental Search

set ar            " Autoread
set fdm=indent    " Folding
set foldlevel=99  " Unfold all when first opening a file
set splitbelow    " Open splits where you'd expect

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window.
autocmd InsertEnter * let w:last_fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:last_fdm

" Column 115 red highlight
hi LineOverflow ctermfg=255 ctermbg=124

let w:m2=matchadd('LineOverflow', '\%>115v.\+', -1)

autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

autocmd WinEnter * if !exists('w:created') | let w:m2=matchadd('LineOverflow', '\%>110v.\+', -1) | endif

" Trailing whitespace highlighting
set list
set listchars=tab:→\ ,trail:.

" Pastetoggle
set pastetoggle=<F10>

" Shift-klear
nnoremap <S-K> ""
noremap <S-K> :noh<CR>

" Save
inoremap kk <Esc>:w<CR>

" Copy to sys clipboard
set clipboard=unnamedplus
imap <Leader>y "+y

" Delay fix
set esckeys
set timeoutlen=1000 ttimeoutlen=0

" Leader shortcuts
map <Leader>t :tabnew<CR>
map <Leader>fs :Ack -aiu 
map <Leader>s :tabnew<CR>:Ack --ignore "log/" --ignore "vendor/" -i 
nnoremap <C-L> :Ack --ignore "log/" --ignore "vendor/" -i 
map <Leader>in :Tabularize/\w:\zs/l0l1<CR>
map <Leader>io :Tabularize /^[^=>]*\zs=>/l1<CR>
map <Leader>is :Tabularize /\ \+\w.*\ \{1\}<CR>
map <Leader>ih :Tabularize /{\{1\}.*<CR>
map <Leader>ipc :Tabularize //\{2\}<CR>
map <Leader>cf "%p<CR>
map <Leader>og :.Gbrowse<CR>
map <Leader>rh :s/"\([^ ]*\)"\(\s*\)=>/\1: /gc<CR>
map <Leader>rhs :s/:\([^ ]*\)\(\s*\)=>/\1: /gc<CR>
map <Leader>hm :s/=>/ => /g<CR>$v%lohc<CR><CR><Up><C-r>"<Esc>:s/,/,\r/g<CR>:'[,']norm ==<CR>
abbrev pry require 'pry'; binding.pry;

" Command shortcuts
command! Stw :%s/\s\+$//

" command-t
hi LineCyan guifg=white guibg=#0c4c50 gui=bold cterm=bold ctermbg=15 ctermfg=233
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxHeight = 10
let g:CommandTMaxFiles = 10000
let g:CommandTHighlightColor = 'LineCyan'
nnoremap <C-P> :CommandT<CR>

" gist-vim
let g:gist_post_private = 1

" vroom
let g:vroom_use_binstubs = 1
let g:vroom_use_vimux = 1
noremap Q :VimuxClearRunnerHistory<CR>:VroomRunNearestTest<CR>
map <Leader>rf :VroomRunTestFile<CR>
map <Leader>rc :w<CR>:call VimuxRunCommand("clear; rubocop " . bufname("%"))<CR>

" minitest
map <Leader>m :call VimuxRunCommand("clear")<CR>:call VimuxRunCommand("rake test")<CR>

" Pawn
function! MakePawn()
  silent make | copen
  redraw!
endfunction
map <Leader>pc :exec MakePawn()<CR>

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) + 2
    return line . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Syntastic
let g:syntastic_ruby_checkers = ['rubocop', 'mri']

" Ag command
let g:ackprg = 'ag --vimgrep --smart-case'