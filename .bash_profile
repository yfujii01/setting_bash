if [ -f $HOME/.bashrc ]; then
	. $HOME/.bashrc
fi

echo "@0@$PATH"
export PATH=/bin:/usr/bin:/usr/local/bin
echo "@1@$PATH"

# GOPATH追加
if [ -e $HOME/go ]; then
	export GOPATH="$HOME/go"
	export PATH="$PATH:$GOPATH/bin"
fi

echo "@2@$PATH"

# fzfパス追加
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

echo "@3@$PATH"

# anyenvパス追加
if [ -e $HOME/.anyenv/bin ]; then
	export PATH="$PATH:$HOME/.anyenv/bin"
	eval "$(anyenv init -)"
fi

echo "@4@$PATH"

# docker起動
if [ 'RH1027' = $(echo $HOSTNAME) ]; then
	echo 'I am RH1027'
	export DOCKER_HOST='tcp://0.0.0.0:2375'
fi

