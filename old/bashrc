if [ -d "~/.bashrc_default" ] ; then
    source ~/.bashrc_default
fi

source virtualenvwrapper.sh

export PATH=$PATH:/home/calvin/bin:/home/calvin/.local/bin/:/var/lib/gems/1.8/bin/
touch ~/.bin-paths
while read LINE; do
    export PATH=$PATH:$LINE
done < ~/.bin-paths

setxkbmap us -option compose:lwin
export AWS_HOME=~/.aws
export PATH=$PATH:$AWS_HOME/bin:~/projects/myshell/bin
xmodmap ~/.xmodmap &2> /dev/null
export JAVA_HOME=/usr/
export PYTHONPATH=$PYTHONPATH:~/projects/pandeploy/

alias v=workon
alias v.deactivate=deactivate
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm=rmvirtualenv
alias v.switch=workon
alias v.add2virtualenv=add2virtualenv
alias v.cdsitepackages=cdsitepackages
alias v.cd=cdvirtualenv
alias v.lssitepackages=lssitepackages
alias v.pip="pip -E ~/.virtualenvs/`workon`"

alias ls="ls -1"
alias l="ls -1"
alias ll="ls -1l"

alias t=todo

function add_bin_path() {
    echo $1 >> ~/.bin-paths
}

function set_aws_account() {
    export AWS_ACCESS_KEY_ID=`cat $AWS_HOME/$1/access`
    export AWS_SECRET_ACCESS_KEY=`cat $AWS_HOME/$1/secret`
}

if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export ANDROID_NDK="/opt/android-ndk"
export ANDROID_SDK="/opt/android-sdk"

source /etc/bash_completion

eval $(ssh-agent -s) > /dev/null 2>&1

# Edit commit messages displaying the current diff in the right window
export GIT_EDITOR='vim -c vsplit -c"e SCRATCH" -c"setlocal bt=nofile ft=diff" -c"r!git diff --cached" -c 1'
