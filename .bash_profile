if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PATH="$HOME/.anyenv/bin:$PATH"                                       
eval "$(anyenv init -)"

if [ 'RH1027' == `echo $HOSTNAME` ]; then
	echo 'I am RH1027'
    export DOCKER_HOST='tcp://0.0.0.0:2375'
	#sudo mkdir /mnt/z
	#sudo mount -t drvfs Z: /mnt/z
fi
