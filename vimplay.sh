set -x

rm -rf ~/vimplay/
cp -r ~/.vim ~/vimplay
rm -rf ~/vimplay/bundle/
rm -rf ~/vimplay/.git/
rm -rf ~/vimplay/.gitmodules
rm -rf ~/vimplay/.netrwhist
rm -rf ~/vimplay/python-mode/.git/
cp ~/vimplay.sh ~/vimplay/

cd ~/vimplay
git init
git remote add origin https://cbull@bitbucket.org/cbull/vimfiles.git
#git add .
#git commit -am "initial commit"
mkdir ~/vimplay/bundle/

git submodule add https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim bundle/ctrlp
git submodule add https://github.com/davidhalter/jedi-vim.git bundle/jedi-vim
git submodule update --init --recursive
git submodule add https://github.com/scrooloose/nerdtree.git bundle/nerdtree
git submodule add https://github.com/vim-scripts/pydoc.vim.git bundle/pydoc
#
#vim snipmate
git submodule add https://github.com/tomtom/tlib_vim.git bundle/tlib_bim
git submodule add https://github.com/MarcWeber/vim-addon-mw-utils.git bundle/mw-utils
git submodule add https://github.com/garbas/vim-snipmate.git bundle/vim-snipmate
git submodule add https://github.com/honza/vim-snippets.git bundle/vim-snippets
git submodule add git://github.com/SirVer/ultisnips.git bundle/ultisnips bundle/ultisnips
#vim snipmate

git submodule add https://github.com/bling/vim-airline bundle/vim-airline
git submodule add https://github.com/tpope/vim-fugitive.git bundle/vim-fugitive
git submodule add https://github.com/airblade/vim-gitgutter.git bundle/vim-gitgutter
git submodule add https://github.com/nathanaelkane/vim-indent-guides.git bundle/vim-indent-guides
git submodule add https://github.com/jmcantrell/vim-virtualenv.git bundle/vim-virtualenv
git add .
git commit -am "initial commit with all the submodules"

