#!/bin/bash

echo "start .bashPathInit"

echo "@0@$PATH"
# windowsの場合は使用するコンソールによって(？)windowsのパスが引き継がれたり引き継がれなかったりする
if [ ! $myosname = 'Win' ]; then
	export PATH=/bin:/usr/bin:/usr/local/bin
	export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
	export PATH="$PATH:/snap/bin"
fi
echo "@1@$PATH"

# GOPATH追加
if [ -e $HOME/go ]; then
	export GOPATH="$HOME/go"
	export PATH="$PATH:$GOPATH/bin"
fi

echo "@2@$PATH"

# fzfパス追加
if [ -f $HOME/.fzf.bash ]; then
	source $HOME/.fzf.bash
fi

echo "@3@$PATH"

# anyenvパス追加
if [ -e $HOME/.anyenv/bin ]; then
	export PATH="$PATH:$HOME/.anyenv/bin"
	eval "$(anyenv init -)"
fi

echo "@4@$PATH"
echo "end   .bashPathInit"
