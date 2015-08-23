"Author:  Abe van der Wielen
"Email:   abevanderwielen@gmail.com
"Date:    2015-04-06 
"Website: https://github.com/the-abe
"File:    .vimrc

"Required
set nocompatible "Compatibility mode is horrible
filetype off "Required for Vundle. We'll turn it back on later.

"Vundle required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

"Vundle plugins!
Plugin 'scrooloose/syntastic' "Syntax checking.
Plugin 'majutsushi/tagbar' "Ctags browser. Also used in statusline.
Plugin 'kien/ctrlp.vim' "File explorer.
Plugin 'matchit.zip' "Make % work with more stuff like ruby keywords.
Plugin 'tpope/vim-surround' "Surround stuff with other stuff.
Plugin 'vimwiki' "Wiki inside vim that I use for Pathfinder and DND
Plugin 'tomasr/molokai' "Colorscheme
Plugin 'tpope/vim-commentary' "Easy comment mappings
Plugin 'AndrewRadev/splitjoin.vim' "Map gS and gJ to join and split statements.
Plugin 'mileszs/ack.vim' "Search code with ack, because ack is awesome.
Plugin 'rstacruz/sparkup' "Edit html using sparkup syntax
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'junegunn/goyo.vim'

"Vundle required
call vundle#end()

" Leader
let mapleader=" "
nnoremap <SPACE> <Nop>

"Vimwiki wikis
let g:vimwiki_list = [{'path': '~/Dropbox/Pathfinder/', 'path_html': '~/Dropbox/Pathfinder/html'}]

"Basics
syntax on "Syntax highlighting
filetype plugin indent on "Filetype detection
set history=1000 "command history to remember
set autoread "Autoread the file when outside changes occur
set scrolloff=2 "extra lines to show when scrolling
set ruler "Always show current position
set cmdheight=1 "Height of the command bar
set hid "A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent "Configure backspace so it acts as it should act
set ignorecase "Ignore case when searching
set smartcase "When searching try to be smart about cases
set hlsearch "Highlight search results
set incsearch "Makes search act like search in modern browsers
set magic "For regular expressions turn magic on
set noshowmatch "Dont show matching brackets when text indicator is over them
set encoding=utf8 " Set utf8 as standard encoding
set ffs=unix,dos,mac " Use Unix as the standard file type
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set viminfo^=% "Remember info about open buffers on close
set laststatus=2 "Always show the status line
set smarttab "Make backspace remove one indent worth of spaces.
set relativenumber "Relative numbers
set number "Make the current line number visible
set ttyfast "Inform vim that we have a fast terminal and it can just redraw
set lazyredraw "Don't redraw the screen for every single thing I do.
set linebreak "Only wrap on sensible breaking points
set shiftround "When shifting indents with <,>, round to nearest valid indent.
set textwidth=80 "80 characters for wrapping
set formatoptions=qrn1j "Better format options see :h fo-table
colorscheme molokai
set t_Co=256 "COLOUR ALL THE THINGS!
set modeline "Enable modelines
set modelines=5 "Check 5 lines for modelines

"Turn on the wiLd menu
set wildmenu
set wildmode=longest:full

"Turn backup off
set nobackup
set nowb
set noswapfile

"1 tab = 2 spaces
set expandtab
set shiftwidth=2
set tabstop=2

"Return to last edit position when opening files
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

