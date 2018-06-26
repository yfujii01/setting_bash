#!/bin/bash

# 展開する(ハードリンク)
# 引数1:ファイル名
# 引数2:展開先ディレクトリ
function create_link() {
	file=${1}
	dir=${2}

	if [ ! -d ${dir} ]; then
		mkdir -p ${dir}
		echo 'mkdir -p '${dir}
	fi

	ln -f ${file} ${dir}/${file}
	echo 'link create '${dir}'/'${file}
}

bash_deploy() {
	echo '今からデプロイします'
	ls -a1 | grep bash | while read line; do
		echo $line'をコピーするよ'
		create_link $line $HOME
	done
	echo 'ふぃにっしゅ'
}

bash_deploy
. $HOME/.bash_profile
