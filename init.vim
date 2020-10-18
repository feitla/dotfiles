call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }                                " Fuzzy file finder
Plug 'junegunn/fzf.vim'                                                 " Find in files live
Plug 'bmcilw1/mustang-vim'                                              " Theme
Plug 'ervandew/supertab'                                                " Async tab completion
Plug 'neomake/neomake'                                                  " Async Lint
Plug 'slim-template/vim-slim'                                           " Slim lang syntax highlighting
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-rails'
Plug 'itchyny/lightline.vim'                                            " Nice statusbar
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-visual-star-search'
Plug 'goldfeld/ctrlr.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-endwise'
Plug 'benmills/vimux'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'posva/vim-vue'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-rhubarb'
Plug 'kchmck/vim-coffee-script'
Plug 'isRuslan/vim-es6'
Plug 'dhruvasagar/vim-zoom'
Plug 'octol/vim-cpp-enhanced-highlight'                                 " C++ highlighting
call plug#end()

set noswapfile            " Don't use swapfiles
set sel=inclusive         " ?
set sw=2                  " Shiftwidth
set ts=2                  " Tabstop
set ai                    " Autoindent
set nowrap                " No wrapping
set et                    " Expand tab
set ic                    " Ignore case
set nu                    " Line numbers
set ls=2                  " Always display statusbar (laststatus)
set hls                   " Always highlight searches
set is                    " Incremental Search
set ar                    " Autoread
" set noow                  " No overwrite warning
set fdm=indent            " Folding
set foldlevel=99          " Unfold all when first opening a file
set splitbelow            " Open splits where you'd expect
set pastetoggle=<F10>     " Toggle paste mode
set isk+=-                " Hyphens act as underscores

inoremap kk <Esc>:w<CR>   " Quick save
nnoremap <C-L> :Ack --ignore "log/" --ignore "vendor/" -i
map <Leader>s :tabnew<CR>:Ack --ignore "log/" --ignore "vendor/" -i
map <Leader>og :.Gbrowse<CR>
map <C-a> <Esc>ggVG<CR>

" autocmd InsertLeave * silent! '[,']s/\("[^ ]*"\)\(\s*\)=>/\1 => /g | normal! `^

" Fix Vue syntax highlighting
autocmd FileType vue syntax sync fromstart

" Fix .inky syntax highlighting (should be eruby but there is a bug)
autocmd BufNewFile,BufRead *.inky set filetype=html

map <Leader>rh :s/"\([^ ]*\)"\(\s*\)=>/\1: /g<CR>
map <Leader>hs :s/\("[^ ]*"\)\(\s*\)=>/\1 => /g<CR>
map <Leader>hm :s/=>/ => /g<CR>$v%lohc<CR><CR><Up><C-r>"<Esc>:s/,/,\r/g<CR>:'[,']norm ==<CR>

" Theme
colors mustang
hi Search       ctermfg=255 ctermbg=124 guifg=white   guibg=red
hi Folded       ctermfg=255 ctermbg=232 guifg=#a0a8b0 guibg=#384048
hi Visual       ctermfg=15  ctermbg=236 guifg=#faf4c6 guibg=#3c414c

" Overwritten by lightline
"hi StatusLine   ctermfg=14  ctermbg=238  guifg=#a0a8b0 guibg=#384048
"hi StatusLineNC ctermfg=238 ctermbg=15  guifg=#444444 guibg=#444444
hi VertSplit    ctermfg=238 ctermbg=238 guifg=#444444 guibg=#444444 term=reverse cterm=reverse

hi ErrorMsg     ctermfg=15  ctermbg=88  guifg=#a0a8b0 guibg=#384048
hi PreProc      ctermfg=229             guifg=#faf4c6               term=underline
hi Function     ctermfg=15                                          cterm=bold
hi SpellCap     ctermfg=15  ctermbg=236
hi Todo         ctermfg=16 ctermbg=11

hi NeomakeWarningSign         ctermfg=white ctermbg=52
hi NeomakeErrorSign           ctermfg=white ctermbg=124
hi NeomakeVirtualtextError ctermbg=234 ctermfg=238
hi NeomakeVirtualtextWarning ctermbg=234 ctermfg=238
hi NeomakeVirtualtextInfo ctermbg=234 ctermfg=238
hi NeomakeVirtualtextMessage ctermbg=234 ctermfg=238

" Fuzzy file finder
noremap ff <Esc>:FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Trailing whitespace highlighting
set list
set listchars=tab:→\ ,trail:.

" Shift-klear
nnoremap <S-K> ""
noremap <S-K> :noh<CR>:NeomakeClean<CR>:Neomake<CR>

" Strip trailing whitespace
command! Stw :%s/\s\+$//

" Copy to sys clipboard
set clipboard=unnamedplus
imap <Leader>y "+y

" Less cluttered folded lines
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

" Async Linting
call neomake#configure#automake('nw', 1000)
let g:neomake_warning_sign = {
         \   'text': '*',
         \   'texthl': 'NeomakeWarningSign',
         \ }
let g:neomake_error_sign = {'text': '!', 'texthl': 'NeomakeErrorSign'}
let g:neomake_message_sign = {
          \   'text': '-',
          \   'texthl': 'NeomakeWarningSign',
          \ }
let g:neomake_info_sign = {'text': '-', 'texthl': 'NeomakeWarningSign'}
let g:neomake_tempfile_enabled = 0

let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
let g:neomake_virtualtext_prefix = ''

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
hi IndentGuidesEven guibg=gray ctermbg=235
hi IndentGuidesOdd guibg=gray ctermbg=235

" vim-test
function! VimuxSimpleCommand(cmd)
  call VimuxRunCommand(a:cmd)
endfunction

let g:test#custom_strategies = {'vimux_simple': function('VimuxSimpleCommand')}
let test#strategy = "vimux_simple"
let g:test#preserve_screen = 1
let test#javascript#jest#executable = 'yarn test --silent'
noremap Q :w<CR>:TestNearest<CR>
noremap - :w<CR>:TestNearest<CR>
noremap <C-T> :w<CR>:TestNearest<CR>
inoremap <C-T> <Esc>:w<CR>:TestNearest<CR>
map <Leader>rf :w<CR>:TestFile<CR>

" Lightline
let g:lightline = {'component_function': {'filename': 'LightLineFilename'}}
function! LightLineFilename()
  return expand('%')
endfunction

" Ag
if executable('ag')
  let g:ackprg = 'ag --vimgrep --hidden'
endif

" Open Markdown in Github
noremap <silent> <leader>om :call OpenMarkdownPreview()<cr>

function! OpenMarkdownPreview()
  if exists('s:markdown_job_id') && s:markdown_job_id > 0
    call jobstop(s:markdown_job_id)
    unlet s:markdown_job_id
  endif
  let s:markdown_job_id = jobstart(
    \ 'grip ' . shellescape(expand('%:p')) . " 0 2>&1 | awk -F ':|/' '/Running/ { print $5 }'",
    \ { 'on_stdout': function('OnGripStart'), 'pty': 1 })
endfunction

function! OnGripStart(job_id, data, event)
  let port = a:data[0][0:-2]
  call system('google-chrome http://localhost:' . port)
endfunction

