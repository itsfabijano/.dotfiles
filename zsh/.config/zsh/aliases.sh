alias git-delete-merged="git branch -vv \
	| grep "'"'": gone]"'"'" \
	| grep -v "'"'"*"'"'" \
	| awk "'"'"{print $1}"'"'" \
	| xargs -r git branch -d"

alias gcof='git checkout $(git branch --sort=-committerdate | fzf --reverse --height=20% --info=inline)'
