" Comments in Vimscript start with a `"`.

lua << EOF
	require('new_init')
EOF


" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Make leader a more usable key
let mapleader = ' '

" Quickly insert an empty line without leaving normal mode
nnoremap <LEADER>o o<Esc>
nnoremap <LEADER>O O<Esc>

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Use tab for moving to matching braces while also visually select them
nnoremap <tab> v%
vnoremap <tab> %

" No need to use shift for :
nnoremap ; :

" FZF easier mapping
nnoremap <leader>s :<C-u>FZF<CR> 

" NERDTree remapping
map <leader>n :NERDTreeToggle<CR>


" Easier window contorl using the leader key instead of "Ctrl" key.
nmap <LEADER>w <C-w>
nnoremap <C-w>f :wincmd _<CR>:wincmd \|<CR>
nnoremap <C-w>e <C-w>=

" Automatically set Vim's working directory to the currently open buffer
autocmd BufEnter * lcd %:p:h

" Make search and replace global by default
set gdefault

" Use the default OSX clipboard
set clipboard=unnamedplus

