call pathogen#infect()
call pathogen#helptags()

syntax on
filetype plugin indent on
"
"
" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	let login = system('whoami')
	if v:shell_error
	   let login = 'unknown'
	else
	   let newline = stridx(login, "\n")
	   if newline != -1
		let login = strpart(login, 0, newline)
	   endif
	endif
	let hostname = system('hostname -f')
	if v:shell_error
	    let hostname = 'localhost'
	else
	    let newline = stridx(hostname, "\n")
	    if newline != -1
		let hostname = strpart(hostname, 0, newline)
	    endif
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()
"tab shortcut keys

"for rainbow highlighting with vim-niji
let g:niji_matching_filetypes = ['python']


"search and replace with ctrl r
" FUNCTION for search and replace start
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/
vmap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>//gc<left><left><left>
" FUNCTION for search and replace END


"""" Sample .vimrc file by Martin Brochhaus
" Presented at PyCon APAC 2012


" Automatic reloading of .vimrc
"autocmd! bufwritepost .vimrc source %
 
 
" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F3>

" Mouse and backspace
" set mouse=a " on OSX press ALT and click
set bs=2 " make backspace behave like normal again


" Color scheme
"mkdir -p ~/.vim/colors && cd ~/.vim/colors
"wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
"set t_Co=256
"color wombat256mod

"syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized


" ============================================================================
" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2


" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
let g:jedi#usages_command = "<leader>z"
"let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
let g:jedi#use_splits_not_buffers = "right"

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
if pumvisible()
if a:action == 'j'
return "\<C-N>"
elseif a:action == 'k'
return "\<C-P>"
endif
endif
return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

"tries to fix clipboard
set clipboard=unnamed

"hotkey for tagbar
"requires: sudo apt-get install exuberant-ctags
"if not in path can use...
"let g:tagbar_ctags_bin='/path/to/exuberant-ctags/'
let g:tagbar_usearrows = 1
nmap <F8> :TagbarToggle<CR>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

"run file in python
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

"""" Sample .vimrc file by Martin Brochhaus

nnoremap <C-y> "+Y
vnoremap <C-y> "+Y
nnoremap <C-p> "+gp
vnoremap <C-p> "+gp
"inoremap <Tab> <C-X><C-F>
"colorscheme elflord
"" colors koehler

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

"Rebind <Leader> key
let mapleader = ","

"Gundo
nnoremap <F4> :GundoToggle<CR>


"GitGutter Toggle changed highlights
nnoremap <F3> :GitGutterLineHighlightsToggle<CR>

"Flake8 remap
autocmd FileType python map <buffer> <F5> :call Flake8()<CR>

"autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>

:nnoremap <C-q>import pdb;pdb.set_trace()<Esc>
:command SPlot :normal i plt.close('all')<Enter>fig=plt.figure()<Enter>ax=fig.add_subplot(1, 1,1)<ESC>
:command Pdb :normal i import pdb;pdb.set_trace()<ESC>
:command Plot :normal i plt.close('all')<Enter>fig=plt.figure()<Enter>ax=fig.add_subplot(1, 1,1)<Enter>ax.set_title('')<Enter>ax.set_xlabel('')<Enter>ax.set_ylabel('')<Enter>#fig.savefig('./.png',dpi=300)<Enter>plt.show()<ESC>


"Vexplore option for netrw
"" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" " file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
"
" " Change directory to the current buffer when opening files.
set autochdir



" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader>k"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"remap escape key
:imap jj <Esc>

" IndentGuide stuff
let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red ctermbg=lightgrey
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=white
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=4
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"colorscheme delek "needs to go after the indent guide
"colorscheme elflord
"colorscheme elflord
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

"docs 
set completeopt=menuone,longest,preview

"Rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

"folding
set foldmethod=indent
set foldlevel=99

"code completion
let g:SuperTabDefaultCompletionType = "context"

"searching with ack!
nmap <leader>a <Esc>:!ack-grep 

"NERDTree
map <F2> :NERDTreeToggle<CR>


"Some old rsync bound commands
"nnoremap <buffer> <F7> :exec '!mkdir ~/codescratch/' <bar>  :exec '!rsync -avz  z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/*.py ~/codescratch/' <bar> exec '!rsync -avz  z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/cookies/*.py ~/codescratch/cookies/' <cr>
"nnoremap <buffer> <F8> :exec '!rsync -avz ~/codescratch/*.py z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/' <bar> exec '!rsync -avz ~/codescratch/cookies/*.py z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/cookies/' <cr>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window for multiple buffers, and/or:
" set confirm
" set autowriteall

" Better command-line completion
set wildmode=longest,list

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=vn

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
"set paste!


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
"set textwidth=79

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------



" ~/.vimrc ends here
"
"
"More edits from:
"http://stevelosh.com/blog/2010/09/coming-home-to-vim/
"Some of these require vim 7.3...
set encoding=utf-8
set scrolloff=3
set showmode
set wildmenu
set cursorline
set ttyfast
set backspace=indent,eol,start
set relativenumber           "new in 7.3
set undofile                 "new in 7.3

"more changes that I might not like
""this effects search regex
nnoremap / /\v
vnoremap / /\v
"this effects search regex
set incsearch
set showmatch
nnoremap <leader><space> /mooblahnahnah<cr>  "turn off search highlights
nnoremap <tab> %
vnoremap <tab> %
"open edvim in split
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>es <C-w><C-v><C-l>:e ~/.vim/UltiSnips/python.snippets<cr>


"select just pasted text
nnoremap <leader>v V`]
"highlight column 81
let &colorcolumn=join(range(81,83),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
"for yankring
nnoremap <silent> <F11> :YRShow<CR>

let g:yankring_replace_n_pkey = '<C-I>'


"for some sort of very frustrating reason, these had to go at the bottom...
nnoremap <leader>pwd :exec 'r!pwd'<bar><cr>
nnoremap <leader>ls :exec 'r!ls'<bar><cr>
noremap <Leader>sa :CtrlP /home/nfs/z3457920/hdrive/repos/swissarmy<cr>
noremap <Leader>cm :CtrlP /home/nfs/z3457920/hdrive/repos/cms_analysis<cr>
