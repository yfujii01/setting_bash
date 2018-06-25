#!/bin/bash

echo '.bashAlias start!!'

alias ll='ls -alF'
alias la='ls -alF'
alias l='ls -alF'
alias sshpi='ssh pi@0.tcp.ap.ngrok.io -p'
alias sftppi='echo "sftp -P xxxx pi@0.tcp.ap.ngrok.io"'
alias g='grep'

alias volume='amixer sset Speaker'

alias e='emacs'

#git関連
alias gf='git fetch'
alias gs='git status --short'
alias ga='gadd'
alias gp='git push origin HEAD'
alias gd='git diff --name-only '
alias gdw='git difftool -y -d -t default-difftool'
alias gdm='git difftool -t meld -d'
alias gdv='git difftool -t vimdiff'
alias gk='gitk --all --date-order'                                 # --simplify-by-decoration をつけると個別のコミットが隠れる
alias gl='git log --oneline --graph --decorate --all --date-order' # --simplify-by-decoration をつけると個別のコミットが隠れる
alias gconf='git config -l'

function gc() {
	local mes=$1
	if [ -z $mes ]; then
		git commit
	else
		git commit -m $mes
	fi
}
# git addしてcommitする。パラメータがあればコミットメッセージとして扱う
function gac() {
	# gadd
	fnc_gadd
	gc $1
}

# git addしてcommitしてpushする。パラメータがあればコミットメッセージとして扱う
function gacp() {
	gac $1
	git push origin HEAD
}

# 全てのリモートブランチをローカルに作成する
alias gba='for remote in `git branch -r`; do if [ $remote != "origin/HEAD" ] && [ $remote != "->" ]; then git branch --track ${remote#origin/} $remote; fi done'

# クリップボードへコピー(動かない)
alias pbcopy='xsel --clipboard --input'

alias dockerps="docker ps -a | awk '{print \$1}' | tail -n +2"
alias dockerimages="docker images | awk '{print \$3}' | tail -n +2"
alias dockerrm="dockerps|xargs docker stop&&dockerps|xargs docker rm"
alias dockerrmi="dockerps|xargs docker stop&&dockerps|xargs docker rm&&dockerimages|xargs docker rmi"

alias ee='exec $SHELL -l'

# localのgitリポジトリに移動
alias gcd='fnc_gcd'
function fnc_gcd() {
	local val=$(ghq list | FILTER_S)
	[ -z $val ] && return
	cd $(ghq root)/$val
}

echo 'fzf setting!'
# 対話モード
if [ $myosname = 'Win' ]; then
	# windows版では--heightがサポートされていない。。。
	echo 'fzf setting win'
	alias FILTER_S='fzf --cycle --reverse --border --inline-info'
else
	echo 'fzf setting nowin'
	alias FILTER_S='fzf --cycle --reverse --border --inline-info --height 80%'
fi
alias FILTER_M='FILTER_S -m'
alias FILTER_S_REVERSE='FILTER_S --tac'
alias FILTER_M_REVERSE='FILTER_M --tac'
echo 'fzf setting!!'

# githubから対話形式でcloneする
alias ghget='fnc_ghget'
function fnc_ghget() {
	echo 'githubからcloneします。複数選択可能(TAB)'
	local aa=$(curl -s "https://api.github.com/users/yfujii01/repos?per_page=100")
	local bb=$(echo $aa | grep \"name\")
	local cc=$(echo $bb | cut -d'"' -f4)
	local val=$(echo $cc | FILTER_M)
	[ -z $val ] && return
	echo $val | while read line; do
		echo 'ghq get -p '$line
		ghq get -p yfujii01/$line
	done
}

# 対話形式でgit addする
alias gadd='fnc_gadd'
function fnc_gadd() {
	echo 'git addします。複数選択可能(TAB)'
	local aa=$(git status -s)
	local bb=$(echo $aa | FILTER_M)
	[ -z $bb ] && return
	local cc=$(echo $bb | sed s/^...//g)
	echo $cc | while read line; do
		# echo $line
		git add $line
	done
	echo 'git addしました \^o^/'
	git status -s
}

# .bashrc展開
rr() {
	local now=$(pwd)
	cd $(ghq root)/github.com/yfujii01/setting_bash
	. deploy.sh
	exec $SHELL -l
}

# historyを対話形式で
his() {
	echo '選択したコマンドを実行します。キャンセルはesc'
	local aaa=$(history | FILTER_S_REVERSE)
	[ -z $aaa ] && return
	local bbb=$(echo $aaa | sed -E 's/^ +[0-9]+ +//')
	echo $bbb'を実行します'
	eval $bbb
}

export HISTCONTROL="ignoredups"
peco-history() {
	local NUM=$(history | wc -l)
	local FIRST=$((-1 * (NUM - 1)))

	if [ $FIRST -eq 0 ]; then
		history -d $((HISTCMD - 1))
		echo "No history" >&2
		return
	fi

	local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

	if [ -n "$CMD" ]; then
		#キーをコマンドラインに表示(macでしか動かない)
		history -s $CMD
		if type osascript >/dev/null 2>&1; then
			(osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
		fi
	else
		history -d $((HISTCMD - 1))
	fi
}
_replace_by_history() {
	local l=$(HISTTIMEFORMAT= history | tac | sed -e 's/^\s*[0-9]\+\s\+//' | peco --query "$READLINE_LINE")

	# bind -x で呼び出した場合にはコマンドラインに表示できる
	READLINE_LINE="$l"
	READLINE_POINT=${#l}

	#キーをコマンドラインに表示(macでしか動かない)
	history -s $l
	if type osascript >/dev/null 2>&1; then
		(osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
	fi
}
# bind -x '"\C-r": _replace_by_history'

alias h='_replace_by_history'

function sshlist() {
	awk '
    tolower($1)=="host" {
      for(i=2;i<=NF; i++) {
        if ($i !~ "[*?]") {
          print $i
        }
      }
    }
  ' ~/.ssh/config
}

# .ssh/configの内容から選択してsshする
function sshfilter() {
	val=$(sshlist | FILTER_S)
	[ -z $val ] && return
	ssh $val
}

# git branchの一覧(ブランチ名のみ)
function git_branch_list() {
	git branch | awk '{
        if (gsub(/^.+ /,""))  print
    }'
}

# git branchをインタラクティブに選択
function __git_checkout_peco() {
	local val=$(git_branch_list | peco)
	if [ -z $val ]; then
		# 戻り値無し(ESCで抜けた)
		echo 'exit'
		return
	fi
	echo $val'をcheckoutします'
	git checkout $val
}
function git_checkout_peco() {
	local val1=$(git branch | peco)
	local val2=$(echo $val1 | awk '{if(gsub(/^.+ /,""))print}')

	# 画面表示をクリア(たまにpecoの残像が残る)
	clear

	if [ -z $val2 ]; then
		# 戻り値無し(ESCで抜けた)
		echo 'exit'
		return
	fi
	echo $val2'をcheckoutします'
	git checkout $val2
}

alias gcheck='git checkout $(git branch|peco)'