"Statusline including Syntastic end Tagbar tag.
set statusline=%#error#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%#label#\ %<%t\ 
set statusline+=[%(%M%R%Y%)]\ 
set statusline+=%#function#%{tagbar#currenttag('%s','')}\ 
set statusline+=%=%-1(%#keyword#%l/%L%)

"folding
set foldmethod=indent
set foldlevelstart=99

"Surround ruby
"45 = -
"95 = _ (<S-->)
let g:surround_45 = "<%- \r -%>"
let g:surround_95 = "<%= \r -%>"
nmap <leader>- yss-
nmap <leader>= yss_
imap <leader>- <c-o>yss-<esc>$bbea
imap <leader>= <c-o>yss_<esc>$bbea

"Call tidyhtml or tinyxml
command! Tidyhtml :%!tidy -q -i --show-errors 0
function! Tidyxml()
  :%!tidy -q -i --show-errors 0 -xml
  :set ft=xml
endfunction
command! Tidyxml :call Tidyxml()

"Force c-c for esc. Remapped so c-c completes abbreviations and stuff.
"(I have CapsLock mapped to the control key.)
inoremap <c-c> <esc>

"Center on search results
nnoremap N Nzz
nnoremap n nzz

"H/L for really fast end and home.
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

"Mash the enter key to indent the current line and go to the next
"nnoremap <cr> ==j

"Speaking of indents
nnoremap <c-h> <<
nnoremap <c-l> >>
inoremap <c-h> <c-o><<
inoremap <c-l> <c-o>>>
vnoremap <c-h> < gv
vnoremap <c-l> > gv

"Move lines
nnoremap <c-k> :move-2<cr>
nnoremap <c-j> :move+<cr>
vnoremap <c-k> :move-2<cr>gv
vnoremap <c-j> :move'>+<cr>gv

"Turn 2+2 into 2+2=4
nnoremap <leader>bc :.!bc -l<cr>

"Shortcut .vimrc
nnoremap <leader>ve :e ~/.vimrc<cr>
nnoremap <leader>vs :source ~/.vimrc<cr>

"Spelling
set spelllang=nl,en
nnoremap <f9> :set spell!<cr>

"Blowfish for Encryption when saving a file with :X
set cm=blowfish

"Highlight folds with nothing, to prevent headaches.
highlight Folded ctermfg=none ctermbg=none
highlight FoldColumn ctermfg=none ctermbg=none

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_height = 20
"<c-b> for buffers
nnoremap <silent> <c-b> :CtrlPBuffer<cr>

"Author email date etc abbreviations
iabbrev name/ Abe van der Wielen
iabbrev email/ abevanderwielen@gmail.com
iabbrev date/ <c-r>=strftime("%F")<CR> 
iabbrev file/ <c-r>%
iabbrev github/ https://github.com/the-abe

" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

"Toggle common options
nnoremap <leader>p :set paste!<cr>
nnoremap <leader>w :set wrap!<cr>
nnoremap <leader>h :set hlsearch!<cr>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

"Completion mappings because I'm too lazy to type <c-x>
inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>
inoremap <c-n> <c-x><c-n>

"Home and end just like bash
inoremap <c-a> <c-o>I
inoremap <c-e> <c-o>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

"Different background colour past 121 characters
let &colorcolumn=join(range(121,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

"Check ruby with ruby -wc
autocmd Filetype ruby nnoremap <silent> <f5> :SyntasticCheck<cr>:Errors<cr>

" Markdown headings
nnoremap <leader>1 mPyypVr=`P
nnoremap <leader>2 mPyypVr-`P
nnoremap <leader>3 mPI### <esc>`P3l
nnoremap <leader>4 mPI#### <esc>`P5l
nnoremap <leader>5 mPI##### <esc>`Pi6l

"commentary mapping
nnoremap <silent> <leader>c :Commentary<cr>
vnoremap <silent> <leader>c :Commentary<cr>

"Close temp screens with q
au FileType help nnoremap q :q!<cr>
au FileType qf nnoremap q :q!<cr>

" Goyo
let g:goyo_width=120
nnoremap <leader>g :Goyo<cr>:set guifont=Latin\ Modern\ Mono\ Light\ 13<cr>
nnoremap <leader><leader>g :Goyo<cr>:set guifont=DejaVu\ Sans\ Mono\ 11<cr>

" Pandoc options
" Hard breaks and text width
let g:pandoc#formatting#mode="h"
let g:pandoc#formatting#textwidth=120
"
" Insert language tags with \\
au FileType eruby inoremap <leader><leader> <%  %><left><left><left>
au FileType php inoremap <leader><leader> <?php  ?><left><left><left>

"Guifont
set guifont=DejaVu\ Sans\ Mono\ 11"
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
