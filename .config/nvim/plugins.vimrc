"" -------
"" Plugins
"" -------

call plug#begin(stdpath('data') . '/plugged')

" -- Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" -- Git plugins
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" -- Log handling
Plug 'MTDL9/vim-log-highlighting' 

" -- NERDTree
Plug 'preservim/nerdtree'


" Surround
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Color scheme
Plug 'romainl/Apprentice', { 'as': 'apprentice'}
Plug 'chriskempson/base16-vim'
Plug 'altercation/vim-colors-solarized'

" Supercharged status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


call plug#end()

colorscheme apprentice
"colorscheme base16-default-dark
