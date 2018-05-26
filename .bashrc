# 対話型ではない接続の場合はこれ以降を読み込まない
[ -z "$PS1" ] && return

# 起動時imageの読み込み
if [ -f ~/.bashrcImg ]; then
	COMMENT=【`date "+%Y-%m-%d (%a)"`】
	IFS=">"
	AA=(`sed -e "s/__DATE__/$COMMENT/g" ~/.bashrcImg`)
	NUM=${#AA[*]}
	NO=`expr $RANDOM % $NUM`
	echo ${AA[$NO]}
else
	echo '~/.bachrcImgが見つかりません'
fi

# エイリアスの設定
if [ -f ~/.bashrcAliases ]; then
	. ~/.bashrcAliases
else
	echo '~/.bachrcAliasesが見つかりません'
fi

# Linuxでのみ必要なスクリプト(windowsで流しても影響は無い)
if [ -f ~/.bashrcLinux ]; then
	. ~/.bashrcLinux
fi

# # pyenvがインストールされていればパスに追加する
# if [ -e ~/.pyenv ]; then
# 	export PATH="~/.pyenv/bin:$PATH"
# 	eval "$(pyenv init -)"
# 	eval "$(pyenv virtualenv-init -)"
# else
# 	echo "this system is not install pyenv!"
# 	echo "please install pyenv"
# 	echo "install command is this↓"
# 	echo "============================================================"
# 	echo "curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash"
# 	echo "============================================================"
# fi

