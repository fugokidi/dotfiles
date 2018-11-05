source /usr/share/defaults/etc/profile
PS1="\[\e[1;36m\]\W\[\e[1;31m\]:\[\e[0m\] "
stty -ixon -ixoff # turn off CTRL-S

# tmux uses login shell, source bashrc from .profile

# required for line editing not enabled from emacs shell
set -o vi
# set -o emacs

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

alias desk="cd ~/Desktop/"
alias compute="cd ~/Compute/"
alias write="cd ~/Write/"
alias ..="cd ../"
alias ...="cd ../../"
alias def="/usr/bin/sdcv"
# alias ipext='curl -s http://checkip.dyndns.org/ | grep -o '[0-9][0-9]*.[0-9][0-9]*.[0-9][0-9]*.[0-9]*''
# alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
# alias psgrep='ps aux |grep -v grep |grep -i'

# virtualenv
export WORKON_HOME=~/virtualenvs
export PROJECT_HOME=$HOME/Computing
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
source /usr/bin/virtualenvwrapper_lazy.sh

# set GOPATH explicitly
export GOPATH="$HOME/Computing/gocode"
PATH=$PATH:$GOPATH/bin

PATH=/usr/local/texlive/2018/bin/x86_64-linux:$PATH
INFOPATH=/usr/local/texlive/2018/texmf-dist/doc/info:$INFOPATH
MANPATH=/usr/local/texlive/2018/texmf-dist/doc/man:$MANPATH

PATH=/usr/local/bin:$PATH

# matlab
PATH=/usr/local/MATLAB/R2017a/bin:$PATH

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. /home/changer/anaconda3/etc/profile.d/conda.sh

export HISTTIMEFORMAT="%d/%m/%y %T "
