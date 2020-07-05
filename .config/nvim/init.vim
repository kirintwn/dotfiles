filetype off 

" ##################################Install Plugin##################################
call plug#begin('~/.config/nvim/plugged')

Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'

" fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" nerd tree
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" multiple cursors
" <C-n>
Plug 'terryma/vim-multiple-cursors'

" commenter
" <leader>cc, <leader>cu
Plug 'scrooloose/nerdcommenter'

" indentline
Plug 'Yggdroot/indentLine'

"git
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" tags
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'multilobyte/gtags-cscope'

" polyglot 
Plug 'sheerun/vim-polyglot'

call plug#end()

" ##################################ShortCut setting##################################
" ************switch between tabs************
nnoremap <C-W> :bn<CR>
nnoremap <C-E> :bp<CR>
nnoremap <C-Q> :bd<CR>

" *************F5 Auto Compile (Normal+Visual mode)***********
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!clear":
        exec "!time python3 %"
    elseif &filetype == 'go'
        " exec "!go build %<"
        exec "!time go run %"
    endif
endfunc

" *************ctrl+s Save (Insert mode)*************
imap <C-s> <Esc>:w!<CR>i

" ##################################Vim Color Setting##################################
set t_Co=256
colorscheme gruvbox

hi vertsplit ctermbg=bg guibg=bg
hi GitGutterAdd ctermbg=bg guibg=bg
hi GitGutterChange ctermbg=bg guibg=bg
hi GitGutterDelete ctermbg=bg guibg=bg
hi GitGutterChangeDelete ctermbg=bg guibg=bg
hi SyntasticErrorSign ctermbg=bg guibg=bg
hi SyntasticWarningSign ctermbg=bg guibg=bg
hi FoldColumn ctermbg=bg guibg=bg


" ##################################Vim Setting##################################
syntax on
syntax enable
filetype plugin indent on

set nocompatible
set history=1000
set laststatus=2

set mouse=a
set cursorline

set nu
set autoindent
set showmatch
set scrolloff=4
set backspace=2
set clipboard+=unnamedplus

set tabstop=4
set shiftwidth=4
set expandtab

set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·

set hlsearch
set incsearch
set ignorecase
set smartcase

set foldenable
set foldmethod=marker

set encoding=utf-8
set fileencodings=utf-8

let g:auto_save = 1
let g:auto_save_events = [
\       'InsertLeave',
\       'TextChanged',
\       'TextChangedI',
\       'CursorHoldI',
\       'CompleteDone'
\   ]

" ##################################Python Setting##################################
let python_highlight_all=1
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99


" ##################################PlugIn Setting##################################
" *************vim-airline setting*************
" Check themes here: https://github.com/jaredramirez/vim-airline-themes/blob/a643026f0b666974fdfc0e7474b3a70a7ef4101c/doc/airline-themes.txt
let g:airline_theme='bubblegum'                                                                                                            
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extenions#tabline#buffer_nr_show = 1

" *************Nerd Tree*************
map <silent> - :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" *************Nerd Tree git*************
let g:NERDTreeIndicatorMapCustom = {
\       'Modified' : '✹',
\       'Staged'   : '✚',
\       'Untracked': '✭',
\       'Renamed'  : '➜',
\       'Unmerged' : '═',
\       'Deleted'  : '✖',
\       'Dirty'    : '✗',
\       'Clean'    : '✔︎',
\       'Ignored'  : '☒',
\       'Unknown'  : '?'
\   }

" *************IndentLine*************
let g:indentLine_char = '|'
let g:indentLine_color_term = 239

" *************Nerdcommenter*************
let g:NERDSpaceDelims=1

" *************Gutentags*************
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'

let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--list-kinds=python']
let g:gutentags_ctags_extra_args += ['--Go-kinds=+cf']
let g:gutentags_ctags_extra_args += ['--list-kinds=typescript']
let g:gutentags_ctags_extra_args += ['--list-kinds=javascript']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_auto_add_gtags_cscope = 0
let g:gutentags_define_advanced_commands = 1
let g:gutentags_trace = 1

let g:gutentags_ctags_exclude = [
\       '*.css',
\       '*.html',
\       '*.json',
\       '*.xml',
\       '*.phar',
\       '*.ini',
\       '*.rst',
\       '*.md',
\       '*.bin',
\       '*storage/*',
\       '*vendor/*',
\       '*node_modules/*',
\       '*public/*'
\   ]
let g:gutentags_plus_switch = 1

" *************Tagbar*************
map <silent> = :TagbarToggle<CR>
let g:tagbar_type_go = {
\       'ctagstype': 'go',
\       'kinds': [
\           'p:package',
\           'i:imports:1',
\           'c:constants',
\           'v:variables',
\           't:types',
\           'n:interfaces',
\           'w:fields',
\           'e:embedded',
\           'm:methods',
\           'r:constructor',
\           'f:functions'
\       ],
\       'sro': '.',
\       'kind2scope': {
\           't': 'ctype',
\           'n': 'ntype'
\       },
\       'scope2kind': {
\           'ctype': 't',
\           'ntype': 'n'
\       },
\       'ctagsbin': 'gotags',
\       'ctagsargs': '-sort -silent'
\   }

" *************fzf*************
" shortcuts
nnoremap <leader>fl  :Lines 
nnoremap <leader>fb  :BLines 
nnoremap <leader>ff  :Files 
nnoremap <leader>fg  :GFiles 
nnoremap <leader>f?  :GFiles? 
nnoremap <leader>ft  :Tags<cr>
nnoremap <leader>fa  :Ag 
nnoremap <leader>fc  :Commits
nnoremap <leader>fh  :History
nnoremap <leader>fh? :History:

" Show untracked files and still exclude git ignored files
" Reference: https://github.com/junegunn/fzf.vim/issues/121#issuecomment-575922206
nnoremap <silent> <leader>j :GFiles --cached --others --exclude-standard<cr>

" This is the default extra key bindings
let g:fzf_action = {
\       'ctrl-t': 'tab split',
\       'ctrl-x': 'split',
\       'ctrl-v': 'vsplit'
\   }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
\       'fg'     : ['fg', 'Normal'],
\       'bg'     : ['bg', 'Normal'],
\       'hl'     : ['fg', 'Comment'],
\       'fg+'    : ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\       'bg+'    : ['bg', 'CursorLine', 'CursorColumn'],
\       'hl+'    : ['fg', 'Statement'],
\       'info'   : ['fg', 'PreProc'],
\       'border' : ['fg', 'Ignore'],
\       'prompt' : ['fg', 'Conditional'],
\       'pointer': ['fg', 'Exception'],
\       'marker' : ['fg', 'Keyword'],
\       'spinner': ['fg', 'Label'],
\       'header' : ['fg', 'Comment']
\   }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" *************Conquer of Completion*************
" coc config
let g:coc_global_extensions = [
\       'coc-tabnine',
\       'coc-python',
\       'coc-cfn-lint',
\       'coc-tsserver',
\       'coc-eslint', 
\       'coc-prettier', 
\       'coc-json',
\       'coc-yaml',
\       'coc-snippets',
\       'coc-pairs',
\   ]

" From README
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=3000

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap<tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call   CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold   :call   CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR     :call   CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Reset cursor to original style (vertical line with blinks)
" Reference: https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
au VimLeave * set guicursor=a:ver1-blinkon1
