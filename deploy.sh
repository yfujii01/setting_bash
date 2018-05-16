#!/bin/bash

# 展開する(ハードリンク)
# 引数1:ファイル名
# 引数2:展開先ディレクトリ
function create_link () {
	file=${1}
	dir=${2}

    if [ ! -d ${dir} ]; then
		mkdir -p ${dir}
		echo 'mkdir -p '${dir}
	fi

	ln -f ${file} ${dir}/${file}
	echo 'link create '${dir}'/'${file}
}

create_link .bash_profile ~
create_link .bashrc ~
create_link .bashrcImg ~
create_link .bashrcAliases ~
create_link .bashOsCheck ~

# OsCheckの結果がLinuxであれば実行する
if [ `. ~/.bashOsCheck` == 'Linux' ]; then
	create_link .bashrcLinux ~
fi

source ~/.bashrc
