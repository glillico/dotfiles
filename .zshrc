# Set PATH
PATH=~/Documents/Development/Python_VENVs/ansible-current/bin:$PATH

# Colour output on Mac OS
unset LSCOLORS
export CLICOLOR=1
# Removed due to breaking some command line scripting.
#export CLICOLOR_FORCE=1
export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Prompt
if [ $(uname -s) = Darwin ]
then
  PROMPT=$'\n''%(?.%F{green}.%F{red}) %*%f %F%3~%f%b'$'\n''%# '
else
  PROMPT=$'\n''%(?.%F{green}.%F{red})%n@%m %*%f %F%3~%f%b'$'\n''%# '
fi

# Allow history search via up/down keys
if [ -f /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]
then
  source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# Settings for history.
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|history|nf|hist|history 0)"
HISTSIZE=50000
SAVEHIST=100000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# git branch prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F(%b)%c%u%m'
zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}S%F'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}M%F'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='%F{red}U%F'
  fi
}

# Only autoupdate homebrew once a week
export HOMEBREW_AUTO_UPDATE_SECS=604800

##########
# Aliases
##########
# Include .aliases file if available.
if [ -f ~/.aliases ]
then
  source ~/.aliases
fi

# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
    share_path="/opt/homebrew/share"
else
    echo "Unknown architecture: ${arch_name}"
fi

############
# Functions
############

# Show contents of known_hosts file with line numbers
knownls() {
 nl -b a ~/.ssh/known_hosts
}

# Delete a given line number in the known_hosts file
knownrm() {
 re='^[0-9]+$'
 if ! [[ $1 =~ $re ]] ; then
   echo "error: line number missing" >&2;
 else
   sed -i '' "$1d" ~/.ssh/known_hosts
 fi
}

# nf [-NUM] [COMMENTARY...] -- never forget last N commands
nf() {
  local n=-5
  [[ "$1" = -<-> ]] && n=$1 && shift
  fc -lnt ": %Y-%m-%d %H:%M ${*/\%/%%} ;" $n | tee -a ~/.neverforget
}

# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [centos7|fedora27|debian9|debian8|ubuntu1404|etc.]
dockrun() {
 docker run -it glillico/docker-"${1:-ubuntu2004}"-ansible /bin/bash
}

# Enter a running Docker container.
function denter() {
 if [[ ! "$1" ]] ; then
     echo "You must supply a container ID or name."
     return 0
 fi

 docker exec -it $1 bash
 return 0
}
