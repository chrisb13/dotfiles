#export SHELL=/usr/bin/zsh
#exec $SHELL

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


#function parse git branch
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

#neds version
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases

case $(hostname) in
    typhoon.ccrc.unsw.edu.au|katana.science.unsw.edu.au) 
        module load hdf5           
        module load ncview
        module load netcdf/3.6.3-intel 
        #module load netcdf
        module load intel
        module load matlab/2011b
        module load python
        module load proj
        alias qint='qsub -I -l nodes=1:ppn=1,vmem=15gb,walltime=2:00:00'
        alias qme='qstat -nru $USER'
        alias qme2='qstat | grep z3457920'
        ;;
    squall.ccrc.unsw.edu.au|maelstrom.ccrc.unsw.edu.au|monsoon.ccrc.unsw.edu.au)
        alias open='nautilus . &'
        #alias v='vimx'
        alias vi='vimx'
        alias vim='vimx'
        alias ps='module load geos; module load perl/5.18.2;module load gdal;source ~/env/newstorm_env/bin/activate'
        alias topme='top -u z3457920'
        module load hdf5               #for new storm servers
        module load ncview
        module load netcdf/3.6.3-intel
        #module load netcdf
        module load intel
        module load matlab/2011b
        module load python
        module load proj
        ;;
    ccrc165) 
        # enable programmable completion features (you don't need to enable
        # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
        # sources /etc/bash.bashrc).
        if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
            . /etc/bash_completion
        fi
        source ~/.fzf.bash
        alias open='dolphin . &'
        alias vi='vim'
        alias ps='source ~/env/ccrc_env/bin/activate'
        alias fixdesk='kstart plasma-desktop &'
        ;;
    ubuntudesktop) 
        #chris home desktop dual boot
        source ~/myenv/bin/activate
        alias grabplots='rsync -avz z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/cookiecutting07/plots/depint/ ~/plotscratch/'
        alias open='nautilus .'
        ;;
    chris-VirtualBox2)
        #chris home laptop 
        source ~/my_env/bin/activate
        alias r='cd ~/codescratch/cms_analysis/hp_validation/'
        alias open='pcmanfm'
        ;;
    chris-DeskVirtualBox)
        #chris home desktop
        # added by Anaconda 2.3.0 installer
        export PATH="/home/chris/anaconda/bin:$PATH"
        ;;
esac

alias checkh='mount | grep hdrive'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias u='cd ..'
alias c='clear'
alias edprof='vi ~/.bashrc'
alias edsnip='vi ~/.vim/UltiSnips/python.snippets'
alias edvim='vi ~/.vimrc'
alias runprof='. ~/.bashrc'
alias py='python '
alias top='top -M'

#folders
alias ml='matlab -nodesktop'
alias cbd='cd /srv/ccrc/data23/z3457920/leeuwincurrent/'
alias cbd2='cd /srv/ccrc/data32/z3457920/leeuwincurrent2/'
alias cbd3='cd /srv/ccrc/data32/z3457920/leeuwincurrent3/'
alias cbd4='cd /srv/ccrc/data42/z3457920/'
alias r='cd ~/hdrive/repos/cms_analysis/'
alias v='cd ~/.vim/'
alias p='cd ~/hdrive/repos/cms_analysis/papers/20141202_leeuwincurrent'
alias sa='cd ~/hdrive/repos/swissarmy/'

#machines
alias typ='ssh -X typhoon'
alias t='ssh -X typhoon'
alias hurricane='ssh -X hurricane'
alias hurri='ssh -X hurricane'
alias cyc='ssh -X cyclone'
alias katana='ssh -X z3457920@katana.science.unsw.edu.au'
alias k='ssh -X z3457920@katana.science.unsw.edu.au'
alias tensor='ssh -X z3457920@tensor.maths.unsw.edu.au'
alias adrift='ssh -X chris@115.146.86.89'
alias katint='qsub -I -l nodes=1:ppn=1,vmem=20gb,walltime=1:00:00'
alias s='ssh -X z3457920@squall.ccrc.unsw.edu.au'
alias nci='ssh -X cyb561@raijin.nci.org.au'
alias maelstrom='ssh -X z3457920@maelstrom.ccrc.unsw.edu.au'
alias m='ssh -X z3457920@maelstrom.ccrc.unsw.edu.au'
alias monsoon='ssh -X z3457920@monsoon.ccrc.unsw.edu.au'

