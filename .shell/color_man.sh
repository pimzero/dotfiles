#!/bin/sh

# echo '#env' >less
# echo LESS_TERMCAP_mb=$'\E[01;31m' >>less
# echo LESS_TERMCAP_md=$'\E[01;38;5;74m' >>less
# echo LESS_TERMCAP_me=$'\E[0m' >>less
# echo LESS_TERMCAP_se=$'\E[0m' >>less
# echo LESS_TERMCAP_so=$'\E[38;5;246m' >>less
# echo LESS_TERMCAP_ue=$'\E[0m' >>less
# echo LESS_TERMCAP_us=$'\E[04;38;5;146m' >>less
# lesskey -o ~/.lesskey_man less

man() {
    #env LESS_TERMCAP_mb=$'\E[01;31m' \
    #LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    #LESS_TERMCAP_me=$'\E[0m' \
    #LESS_TERMCAP_se=$'\E[0m' \
    #LESS_TERMCAP_so=$'\E[38;5;246m' \
    #LESS_TERMCAP_ue=$'\E[0m' \
    #LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    #man "$@"

    env LESSKEY="$HOME/.lesskey_man" \
    man "$@"

}
