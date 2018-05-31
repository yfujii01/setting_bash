# 対話型ではない接続の場合はこれ以降を読み込まない
[ -z "$PS1" ] && return

# 起動時imageの読み込み
if [ -f ~/.bashImg ]; then
	COMMENT=【`date "+%Y-%m-%d (%a)"`】
	IFS=">"
	AA=(`sed -e "s/__DATE__/$COMMENT/g" ~/.bashImg`)
	NUM=${#AA[*]}
	NO=`expr $RANDOM % $NUM`
	echo ${AA[$NO]}
else
	echo '~/.bachImgが見つかりません'
fi

# エイリアスの設定
if [ -f ~/.bashAliases ]; then
	. ~/.bashAliases
else
	echo '~/.bachAliasesが見つかりません'
fi

# Linuxでのみ必要なスクリプト
if [ `. ~/.bashOsCheck` == 'Linux' ]; then
	if [ -f ~/.bashLinux ]; then
		. ~/.bashLinux
	fi
fi

# Windowsでのみ必要なスクリプト
if [ `. ~/.bashOsCheck` == 'Win' ]; then
	if [ -f ~/.bashWindows ]; then
		. ~/.bashWindows
	fi
fi

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

