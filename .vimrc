
filetype off                   " required!
set nocompatible " .... VI. .... ..
set autoindent  " .. ....
set cindent " C ...... .. ....
set smartindent " .... ....
set wrap 
set nowrapscan " ... . ... ... .... ....
set nobackup " .. ... ...
set visualbell " .. ..... . .. ...
set ruler " .. .. ... .. ... ..(.,.) ..
set shiftwidth=4 " .. .... 4.
set number " ... .., set nu . ..
set fencs=ucs-bom,utf-8,euc-kr.latin1 " .. ... euc-kr., ..... .....
set fileencoding=utf-8 " ....... 
set tenc=utf-8      " ... ...
set expandtab " ... ....
set hlsearch " ... .., set hls . ..
set ignorecase " ... .... .., set ic . ..
set tabstop=4 "  .. 4...
set lbr
set incsearch "  ... ... ... ..
syntax on "  .... ..
filetype indent on "  .. ... .. ....
set background=dark " ..... lihgt / dark
colorscheme desert  "  vi .. .. ..
set backspace=eol,start,indent "  .. ., .., ...... ...... ....
set history=1000 "  vi .... .... .viminfo. ..

 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()

 Plugin 'gmarik/Vundle.vim'
 Plugin 'The-NERD-Tree' 
 Plugin 'Source-Explorer-srcexpl.vim' 
 Plugin 'SrcExpl' 
 Plugin 'taglist.vim' 
 Plugin 'AutoComplPop' 
 Plugin 'snipMate'
 call vundle#end()


 "========== AutoCompletePop ==========
 function! InsertTabWrapper()
	 let col=col('.')-1
	 if !col||getline('.')[col-1]!~'\k'
		 return "\<TAB>"
	 else
		 if pumvisible()
			 return "\<C-N>"
		 else
			 return  "\<C-N>\<C-P>"
		 end 
	 endif
 endfunction


 inoremap <TAB> <c-r>=InsertTabWrapper()<cr>
 hi Pmenu ctermbg=white
 hi PmenuSel ctermbg=yellow ctermbg=black
 hi PmenuSbar ctermbg=blue
 set tags+=/usr/src/linux-3.18.21/tags
" NERD Tree. ... ..

let NERDTreeWinPos = "left"

" NERD Tree. F7.. Tag List. F8.. ...

nmap <F7> :NERDTree<CR>

nmap <F8> :TlistToggle<CR>

filetype on

" Tag list. .... ctags. .. ..

let Tlist_Ctags_Cmd = "/usr/bin/ctags"

let Tlist_Inc_Winwidth = 0

let Tlist_Exit_OnlyWindow = 0

let Tlist_Auto_Open = 0

" Tag list .. ..... ..

let Tlist_Use_Right_Window = 1
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb

if filereadable("./cscope.out")
    cs add cscope.out
else 
    cs add /usr/src/linux/cscope.out
endif
set csverb
