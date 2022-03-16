filetype plugin on
filetype indent on
set splitbelow
set splitright
set ai
set si
set wildmenu
set showmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set smartcase
set noswapfile
set nobackup
set undodir=~/.nvim/undodir
set undofile
set incsearch
set hlsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
"check
"
" Give more space for displaying messages.
set cmdheight=2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set cc=
call plug#begin('~/.config/nvim/plugged')

" coc neoclide is a autocompleter
Plug 'neoclide/coc.nvim', {'branch' : 'release'}
" its a debugger
Plug 'nvim-telescope/telescope.nvim'
"Plug 'puremourning/vimspector'
Plug 'tpope/vim-fugitive'
Plug 'bignimbus/pop-punk.vim'
" i don't know view or grep man pages 
Plug 'vim-utils/vim-man'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" gruvbox is a theme
Plug 'gruvbox-community/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'
call plug#end()
colorscheme pop-punk
" colorscheme gruvbox

" pop-punk ANSI colors for vim terminal
let g:terminal_ansi_colors = pop_punk#AnsiColors()

let mapleader = " "
nmap <leader>w :w!<cr>
"nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
function! TermWrapper(command) abort
	if !exists('g:split_term_style') | let g:split_term_style = 'vertical' | endif
	if g:split_term_style ==# 'vertical'
		let buffercmd = 'vnew'
	elseif g:split_term_style ==# 'horizontal'
		let buffercmd = 'new'
	else
		echoerr 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'' but is currently set to ''' . g:split_term_style . ''')'
		throw 'ERROR! g:split_term_style is not a valid value (must be ''horizontal'' or ''vertical'')'
	endif
	if exists('g:split_term_resize_cmd')
		exec g:split_term_resize_cmd
	endif
	exec buffercmd
	exec 'term ' . a:command
	exec 'setlocal nornu nonu'
	"exec 'startinsert'
    "autocmd BufEnter <buffer> startinsert
endfunction

"vim-fugitive intergration remaps
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
"remaping ctrl + c to copy to system clipboard
vnoremap <C-c> "*y
command! -nargs=0 CompileAndRun call TermWrapper(printf('g++ -std=c++11 %s && ./a.out', expand('%')))
command! -nargs=1 CompileAndRunWithFile call TermWrapper(printf('g++ -std=c++11 %s && ./a.out < %s', expand('%'), <args>))
autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>

" For those of you that like to use the default ./a.out
" This C++ toolkit gives you commands to compile and/or run in different types
" of terminals for your own preference.
" NOTE: this version is more stable than the other version with specified
" output executable!
augroup CppToolkit
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 % && ./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./a.out<CR>
	autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>
augroup END

" For those of you that like to use -o and a specific outfile executable
" (i.e., xyz.cpp makes executable xyz, as opposed to a.out
" This C++ toolkit gives you commands to compile and/or run in different types
" of terminals for your own preference.
augroup CppToolkit
	autocmd FileType cpp nnoremap <leader>fb :!g++ -std=c++11 -o %:r % && ./%:r<CR>
	autocmd FileType cpp nnoremap <leader>fr :!./%:r.out<CR>
augroup END

" options
" choose between 'vertical' and 'horizontal' for how the terminal window is split
" (default is vertical)
let g:split_term_style = 'vertical'

" add a custom command to resize the terminal window to your preference
" (default is to split the screen equally)
"let g:split_term_resize_cmd = 'resize 6'
