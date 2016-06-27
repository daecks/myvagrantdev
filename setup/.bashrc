# Functions
function _update_ps1() {
    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
}

#if [ "$TERM" != "linux" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

## Better PATH printout
function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}

# Aliases
alias jmake='make -j$(nproc)'
alias clang-format="clang-format-3.8"
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias bd=". bd -si"

# Path setup
export STUDIO_JDK=/usr/lib/jvm/java-7-oracle
export PATH=$PATH:/home/vagrant/Android/Sdk/platform-tools
export ANDROID_HOME=/home/vagrant/Android/Sdk
export STAY_OFF_MY_LAWN=1 # Don't let Android build tools control my lovely prompt
