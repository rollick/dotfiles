#!/bin/bash
PROMPT_STYLE="multiline"

PS1=":"

if [[ "$PROMPT_STYLE" == "basic" ]]; then
    promptinit
    prompt walters
fi

aC() {
    echo -ne "$FG[$1]"
}

################################################################################
# Prompt
################################################################################
if [[ "$PROMPT_STYLE" == "oneline" ]]; then
    precmd() {
        ERR="$?"
        VENV=$(echo $VIRTUAL_ENV|rev|cut -f1 -d'/'|rev)
        [[ ! -z $VENV ]] && VENV="[%{$fg[green]%}$VENV%{$reset_color%}]"
        HOSTNAME=$(hostname)
        if [[ "$ERR" != "0" ]]; then
            set_title "$USER@$HOST [$PWD] E:$ERR"
        else
            set_title "$USER@$HOST [$PWD]"
        fi
        PROMPT="$VENV%u%B%{$fg[green]%}:%{$reset_color%}%b"
        RPROMPT="(%{$fg[green]%}$HOSTNAME%{$reset_color%})-(%{$fg[green]%}%~%{$reset_color%})"
    }
fi

# source ~/.zsh/helpers.sh

if [[ "$PROMPT_STYLE" == "multiline" ]]; then
    # Colors
    LC=239
    IC=070
    NC=076
    WC=196
    AC=118

    precmd() {
        ERR=$?
        if [[ "$ERR" != "0" ]]; then
            ERR="$(aC $WC)$ERR"
        else
            ERR="-"
        fi

        # Show virtual environment
        VENV=$(echo $VIRTUAL_ENV|rev|cut -f1 -d'/'|rev)
        [[ ! -z "$VENV" ]] && VENV="❨$VENV❩"

        # Show branch name
        d=$(pwd)
        INGIT=false
        while [[ ! -z "$d" ]] && [[ "$d" != "/" ]]; do
            [[ -d "$d"/.git ]] && INGIT=true && break
            d=${d%/*}
        done
        GBRANCH="-"
        if [[ $INGIT == true ]]; then
            GBRANCH=$(git branch|grep '^*'|cut -f2 -d' ')
            if [[ "$GBRANCH" == "master" ]]; then
                GBRANCH="M"
            else
                GBRANCH="$GBRANCH"
            fi
            GBRANCH="$(aC $NC)$(basename `git rev-parse --show-toplevel`)$(aC $LC)/$(aC $AC)$GBRANCH"
        fi

        # print -n "\033[s"
        # print -nrP "$(aC $LC)"
        # for (( i = 0; i < $[$COLUMNS-1]; i++ )); do
        #     print -nrP "─"
        # done
        # print -nrP "╼"
        # print -n "\033[u"

print -rP "$(aC $LC)╾─\
$(aC $LC)❨$(aC $IC)%*$(aC $LC)❩──\
$(aC $LC)❨$(aC 118)$(hostname)$(aC $LC)❩─\
$(aC $LC)❨$(aC $IC)$GBRANCH$(aC $LC)❩─\
$(aC $LC)❨$(aC $IC)%~$(aC $LC)❩─\
$(aC $LC)❨$(aC $IC)$ERR$(aC $LC)❩─\
╼"
    }
    PROMPT=""
    RPROMPT=""
fi
