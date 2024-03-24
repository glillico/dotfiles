###########
# Set PATH
###########
arch_platform="$(uname -s)"
if [ ${arch_platform} = "Darwin" ]
then
  export PATH=/opt/homebrew/bin:$PATH
fi

# Activate 'ansible' python virtual environment.
if [ -f ~/Development/Python_VENVs/venv/bin/activate ]
then
  source ~/Development/Python_VENVs/venv/bin/activate
fi

# Colour output on Mac OS
unset LSCOLORS
export CLICOLOR=1
# Removed due to breaking some command line scripting.
#export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Prompt
arch_platform="$(uname -s)"
if [ ${arch_platform} = "Darwin" ]; then
  if [ ${TERM_PROGRAM} = "WarpTerminal" ]; then
    # MYPROMPT=$'\n''%(?.%F{green}.%F{red}) %*%f %F{blue}%3~%f%b'
    MYPROMPT=$'\n''%F{green} %*%f %F{blue}%3~%f%b'
  elif [ ${TERM_PROGRAM} = "vscode" ]; then
    MYPROMPT=$'\n''%F{green} %*%f %F{blue}%3~%f%b'$'\n''%# '
  else
    MYPROMPT=$'\n''%(?.%F{green}.%F{red}) %*%f %F{blue}%3~%f%b'$'\n''%# '
  fi
else
  MYPROMPT=$'\n''%(?.%F{green}.%F{red})%n@%m %f%3~%f%b'$'\n''%# '
fi
PROMPT=${MYPROMPT}

###########
# Homebrew
###########
# Only autoupdate homebrew once a week
export HOMEBREW_AUTO_UPDATE_SECS=604800
# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
  share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
  share_path="/opt/homebrew/share"
elif [ "${arch_name}" = "aarch64" ]; then
  share_path="/usr/local/share"
else
  echo "Unknown architecture: ${arch_name}"
fi

# Allow history search via up/down keys
if [ -f ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh ]
then
  source ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[OA' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OB' history-substring-search-down
fi

# Settings for history.
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|history|nf|hist|history 0)"
HISTSIZE=50000
SAVEHIST=100000
if [ ${arch_platform} = "Linux" ]
then
  HISTFILE=~/.zsh_history
fi
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
zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%c%u%m'
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

#########
# Docker
#########
# set default docker build to use --progress=plain
export BUILDKIT_PROGRESS=plain

##############
# Completions
##############
# Include ~/.zsh/completions.zsh file if available.
if [ -f ~/.zsh/completions.zsh ]
then
  source ~/.zsh/completions.zsh
fi

##########
# Aliases
##########
# Include ~/.zsh/aliases.zsh file if available.
if [ -f ~/.zsh/aliases.zsh ]
then
  source ~/.zsh/aliases.zsh
fi

############
# Functions
############
# Include ~/.zsh/functions.zsh file if available.
if [ -f ~/.zsh/functions.zsh ]
then
  source ~/.zsh/functions.zsh
fi

####################### 
# Local customisations
#######################
# Include ~/.zsh/local.zsh file if available.
if [ -f ~/.zsh/local.zsh ]
then
  source ~/.zsh/local.zsh
fi
