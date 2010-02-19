export PATH=$PATH:/home/calvin/.local/bin/
setxkbmap us -option compose:lwin
xmodmap ~/.xmodmap
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
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
v 0

