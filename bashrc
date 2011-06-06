source virtualenvwrapper.sh

export PATH=$PATH:/home/calvin/.local/bin/:/var/lib/gems/1.8/bin/
setxkbmap us -option compose:lwin
xmodmap ~/.xmodmap
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
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

function set_aws_account() {
    export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-$1.pem`
    export EC2_CERT=`ls $EC2_HOME/cert-$1.pem`
    source ~/.ec2/env-$1.sh
}

if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
