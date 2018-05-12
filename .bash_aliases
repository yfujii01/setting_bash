alias ll='ls -alF'
alias la='ls -A1'
alias l='ls -1'
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
alias gk='gitk --all --date-order' # --simplify-by-decoration をつけると個別のコミットが隠れる
alias gl='git log --oneline --graph --decorate --all --date-order' # --simplify-by-decoration をつけると個別のコミットが隠れる
alias gconf='git config -l'
#gitコンボ
alias gsd='echo "------ git status ------";gs;echo "------ git diff --name-only ------";gd'
alias gac='git add .;git commit'
alias gacp='git add .;git commit;git push origin HEAD'

# 全てのリモートブランチをローカルに作成する
alias gba='for remote in `git branch -r`; do if [ $remote != "origin/HEAD" ] && [ $remote != "->" ]; then git branch --track ${remote#origin/} $remote; fi done'
