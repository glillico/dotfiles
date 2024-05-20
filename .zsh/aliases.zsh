##################
# General aliases
##################
#alias subl="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
alias code='open -a VSCodium'
alias grep="grep --colour --devices=skip"
alias history='history -E'
alias hist='history -E 1'
alias hub='cd ~/Development/GitHub'
alias dev='cd ~/Development'
alias homelab='cd ~/Development/homelab'
if [ -f /opt/homebrew/bin/eza ]; then
  alias ls='eza --icons --group-directories-first --git --header'
  alias ll='eza --icons --group-directories-first --git --header -l'
fi

################
# Play it safe!
################
alias 'rm=rm -i'
alias 'mv=mv -i'
alias 'cp=cp -i'

###############
# Git aliases.
###############
alias ga='git add'
alias gaa='git add --all'

alias gs='git status'
alias gsa='git status -uall'
alias gsb='git status --short --branch'
alias gss='git status --short'

alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -a -m'

alias ggl='git pull origin'
alias ggu='git pull --rebase origin'

alias ggp='git push origin'

alias gbd='git branch -d'
alias gbD='git branch -D'

alias gco='git checkout'
alias gcb='git checkout -b'
alias gcom="git checkout master"

alias gf='git fetch'
alias gfd='git fetch --dry-run'
alias gfp='git fetch -pv'

alias gm='git merge'

alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit -n 10'
alias gla='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gld='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit -n 10'
alias glda='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--WIP--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-WIP\-\-" && git reset HEAD~1'

###################
# Vagrant aliases.
###################
alias vgi="vagrant init"
alias vup="vagrant up"
alias vd="vagrant destroy"
alias vdf="vagrant destroy -f"
alias vssh="vagrant ssh"
alias vh="vagrant halt"
alias vst="vagrant status"
alias vba="vagrant box add"
alias vbr="vagrant box remove"
alias vbl="vagrant box list"
alias vbo="vagrant box outdated"
alias vbu="vagrant box update"

##########################
# mac-dev-playbook alias.
##########################
alias macup='ANSIBLE_CONFIG=~/Development/macup/ansible.cfg ansible-playbook -i ~/Development/macup/inventory ~/Development/macup/main.yml -K'
