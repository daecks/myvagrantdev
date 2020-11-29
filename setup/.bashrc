# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Define some functions for shell and path management
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Adds to the $PATH variable, if path not already present
# Default is to prepend to $PATH
# Add "after" to append to $PATH
function pathmunge(){
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

## Better PATH printout, with each path variable
## on its own line
function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}

# Only add a welcome prompt for non-SSH connections. 
# Any prompts on SSH connections will cause the vagrant script to barf.
if [ ! -n "${SSH_CONNECTION}" ]; then
    echo -e "This is BASH ${BASH_VERSION%.*}\n"
    date

    if [ -x /usr/games/fortune ]; then
        /usr/games/fortune /usr/games/fortunes | /usr/games/cowsay # Makes our day a bit more fun.... :-)
    fi
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
    . /usr/share/bash-completion/completions/git
fi

function_exists() {
    declare -f -F '$1' > /dev/null
    return $?
}

# Allows a "g" to be put in front of any aliases defined in, or referenced by, the .gitconfig file
for al in `__git_aliases`; do
    alias g$al="git $al"

    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_func && __git_complete g$al $complete_func
done

# Aliases
alias g='git'
alias jmake='make -j$(nproc)'
alias clang-format="clang-format-3.8"
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias bd=". bd -si"
eval "$(thefuck --alias)"

# Path setup
export STUDIO_JDK=/usr/lib/jvm/java-7-oracle
export JAVA_HOME=/usr/lib/jvm/java-7-oracle
pathmunge /home/vagrant/Android/Sdk/platform-tools
pathmunge /snap/bin
export ANDROID_HOME=/home/vagrant/Android/Sdk
export STAY_OFF_MY_LAWN=1 # Don't let Android mess with the prompt

# Use cd -- to view directory history list
# Use cd -<num> to choose that directory
if [ -e $HOME/bin/acd_func.sh ]; then
    source $HOME/bin/acd_func.sh
fi

# The below will save history from multiple terminal sessions
# Maximum number of history lines in memory
export HISTSIZE=50000
# Maximum number of history lines on disk
export HISTFILESIZE=50000
# Ignore duplicate lines
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file
#  instead of overwriting it
shopt -s histappend

# After each command, append to the history file
# and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Fuzzyfind options
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.fzf.commands ] && source ~/.fzf.commands
# Use ripgrep for faster search
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Use bat to preview found files
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
# Use tree to show directory structure
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
bind -x '"\C-p": vim $(fzf);'

#pathmunge /home/vagrant/.pyenv/bin
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

