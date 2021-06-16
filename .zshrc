SHELL_CONFIG_FILE="~/.zshrc"
ZSH_DISABLE_COMPFIX=true
ZSH_THEME="agnoster"
DEV_FOLDER="~/dev"

export ZSH="/Users/max/.oh-my-zsh"
plugins=(git)
plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
eval "$(fnm env)"

alias src="source $SHELL_CONFIG_FILE"
alias zrc="code $SHELL_CONFIG_FILE"
alias d="cd $DEV_FOLDER"
alias code="code-insiders"

# Wiser ===================== START
alias yfe="yarn frontend extract"
alias yfd="yarn frontend dev"
alias ygd="yarn graphql dev"
alias ywd="yarn workers dev"
alias ssh-runners="ssh root@68.183.206.70"
# Wiser ===================== END

# Git ===================== START
alias gd="git diff"
alias gs="git status"
alias gca="git commit --amend"
alias grs="git reset HEAD~"
alias gbd="git-branch-delete"
alias gcb="git checkout -b $1"
alias gc="git checkout $1"
alias gb="git branch"
alias gl="git log"

clonepr() {
  git fetch origin pull/$1/head:pull-request-$1
}

commit() {
  MESSAGE=$@
  git add --all
  git commit -m "$MESSAGE"
}

push() { git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD); }

pull() {
  if [ $# -eq 0 ]; then
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    echo "No branch name provided... Pulling from origin/$BRANCH"
  else
    BRANCH=$1
  fi
  git pull --rebase --autostash origin $BRANCH
}

alias pp="pull && push"
# Git ===================== END

# Docker ===================== START
alias dkr="docker run --name=$1 --restart on-failure -d $2"
alias dkcl="docker container ls -a"
alias dkcs="docker container stop $1"
alias dkcsa="docker container ls -aq | xargs docker container stop"
alias dkcr="docker container rm $1"
alias dkcra="docker container ls -aq | xargs docker container rm"
alias dkil="docker images"
alias dkir="docker image rm $1"
alias dkira="docker images -aq | xargs docker image rm $1"
# Docker ===================== END

# Kubernetes ===================== START
alias pods="kubectl --all-namespaces=true get pods"
alias watchpods="watch -n1  \"kubectl --all-namespaces=true get pods\""

# forward port from local machine to kubernetes cluster
# kubectl -n redis port-forward service/redis-01-master [localport]:6379
# helm --namespace=production list
# helm --namespace=production rollback graphql => deploy on GitLab

# Airtable Import problem
# kubectl delete -f /Users/max/dev/wiser/manifests/import-job/templates/airtable-import.yaml -n production
# Then with the right commit id in the file...
# kubectl create -f /Users/max/dev/wiser/manifests/import-job/templates/airtable-import.yaml -n production
# Kubernetes ===================== END

# Keyboard speed MAC
# defaults write -g InitialKeyRepeat -int 10
# defaults write -g KeyRepeat -int 1

killProcessOnPort() {
  sudo kill -9 $(sudo lsof -t -i:$1)
}

renameFiles() {
  for f in *.$1; do
    mv -- "$f" "$(basename -- "$f" .$1).$2"
  done
}

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

getSystemTheme() {
  if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == "Dark" ]]; then
    echo "Dark"
  else
    echo "Light"
  fi
}

setSystemTheme() {
  echo -e "\033]50;SetProfile="$1"\a"
}

setSystemTheme $(getSystemTheme)
