# 対話型ではない接続の場合はこれ以降を読み込まない
[ -z "$PS1" ] && return
echo 'work start!!'

myosname=$(. $HOME/.bashOsCheck.bash)

# エイリアスの設定
if [ -f $HOME/.bashAliases.bash ]; then
	. $HOME/.bashAliases.bash
else
	echo "$HOME/.bachAliasesが見つかりません"
fi
echo 'now workig..'

# Linuxでのみ必要なスクリプト
if [ $myosname = 'Linux' ]; then
	echo 'I am linux machine!'
	if [ -f $HOME/.bashLinux.bash ]; then
		. $HOME/.bashLinux.bash
	fi
fi

# Macでのみ必要なスクリプト
if [ $myosname = 'Mac' ]; then
	if [ -f $HOME/.bashMac.bash ]; then
		. $HOME/.bashMac.bash
	fi

	echo 'this is mac'
	alias jenv_java_home='echo "$HOME/.jenv/versions/`jenv version-name`"'
fi
echo 'now workig....'
# Windowsでのみ必要なスクリプト
if [ $myosname = 'Win' ]; then
	echo 'i am winpc!'
	if [ -f $HOME/.bashWindows.bash ]; then
		. $HOME/.bashWindows.bash
	fi

fi

# PATHの設定
if [ -f $HOME/.bashPathInit.bash ]; then
	. $HOME/.bashPathInit.bash
fi

# docker起動
if [ 'RH1027' = $(echo $HOSTNAME) ]; then
	echo 'I am RH1027'
	export DOCKER_HOST='tcp://0.0.0.0:2375'
fi

echo "TERM=$TERM"

# 起動時imageの読み込み
if [ -f $HOME/.bashImg ]; then
	COMMENT=【$(date "+%Y-%m-%d (%a)")】
	IFS=">"
	AA=($(sed -e "s/__DATE__/$COMMENT/g" $HOME/.bashImg))
	NUM=${#AA[*]}
	NO=$(expr $RANDOM % $NUM)
	echo ${AA[$NO]}
else
	echo "$HOME/.bachImgが見つかりません"
fi
