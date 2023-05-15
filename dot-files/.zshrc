# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'l:|=* r:|=*' 'r:|[._-]=** r:|=**' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/claykoi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/miniconda3/etc/profile.d/conda.sh" ]; then
        . "~/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="~/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### Personal .zshrc Lines

eval $(ssh-agent -s) > /dev/null 2>&1

TERM=xterm-256color
path=(
    $path
    /var/lib/gems/1.8/bin/
    ~/bin
    ~/.local/bin/
    ~/projects/myshell/bin/
    ./node_modules/.bin/
)

. $(which virtualenvwrapper.sh)

if [[ -r ~/.aliasrc ]]; then
. ~/.aliasrc
fi

export GIT_EDITOR='vim -c vsplit -c"e SCRATCH" -c"setlocal bt=nofile ft=diff" -c"r!git diff --cached" -c 1'

# Local, unshared zsh environment setup
if [ -f ~/.bash_local ]; then
    source ~/.zshrc.local
fi

# If present, .bin-paths defines machine-local paths to add to PATH
if [ -f ~/.bin-paths ]; then
    while read LINE; do
        export PATH=$PATH:$LINE
    done < ~/.bin-paths
fi

# Setup starship prompt customizer
eval "$(starship init zsh)"
