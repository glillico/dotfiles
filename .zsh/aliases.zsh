##################
# General aliases
##################
#alias subl="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
alias ..='cd ..'
alias ...='cd ../..'
# alias code='open -a VSCodium'
alias code='codium --profile GL-VSCodium'
alias dev='cd ~/Development'
alias grep='grep --colour --devices=skip'
alias hist='history -E 1'
alias history='history -E'
alias homelab='cd ~/Development/homelab'
alias hub='cd ~/Development/GitHub'
if [ -f /opt/homebrew/bin/eza ]; then
  alias ls='eza --group-directories-first --git --header'
  alias la='eza --group-directories-first --git --header -la'
  alias ll='eza --group-directories-first --git --header -l'
else
  alias la='ls -la'
  alias ll='ls -l'
fi

################
# Play it safe!
################
alias 'cp=cp -i'
alias 'mv=mv -i'
alias 'rm=rm -i'

###############
# Git aliases.
###############
alias ga='git add'
alias gaa='git add --all'
alias gamend='git commit -a --amend --no-edit'
alias gbr='git branch'
alias gbra='git branch -a'
alias gbrd='git branch -d'
alias gbrD='git branch -D'
alias gcdf='git clean -df'
alias gci='git commit'
alias gciam='git commit -a -m'
alias gcim='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcod='git checkout .'
alias gcom='git checkout master'
alias gconf='git config --global --edit'
alias gfe='git fetch'
alias gfed='git fetch --dry-run'
alias gfep='git fetch -pv'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit -n 10'
alias gloga='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias glogd='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit -n 10'
alias glogda='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gme='git merge'
alias gpr='git pull --rebase'
alias gpro='git pull --rebase origin'
alias grh='git reset HEAD'
alias gst='git status -s'
alias gsta='git status'
alias gunwip='git log -n 1 | grep -q -c "\-\-WIP\-\-" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--WIP--"'

###################
# Vagrant aliases.
###################
alias vba='vagrant box add'
alias vbl='vagrant box list'
alias vbo='vagrant box outdated'
alias vbr='vagrant box remove'
alias vbu='vagrant box update'
alias vd='vagrant destroy'
alias vdf='vagrant destroy -f'
alias vgi='vagrant init'
alias vh='vagrant halt'
alias vssh='vagrant ssh'
alias vst='vagrant status'
alias vup='vagrant up'

##########################
# mac-dev-playbook alias.
##########################
alias macup='ANSIBLE_CONFIG=~/Development/macup/ansible.cfg ansible-playbook -i ~/Development/macup/inventory ~/Development/macup/main.yml -K'
