#!/bin/bash

echo "start .bashPathInit"

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

# windowsパス追加
if [ "$ORIGINAL_PATH" != "" ]; then
    export PATH="$PATH:$ORIGINAL_PATH"	
fi

echo "@4@$PATH"
echo "end   .bashPathInit"
