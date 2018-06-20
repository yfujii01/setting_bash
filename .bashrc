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

# Macでのみ必要なスクリプト
if [ `. ~/.bashOsCheck` == 'Mac' ]; then
	if [ -f ~/.bashLinux ]; then
		. ~/.bashLinux
	fi

	echo 'this is mac'
	#alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'
	alias jenv_java_home='echo "$HOME/.jenv/versions/`jenv version-name`"'
fi

# Windowsでのみ必要なスクリプト
if [ `. ~/.bashOsCheck` == 'Win' ]; then
	if [ -f ~/.bashWindows ]; then
		. ~/.bashWindows
	fi
fi

