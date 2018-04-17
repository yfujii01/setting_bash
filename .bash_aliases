# mint
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sshpi='ssh pi@0.tcp.ap.ngrok.io -p'
alias g='grep'

#git関連
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
