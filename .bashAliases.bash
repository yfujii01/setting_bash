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
alias ga='git add .'
alias gc='git commit'
alias gp='git push origin HEAD'
alias gd='git diff --name-only '
alias gdw='git difftool -y -d -t default-difftool'
alias gdm='git difftool -t meld -d'
alias gdv='git difftool -t vimdiff'
alias gk='gitk --all --date-order'                                 # --simplify-by-decoration をつけると個別のコミットが隠れる
alias gl='git log --oneline --graph --decorate --all --date-order' # --simplify-by-decoration をつけると個別のコミットが隠れる
alias gconf='git config -l'
#gitコンボ
alias gsd='echo "------ git status ------";gs;echo "------ git diff --name-only ------";gd'
alias gac='git add .;git commit'
alias gacp='git add .;git commit;git push origin HEAD'

# 全てのリモートブランチをローカルに作成する
alias gba='for remote in `git branch -r`; do if [ $remote != "origin/HEAD" ] && [ $remote != "->" ]; then git branch --track ${remote#origin/} $remote; fi done'

# クリップボードへコピー(動かない)
alias pbcopy='xsel --clipboard --input'

alias dockerps="docker ps -a | awk '{print \$1}' | tail -n +2"
alias dockerimages="docker images | awk '{print \$3}' | tail -n +2"
alias dockerrm="dockerps|xargs docker stop&&dockerps|xargs docker rm"
alias dockerrmi="dockerps|xargs docker stop&&dockerps|xargs docker rm&&dockerimages|xargs docker rmi"

alias sshgce="ssh fancl01@gce"

alias ee='exec $SHELL -l'

# localのgitリポジトリに移動
alias gcd='cd $(ghq root)/$(ghq list | peco)'

# githubのリポジトリに移動
alias ghcd1='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
#alias ghcd='ghq list | peco | cut -d "/" -f 2,3 | xargs hub browse'
#alias ghcd='ghls | peco | cut -d "/" -f 2,3 | xargs hub browse'
alias ghcd='ghls2 | peco | cut -d "/" -f 2,3 | xargs hub browse'

# githubのリポジトリ一覧
alias ghls='curl -s "https://api.github.com/users/yfujii01/repos?per_page=100"|grep \"name\"|cut -d'\''"'\'' -f4'
alias ghls2='curl -s "https://api.github.com/users/yfujii01/repos?per_page=100"|grep \"name\"|cut -d'\''"'\'' -f4 | sed -e s#^#github.com/yfujii01/#g'

# githubのリポジトリをcloneする
alias ghget='ghls|peco --select-1|xargs ghq get'

# historyをpecoで
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

function peco_ssh() {
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

alias s='$(peco_ssh | peco)| xargs ssh'

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
