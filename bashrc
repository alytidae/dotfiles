if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

#export PS1="\u@\H \W \\$ \[$(tput sgr0)\]"

export PS1="\[\033[1;35m\]\u\[\033[1;30m\]@\[\033[1;35m\]\H\[\033[00m\] \W \$ \[$(tput sgr0)\]"

