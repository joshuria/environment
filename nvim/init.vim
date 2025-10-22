" source $VIMRUNTIME/mswin.vim

set nocompatible
set langmenu=en
set termencoding=utf8
set encoding=utf8
set fileencodings=ucs-bom,utf-8,big5,latin1,utf-16
set fileencoding=utf-8

set nu
set sw=4
set ts=4
set smarttab
set et
set lbr
set guioptions-=T
set ff=unix
set so=4
set nobackup
set directory=/tmp
set undodir=/tmp
set laststatus=2
"set cursorline
set foldcolumn=2
set foldlevelstart=20
set fdm=syntax

set mouse=a
set title
set ww="b,s"

" case insensitive file name completion
set wildignorecase

" Prompt reload
set noautoread
au FocusGained * :checktime

" Highlight special chars
"set lcs=tab:▷\ ,trail:·,extends:◣,precedes:◢,nbsp:○,eol:↵
set lcs=tab:▷\ ,trail:·,extends:◣,precedes:◢,nbsp:○
set list

command! -nargs=? -range=% -complete=custom,s:StripCompletionOptions
    \ Stripsp <line1>,<line2>call s:Stripsp(<f-args>)

function! s:Stripsp(...) abort
    let confirm = a:0
    execute a:firstline . ',' . a:lastline . 's/\s\+$//e' . (confirm ? 'c' : '')
endfunction

function! s:StripCompletionOptions(A,L,P) abort
    return "-confirm"
endfunction


" Moving tab
nnoremap <silent><A-Left> :tabm -1<CR>
nnoremap <silent><A-Right> :tabm +1<CR>
map <F1> <nop>
map <C-down> <C-E>
map <C-up> <C-Y>
nnoremap <C-Enter> :checktime<CR>

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" copy paste cut save select-all
" Ref https://github.com/vim/vim/blob/master/runtime/mswin.vim
if has("clipboard")
    " Copy
    vnoremap <C-C> "+y
    " Cut
    vnoremap <C-X> "+x
    " Paste
    map <C-V> "+gP
    cmap <C-V> <C-R>+
    exe 'inoremap <script> <A-V> <A-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <A-V> ' . paste#paste_cmd['v']
    if !has("unix")
        set guioptions-=a
    endif
endif
exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']

" SelectAll
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG
" Save
noremap <C-S> :update<CR>
vnoremap <C-S> :<C-C>:update<CR>
inoremap <C-S> :<Esc>:update<CR>gi
" Undo
noremap <C-Z> u
inoremap <C-Z> <C-O>u
" Redo
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Map select current line without newline
noremap vv 0vg_

" Theme
let g:rehash256 = 1
set bg=dark
colorscheme desert
set guifont=Noto\ Mono\ for\ Powerline:h12
if exists('+colorcolumn')
  set colorcolumn=100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

" Trim tailing spaces when safe
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun
" autocmd FileType markdown autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Enable python, node
let g:python3_host_prog='/usr/bin/python3.12'

" vim-plug
call plug#begin('~/.config/nvim/plugged')

" Defx
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
Plug 'ryanoasis/vim-devicons'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'jiangmiao/auto-pairs'

Plug 'preservim/nerdcommenter'
Plug 'neoclide/jsonc.vim'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'

call plug#end()

" Defx
nnoremap <silent><F1> :Defx<CR>
autocmd FileType defx call s:defx_my_settings()
call defx#custom#option('_', {
    \ 'winwidth': 30,
    \ 'split': 'vertical',
    \ 'direction': 'botright',
    \ 'show_ignored_files': 0,
    \ 'buffer_name': '',
    \ 'toggle': 1,
    \ 'resume': 1
    \ })

function! s:defx_my_settings() abort
    setl nospell
    setl signcolumn=no
    set nonu
    nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> <2-LeftMouse>
        \ defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> c       defx#do_action('copy')
    nnoremap <silent><buffer><expr> m       defx#do_action('move')
    nnoremap <silent><buffer><expr> p       defx#do_action('paste')
    nnoremap <silent><buffer><expr> <C-Right> defx#do_action('open')
    nnoremap <silent><buffer><expr> <Right> defx#do_action('open_tree')
    nnoremap <silent><buffer><expr> <Left>  defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> E       defx#do_action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> P       defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> o       defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> K       defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N       defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M       defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
        \ defx#do_action('toggle_columns', 'git:mark:indent:icons:filename:type:size:time')
    nnoremap <silent><buffer><expr> S       defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d       defx#do_action('remove')
    nnoremap <silent><buffer><expr> r       defx#do_action('rename')
    nnoremap <silent><buffer><expr> !       defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x       defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy      defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .       defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;       defx#do_action('repeat')
    nnoremap <silent><buffer><expr> <C-Left> defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> <<      defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~       defx#do_action('cd')
    nnoremap <silent><buffer><expr> q       defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *       defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> <C-A>   defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j       line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k       line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>   defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>   defx#do_action('print')
    nnoremap <silent><buffer><expr> cd      defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr> pwd     defx#do_action('cd', [getcwd()])
endfunction
let g:defx_icons_enable_syntax_highlight = 0

" Defx-git
"let g:defx_git#column_length = 0

" Decomplete
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" deoplete-clang
"let g:deoplete#sources#clang#libclang_path = 'D:/Tools/msys64/mingw64/bin/libclang.dll'
"let g:deoplete#sources#clang#clang_header = 'D:/Tools/msys64/mingw64/include/c++'

" Vim-airline
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1
set t_Co=256

" coc, ref: https://ianding.io/2019/07/29/configure-coc-nvim-for-c-c++-development/
"set hidden
set signcolumn=yes
set cmdheight=2
set updatetime=300
set shortmess+=c

" Tab complete
" ref: https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-or-custom-key-for-trigger-completion
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
" Navigate on completion list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
"inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : coc#refresh()

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-`> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Show parameter info when moving cursor
autocmd CursorHoldI,CursorMovedI * silent! call CocActionAsync('showSignatureHelp')

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" NerdCommenter: https://github.com/preservim/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDDefaultAlign = 'left'
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" Fast fold: https://github.com/Konfekt/FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
autocmd FileType python setlocal foldmethod=indent
let g:SimpylFold_docstring_preview = 1

let g:coc_disable_startup_warning = 1

hi Search ctermfg=DarkRed

" " clipboard fix
" let g:clipboard = {
"     \   'name': 'macos+tmux',
"     \   'copy': {
"     \      '+': ['pbcopy'],
"     \      '*': ['tmux', 'load-buffer', '-'],
"     \    },
"     \   'paste': {
"     \      '+': ['pbpaste'],
"     \      '*': ['tmux', 'save-buffer', '-'],
"     \   },
"     \   'cache_enabled': 0,
"     \ }