#vim
alias hvim='vim scp://z3457920@squall.ccrc.unsw.edu.au//home/z3457920/hdrive/repos/cms_analysis/'
alias hdrivevim='vim scp://z3457920@squall.ccrc.unsw.edu.au//home/z3457920/hdrive/repos/cms_analysis/'
alias vimhdrive='vim scp://z3457920@squall.ccrc.unsw.edu.au//home/z3457920/hdrive/repos/cms_analysis/'
alias hdrive='vim scp://z3457920@squall.ccrc.unsw.edu.au//home/z3457920/hdrive/repos/cms_analysis/'
alias sniped='vi ~/.vim/UltiSnips/python.snippets'

#git alias
alias gittrack='git ls-tree --full-tree -r HEAD'
alias gitb='git branch -a --color=auto'

#for python virtualenv
alias pyt='source ~/env/my_env/bin/activate'  #for storm servers
#alias p='pyt; ipython --pylab'
alias ip='ipython --pylab'
#export PATH=${PATH}:/home/z3457920/env/my_env/bin

alias pyadrift='source ~/env/adrift_env/bin/activate'  #for storm servers

alias pyk='source ~/env/katana_env/bin/activate'   #for katana 


#for Jekyll website
alias jekyllgo='bundle exec jekyll build; bundle exec jekyll serve --watch'  

#cb added
set -o vi



function log() #pbs log file
{
  less $(ls cb_rhomoc_katana.pbs.* |tail -1)
}


function nc() #file header info ncdump
{
  ncdump -c ${1} | less
}


function ncv() #variable info ncdump
{
  ncdump -v ${2} ${1} | less
}

function ll ()
{
clear;
tput cup 0 0;
ls --color=auto -F --color=always -lhFrt;
tput cup 40 0;
}


function pushit() #bash command to push file into hdrive at UNSW
{
rsync -avz ./${1} z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/
}



function makepy ()
{
pipfreeze=$(pip freeze | sed 's/^/##   /')
modulelist_storm=$(module list 2>&1 | sed 's/^/# /')
modulelist_katana=$(module list |& sed 's/^/# /')
cat > ${1}.py <<EOF
##   Author: Christopher Bull. 
##   Affiliation: Climate Change Research Centre and ARC Centre of Excellence for Climate System Science.
##                Level 4, Mathews Building
##                University of New South Wales
##                Sydney, NSW, Australia, 2052
##   Contact: z3457920@student.unsw.edu.au
##   www:     christopherbull.com.au
##   twitter: @@ChrisBullOceanO
##   Date created: $(date)
##   Machine created on: $(hostname)
##

"""
This file is for 

"""


#
#python logging
import logging as lg
import time
#import os

#import sys

#sys.path.insert(1,'/home/z3457920/hdrive/repos/cms_analysis/')
from cb2logger import *

#If you want to log to a file you need to put this before you import swissarmy!
#LogStart(sys.argv[0]+ '.log',fout=True)

#sys.path.insert(1,'/home/z3457920/hdrive/repos/')
#import swissarmy as sa

if __name__ == "__main__":                                     #are we being run directly?
    LogStart('',fout=False)

    #PUT wothwhile code here!

    #sa.mkdir('./blah3/')

    lg.info('')
    localtime = time.asctime( time.localtime(time.time()) )
    lg.info("Local current time : "+ str(localtime))
    lg.info('SCRIPT ended')

EOF
vi ${1}.py
}

