# 対話型ではない接続の場合はこれ以降を読み込まない
[ -z "$PS1" ] && return

# 起動時AAの読み込み
if [ -f ~/.aa ]; then
    COMMENT=【`date "+%Y-%m-%d (%a)"`】
    IFS=">"
    AA=(`sed -e "s/__DATE__/$COMMENT/g" ~/.aa`)
    NUM=${#AA[*]}
    NO=`expr $RANDOM % $NUM`
    echo ${AA[$NO]}
fi

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# あなたが作業しているchrootを識別する変数を設定します（以下のプロンプトで使用されます）
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    if [[ ${EUID} == 0 ]] ; then
#        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
#    else
#        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
#    fi
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
#fi
#unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
# lsのカラーサポートを有効にし、便利なエイリアスを追加する
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#fi


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# プログラム可能な補完機能を有効にします（有効にする必要はありません
# これが/etc/bash.bashrcと/ etc / profileですでに有効になっている場合
# sources /etc/bash.bashrc）。
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# git-bash style
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi
#if [ -f /etc/bash_completion.d/git-prompt ]; then
#    export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '
#else
#    export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w \n\[\033[01;34m\]\$\[\033[00m\] '
#fi

