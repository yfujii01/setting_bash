# 対話型ではない接続の場合はこれ以降を読み込まない
[ -z "$PS1" ] && return

# 起動時imageの読み込み
if [ -f ~/.bashImg ]; then
	COMMENT=【$(date "+%Y-%m-%d (%a)")】
	IFS=">"
	AA=($(sed -e "s/__DATE__/$COMMENT/g" ~/.bashImg))
	NUM=${#AA[*]}
	NO=$(expr $RANDOM % $NUM)
	echo ${AA[$NO]}
else
	echo '~/.bachImgが見つかりません'
fi

# エイリアスの設定
if [ -f ~/.bashAliases.bash ]; then
	. ~/.bashAliases.bash
else
	echo '~/.bachAliasesが見つかりません'
fi

myosname=$(. ~/.bashOsCheck)

# Linuxでのみ必要なスクリプト
if [ $myosname == 'Linux' ]; then
	echo 'I am linux machine!'
	if [ -f ~/.bashLinux.bash ]; then
		. ~/.bashLinux.bash
	fi
fi

# Macでのみ必要なスクリプト
if [ $myosname == 'Mac' ]; then
	if [ -f ~/.bashMac.bash ]; then
		. ~/.bashMac.bash
	fi

	echo 'this is mac'
	alias jenv_java_home='echo "$HOME/.jenv/versions/`jenv version-name`"'
fi

# Windowsでのみ必要なスクリプト
if [ $myosname = 'Win' ]; then
	echo 'i am winpc!'
	if [ -f ~/.bashWindows.bash ]; then
		. ~/.bashWindows.bash
	fi

fi

# GOPATH追加
if [ -e ~/go ]; then
	export GOPATH="~/go"
	export PATH="$PATH:$GOPATH/bin"
fi

# fzfパス追加
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

